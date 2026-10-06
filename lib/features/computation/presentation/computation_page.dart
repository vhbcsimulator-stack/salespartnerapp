import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/contact_service.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../inventory/models/lot_model.dart';
import '../../inventory/models/mvlc_price_model.dart';
import '../../inventory/models/project_model.dart';
import '../../map/models/map_lot_model.dart';
import '../models/computation_result_model.dart';
import '../models/payment_scheme_model.dart';
import '../models/project_discount_model.dart';
import '../services/computation_service.dart';

/// Multi-Project Price Computation Module for VHBC Broker App.
/// Supports ERHD, MVLC, and other VHBC developments with dynamic pricing,
/// project-specific payment schemes, discounts, terms, and snapshot saving.
class ComputationPage extends StatefulWidget {
  final MapLotModel? lot;
  final LotModel? lotModel;
  final List<ProjectModel>? initialProjects;
  final PaymentSchemeModel? initialScheme;
  final String? initialSchemeCode;

  const ComputationPage({
    super.key,
    this.lot,
    this.lotModel,
    this.initialProjects,
    this.initialScheme,
    this.initialSchemeCode,
  });

  @override
  State<ComputationPage> createState() => _ComputationPageState();
}

class _ComputationPageState extends State<ComputationPage> {
  final _currencyFmt = NumberFormat.currency(
    symbol: '₱',
    decimalDigits: 0,
    locale: 'en_PH',
  );

  final _scrollController = ScrollController();
  final _resultKey = GlobalKey();

  // Project State
  List<ProjectModel> _availableProjects = [];
  ProjectModel? _selectedProject;
  String _projectCode = '';
  bool _isLoadingProjects = false;
  bool get _isMscc => (_projectCode.isNotEmpty ? _projectCode : (widget.lotModel?.project ?? '')).toUpperCase().contains('MSCC');

  // Lot State
  List<LotModel> _projectLots = [];
  bool _isLoadingLots = false;
  LotModel? _selectedLot;
  bool _isManualLot = false;

  // Lot Details
  final TextEditingController _blockCtrl = TextEditingController();
  final TextEditingController _lotNumCtrl = TextEditingController();
  final TextEditingController _lotSizeCtrl = TextEditingController();
  int? _selectedPhase = 2;
  String _selectedLotType = 'Regular';
  List<String> _availableLotTypes = [];
  double _pricePerSqm = 0.0;
  List<MvlcPriceModel> _mvlcPrices = [];
  List<ProjectDiscountModel> _projectDiscounts = [];

  // Payment Options State
  List<PaymentSchemeModel> _paymentSchemes = [];
  PaymentSchemeModel? _selectedScheme;

  // Calculation Result State
  ComputationResultModel? _computationResult;
  bool _isFullComputationExpanded = false;
  bool _isCalculating = false;

  // Saved Computations in memory
  final List<ComputationResultModel> _savedComputations = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _blockCtrl.dispose();
    _lotNumCtrl.dispose();
    _lotSizeCtrl.dispose();
    super.dispose();
  }

  /// Initial data load.
  /// If opened from Map or Inventory with a pre-selected lot, initialize with that lot's project.
  /// Otherwise, do NOT select any project by default.
  Future<void> _loadInitialData() async {
    setState(() => _isLoadingProjects = true);

    try {
      List<ProjectModel> resolvedProjects;
      List<MvlcPriceModel> mvlcPrices = [];
      List<ProjectDiscountModel> projectDiscounts = [];

      if (widget.initialProjects != null && widget.initialProjects!.isNotEmpty) {
        resolvedProjects = widget.initialProjects!;
      } else {
        final projects = await SupabaseService.fetchProjects();
        mvlcPrices = await SupabaseService.fetchMvlcPrices();
        resolvedProjects = projects;
      }

      try {
        projectDiscounts = await SupabaseService.fetchProjectDiscounts();
      } catch (_) {
        projectDiscounts = SupabaseService.cachedProjectDiscounts;
      }

      if (resolvedProjects.isEmpty) {
        resolvedProjects = const [
          ProjectModel(
            id: '1',
            code: 'MVLC',
            name: 'Mountain View Leisure Community',
          ),
          ProjectModel(
            id: '2',
            code: 'ERHD',
            name: 'Eastwest Resort Hub and Development',
          ),
        ];
      }

      // Exclude projects that are not eligible for the calculator (paused / soon-to-rise, EBLF, etc.)
      resolvedProjects = resolvedProjects
          .where((p) =>
              !p.paused &&
              ComputationService.isProjectEligibleForCalculator(
                p.code,
                p.displayName,
                paused: p.paused,
              ))
          .toList();

      // Deduplicate projects by normalized code / displayName
      final seenCodes = <String>{};
      final uniqueProjects = <ProjectModel>[];
      for (final p in resolvedProjects) {
        final code = ComputationService.normalizeProjectCode(p.code, p.displayName);
        final key = code.isNotEmpty ? code : p.displayName.trim().toUpperCase();
        if (seenCodes.add(key)) {
          uniqueProjects.add(p);
        }
      }

      if (!mounted) return;
      setState(() {
        _availableProjects = uniqueProjects;
        _mvlcPrices = mvlcPrices;
        _projectDiscounts = projectDiscounts;
        _isLoadingProjects = false;

        // If a project is already selected, re-resolve schemes with latest dynamic discounts
        if (_selectedProject != null) {
          final code = ComputationService.normalizeProjectCode(_selectedProject!.code, _selectedProject!.displayName);
          _paymentSchemes = ComputationService.getPaymentSchemesForProject(code, discounts: projectDiscounts);
          if (_selectedScheme != null) {
            _selectedScheme = _paymentSchemes.firstWhere(
              (s) => s.schemeCode == _selectedScheme!.schemeCode || s.id == _selectedScheme!.id,
              orElse: () => _paymentSchemes.first,
            );
            if (_computationResult != null) {
              _computePrice();
            }
          }
        }
      });

      // Handle direct navigation with a passed lot
      if (widget.lot != null || widget.lotModel != null) {
        _initFromPassedLot();
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoadingProjects = false);
    }
  }

  void _initFromPassedLot() {
    String candidateProj = 'MVLC';
    if (widget.lotModel != null) {
      candidateProj = widget.lotModel!.project ?? 'MVLC';
    } else if (widget.lot != null) {
      final p = widget.lot!.phase.toLowerCase();
      if (p.contains('erhd') || p.contains('resort') || p.contains('eastwest')) {
        candidateProj = 'ERHD';
      } else {
        candidateProj = 'MVLC';
      }
    }

    final code = ComputationService.normalizeProjectCode(candidateProj, candidateProj);
    if (!ComputationService.isProjectEligibleForCalculator(code, candidateProj)) {
      return;
    }
    ProjectModel? matchedProject;
    for (final p in _availableProjects) {
      if (ComputationService.normalizeProjectCode(p.code, p.displayName) == code) {
        matchedProject = p;
        break;
      }
    }

    if (matchedProject != null) {
      _selectProject(matchedProject, preserveLot: true);
    }
  }

  /// Selects or changes the active project.
  /// Automatically resets lot, price, payment options, and result.
  Future<void> _selectProject(ProjectModel project, {bool preserveLot = false}) async {
    final code = ComputationService.normalizeProjectCode(project.code, project.displayName);
    if (project.paused ||
        !ComputationService.isProjectEligibleForCalculator(
          project.code,
          project.displayName,
          paused: project.paused,
        )) {
      return;
    }
    if (!preserveLot && _selectedProject != null) {
      final currentCode = ComputationService.normalizeProjectCode(_selectedProject!.code, _selectedProject!.displayName);
      if (currentCode == code && (_selectedProject!.id == project.id || _selectedProject!.code == project.code)) {
        return;
      }
    }
    final lotTypes = ComputationService.getLotTypesForProject(code);
    final schemes = ComputationService.getPaymentSchemesForProject(
      code,
      discounts: _projectDiscounts,
    );

    setState(() {
      _selectedProject = project;
      _projectCode = code;
      _availableLotTypes = lotTypes;
      _paymentSchemes = schemes;
      _selectedScheme = null; // Do not pre-select payment scheme
      _computationResult = null; // Reset previous computation result
      _isFullComputationExpanded = false;

      if (!preserveLot) {
        _selectedLot = null;
        _isManualLot = false;
        _blockCtrl.clear();
        _lotNumCtrl.clear();
        _lotSizeCtrl.clear();
        _selectedPhase = 2;
        _selectedLotType = lotTypes.first;
        _pricePerSqm = ComputationService.getPricePerSqm(
          projectCode: code,
          lotType: _selectedLotType,
          phase: _selectedPhase,
          mvlcPrices: _mvlcPrices,
        );
      }
    });

    // If preserveLot is true (passed from map or inventory), apply lot info now
    if (preserveLot) {
      if (widget.lotModel != null) {
        _applyInventoryLot(widget.lotModel!);
      } else if (widget.lot != null) {
        final lot = widget.lot!;
        _isManualLot = false;
        _blockCtrl.text = lot.block.toString();
        _lotNumCtrl.text = lot.lot.toString();
        _lotSizeCtrl.text = lot.sizeSqm.toStringAsFixed(0);
        _selectedLotType = lot.lotType;

        final pLower = lot.phase.toLowerCase();
        if (pLower.contains('1')) {
          _selectedPhase = 1;
        } else if (pLower.contains('3')) {
          _selectedPhase = 3;
        } else {
          _selectedPhase = 2;
        }

        _pricePerSqm = _projectCode == 'MVLC'
            ? ComputationService.getPricePerSqm(
                projectCode: 'MVLC',
                lotType: _selectedLotType,
                phase: _selectedPhase,
                mvlcPrices: _mvlcPrices,
              )
            : (lot.pricePerSqm > 0
                ? lot.pricePerSqm
                : ComputationService.getPricePerSqm(
                    projectCode: _projectCode,
                    lotType: _selectedLotType,
                    phase: _selectedPhase,
                    mvlcPrices: _mvlcPrices,
                  ));

        // Create initial LotModel from MapLotModel so block/lot displays as selected immediately
        final lotId = int.tryParse(lot.id) ?? (lot.block * 1000 + lot.lot);
        final lotNo = 'B${lot.block} L${lot.lot}';
        _selectedLot = LotModel(
          id: lotId,
          lotNo: lotNo,
          sizeSqm: lot.sizeSqm,
          pricePerSqm: _pricePerSqm,
          total: lot.totalPrice > 0 ? lot.totalPrice : (_pricePerSqm * lot.sizeSqm),
          category: lot.lotType,
          phase: _selectedPhase,
          status: lot.status.name,
          project: _projectCode,
        );
      }

      // Pre-select payment scheme: synchronized from initialScheme or initialSchemeCode, defaulting to Cash
      if (widget.initialScheme != null) {
        _selectedScheme = _paymentSchemes.firstWhere(
          (s) => s.schemeCode == widget.initialScheme!.schemeCode || s.id == widget.initialScheme!.id,
          orElse: () => widget.initialScheme!,
        );
      } else if (widget.initialSchemeCode != null) {
        _selectedScheme = _paymentSchemes.firstWhere(
          (s) => s.schemeCode == widget.initialSchemeCode,
          orElse: () => _paymentSchemes.first,
        );
      } else if (_selectedScheme == null && _paymentSchemes.isNotEmpty) {
        _selectedScheme = _paymentSchemes.firstWhere(
          (s) => s.schemeCode == 'CASH_100',
          orElse: () => _paymentSchemes.first,
        );
      }

      setState(() {});
      // Auto-compute so broker sees computation immediately!
      _computePrice();
    }

    // Load lots for this project in background
    await _loadLotsForSelectedProject();
  }

  Future<void> _loadLotsForSelectedProject() async {
    if (_selectedProject == null) return;
    setState(() => _isLoadingLots = true);

    try {
      final table = SupabaseService.lotTableForProject(_projectCode);
      final lots = await SupabaseService.fetchLots(
        table: table,
        defaultProject: _projectCode,
      );


      final resolvedLots = lots.map((l) {
        if (_projectCode == 'MVLC') {
          final targetPhase = l.phase ?? 2;
          final pSqm = ComputationService.getPricePerSqm(
            projectCode: 'MVLC',
            lotType: l.category,
            phase: targetPhase,
            mvlcPrices: _mvlcPrices,
          );
          if (pSqm > 0) {
            return l.copyWith(
              pricePerSqm: pSqm,
              total: l.sizeSqm > 0 ? (l.sizeSqm * pSqm) : l.total,
            );
          }
        }
        return l;
      }).toList();

      final seenLots = <String>{};
      final uniqueLots = <LotModel>[];
      for (final l in resolvedLots) {
        final key = '${l.phase ?? 0}_${l.lotNo.trim().toUpperCase()}';
        if (seenLots.add(key)) {
          uniqueLots.add(l);
        }
      }

      // Link exact database lot if block and lot match the active selection
      LotModel? matchedLot = _selectedLot;
      if (_selectedLot != null && uniqueLots.isNotEmpty) {
        final block = _blockCtrl.text.trim();
        final lotNum = _lotNumCtrl.text.trim();
        final phase = _selectedPhase;
        for (final l in uniqueLots) {
          if (l.phase != null && phase != null && l.phase != phase) continue;
          if (_extractBlockNumber(l.lotNo) == block && _extractLotNumber(l.lotNo) == lotNum) {
            matchedLot = l;
            break;
          }
        }
      }

      if (!mounted) return;
      setState(() {
        _projectLots = uniqueLots;
        if (matchedLot != null) {
          _selectedLot = matchedLot;
        }
        _isLoadingLots = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoadingLots = false);
    }
  }

  void _applyInventoryLot(LotModel lot) {
    setState(() {
      _selectedLot = lot;
      _isManualLot = false;
      _blockCtrl.text = _extractBlockNumber(lot.lotNo);
      _lotNumCtrl.text = _extractLotNumber(lot.lotNo);
      _lotSizeCtrl.text = lot.sizeSqm.toStringAsFixed(0);
      if (lot.phase != null) {
        _selectedPhase = lot.phase;
      }

      // Resolve Lot Type
      _selectedLotType = _resolveLotTypeFromCategory(lot.category, _availableLotTypes);

      // Retrieve Price per SQM: for MVLC, always get from mvlc_price table
      if (_projectCode == 'MVLC') {
        _pricePerSqm = ComputationService.getPricePerSqm(
          projectCode: 'MVLC',
          lotType: _selectedLotType,
          phase: _selectedPhase ?? lot.phase,
          mvlcPrices: _mvlcPrices,
        );
      } else if (lot.pricePerSqm > 0) {
        _pricePerSqm = lot.pricePerSqm;
      } else {
        _pricePerSqm = ComputationService.getPricePerSqm(
          projectCode: _projectCode,
          lotType: _selectedLotType,
          phase: _selectedPhase ?? lot.phase,
          mvlcPrices: _mvlcPrices,
        );
      }

      // Reset previous computation when lot changes
      _computationResult = null;
      _isFullComputationExpanded = false;
    });
  }

  String _extractBlockNumber(String lotNo) {
    final match = RegExp(r'^B(\d+)\s*L(\d+)$', caseSensitive: false).firstMatch(lotNo.trim());
    if (match != null) return match.group(1) ?? '';
    return '';
  }

  String _extractLotNumber(String lotNo) {
    final match = RegExp(r'^B(\d+)\s*L(\d+)$', caseSensitive: false).firstMatch(lotNo.trim());
    if (match != null) return match.group(2) ?? '';
    final commMatch = RegExp(r'^L\s*(\d+)$', caseSensitive: false).firstMatch(lotNo.trim());
    if (commMatch != null) return commMatch.group(1) ?? lotNo;
    return lotNo;
  }

  String _resolveLotTypeFromCategory(String category, List<String> available) {
    final c = category.toLowerCase().trim();
    if (available.isEmpty) return 'Regular';

    for (final type in available) {
      final t = type.toLowerCase();
      if (t == c) return type;
      if (c.contains('1_bedroom') || c.contains('1 bedroom') || c.contains('1 br')) {
        if (t.contains('1 bedroom')) return type;
      }
      if (c.contains('2_bedroom_deluxe') || c.contains('deluxe')) {
        if (t.contains('deluxe')) return type;
      }
      if (c.contains('2_bedroom') || c.contains('2 bedroom') || c.contains('2 br')) {
        if (t.contains('2 bedroom') && !t.contains('deluxe')) return type;
      }
      if (c.contains('studio') && t.contains('studio')) {
        return type;
      }
      if (c.contains('penthouse') && t.contains('penthouse')) {
        return type;
      }
      if (c.contains('prime') && c.contains('corner') && t.contains('prime') && t.contains('corner')) {
        return type;
      }
      if (c.contains('commercial') && c.contains('corner') && t.contains('commercial') && t.contains('corner')) {
        return type;
      }
      if (c.contains('commercial') && t.contains('commercial')) {
        return type;
      }
      if (c.contains('prime') && t.contains('prime')) {
        return type;
      }
      if (c.contains('corner') && t.contains('corner')) {
        return type;
      }
    }
    return available.first;
  }

  void _onPhaseChanged(int newPhase) {
    setState(() {
      _selectedPhase = newPhase;
      _pricePerSqm = ComputationService.getPricePerSqm(
        projectCode: _projectCode,
        lotType: _selectedLotType,
        phase: _selectedPhase,
        mvlcPrices: _mvlcPrices,
      );
      _computationResult = null;
    });
  }

  void _onLotTypeChanged(String newType) {
    setState(() {
      _selectedLotType = newType;
      _pricePerSqm = ComputationService.getPricePerSqm(
        projectCode: _projectCode,
        lotType: _selectedLotType,
        phase: _selectedPhase ?? _selectedLot?.phase,
        mvlcPrices: _mvlcPrices,
      );
      _computationResult = null;
    });
  }

  void _computePrice() {
    // 1. Validation: Project
    if (_selectedProject == null) {
      _showWarningSnackBar('Please select a project first.');
      return;
    }

    // 2. Validation: Lot / Lot Size
    final size = double.tryParse(_lotSizeCtrl.text.trim()) ?? 0.0;
    if (size <= 0) {
      _showWarningSnackBar('Please select a lot or enter a valid lot size (> 0 sqm).');
      return;
    }

    // 3. Validation: Price per sqm
    if (_pricePerSqm <= 0) {
      _showWarningSnackBar('No active price is available for this lot type. Please contact the administrator.');
      return;
    }

    // 4. Validation: Payment Option
    if (_selectedScheme == null) {
      _showWarningSnackBar('Please select a payment option.');
      return;
    }

    // 5. Validation: Lot Availability Warning
    if (_selectedLot != null && _selectedLot!.status.toLowerCase() == 'sold') {
      _showWarningSnackBar('Warning: The selected lot is marked as SOLD in the inventory.');
    }

    setState(() => _isCalculating = true);

    final result = ComputationService.calculate(
      projectName: _selectedProject!.displayName,
      projectCode: _projectCode,
      projectId: _selectedProject!.id,
      lotId: _selectedLot?.id,
      phase: _selectedPhase ?? _selectedLot?.phase,
      blockNumber: _blockCtrl.text.trim(),
      lotNumber: _lotNumCtrl.text.trim().isNotEmpty ? _lotNumCtrl.text.trim() : '1',
      lotSize: size,
      lotType: _selectedLotType,
      pricePerSqm: _pricePerSqm,
      scheme: _selectedScheme!,
    );

    setState(() {
      _computationResult = result;
      _isCalculating = false;
    });

    // Smoothly scroll down to the summary card
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_resultKey.currentContext != null) {
        Scrollable.ensureVisible(
          _resultKey.currentContext!,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(message, style: const TextStyle(fontSize: 13))),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _saveComputation() {
    if (_computationResult == null) return;
    setState(() {
      _savedComputations.insert(0, _computationResult!);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.bookmark_added_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Computation snapshot saved for ${_computationResult!.lotDisplay} (${_currencyFmt.format(_computationResult!.tcpAfterDiscount)})',
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0F3E2E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _shareQuotation() {
    if (_computationResult == null) return;
    final r = _computationResult!;

    final text = StringBuffer();
    text.writeln('====================================');
    text.writeln('PRICE COMPUTATION SUMMARY');
    text.writeln('====================================');
    text.writeln('Project: ${r.projectName}');
    text.writeln('Lot: ${r.lotDisplay}');
    text.writeln('Size: ${r.lotSize.toStringAsFixed(0)} sqm');
    text.writeln('Lot Type: ${r.lotType}');
    text.writeln('Price / sqm: ${_currencyFmt.format(r.pricePerSqm)}/sqm');
    text.writeln('Payment Scheme: ${r.paymentSchemeName}');
    text.writeln('------------------------------------');
    text.writeln('TCP AFTER DISCOUNT: ${_currencyFmt.format(r.tcpAfterDiscount)}');
    text.writeln('------------------------------------');
    text.writeln('Original TCP: ${_currencyFmt.format(r.originalTCP)}');
    if (r.discountAmount > 0) {
      text.writeln('Discount (${r.discountPercentage.toStringAsFixed(0)}%): -${_currencyFmt.format(r.discountAmount)}');
    }
    if (r.grossDownPayment > 0) {
      text.writeln('Down Payment (${r.downPaymentPercentage.toStringAsFixed(0)}%): ${_currencyFmt.format(r.grossDownPayment)}');
      if (r.discountedDownPayment > 0 && r.discountAmount > 0) {
        text.writeln('Discounted DP: ${_currencyFmt.format(r.discountedDownPayment)}');
      }
      text.writeln('Reservation Fee: ${_currencyFmt.format(r.reservationFee)}');
      text.writeln('Remaining DP Payable: ${_currencyFmt.format(r.remainingDownPayment)}');
      if (r.monthlyDownPayment > 0) {
        text.writeln('Monthly DP Amortization (${r.dpMonths} mos @ 0%): ${_currencyFmt.format(r.monthlyDownPayment)} / mo');
      }
    } else {
      text.writeln('Down Payment: 0% Spot DP');
      text.writeln('Reservation Fee: ${_currencyFmt.format(r.reservationFee)}');
    }
    if (r.balance > 0) {
      text.writeln('Balance: ${_currencyFmt.format(r.balance)}');
      text.writeln('Payment Term: ${r.balanceMonths} Months');
      text.writeln('Monthly Balance Amortization: ${_currencyFmt.format(r.monthlyAmortization)} / mo');
    }
    text.writeln('Miscellaneous Fee (8%): ${_currencyFmt.format(r.miscellaneousFee)}');
    text.writeln('====================================');
    text.writeln('Generated via BHRI Sales Partner App');

    Clipboard.setData(ClipboardData(text: text.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.copy_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text('Quotation copied to clipboard! Ready to share.'),
          ],
        ),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _openInstantReserve() {
    if (_computationResult == null) return;
    final r = _computationResult!;

    ContactService.callSalesDesk(
      context: context,
      title: 'Instant Lot Reservation',
      subtitle: 'Direct line to lock reservation hold',
      lotInfo: '${r.projectName} - ${r.lotDisplay} • ${_currencyFmt.format(r.tcpAfterDiscount)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price Computation',
              style: AppTextStyles.headlineSm.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
            const Text(
              'Multi-Project Quotation Engine',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          if (_computationResult != null)
            IconButton(
              icon: const Icon(Icons.share_outlined, color: AppColors.secondary, size: 22),
              tooltip: 'Share Quotation',
              onPressed: _shareQuotation,
            ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppColors.outline, size: 22),
            tooltip: 'Reset Form',
            onPressed: () {
              if (_selectedProject != null) {
                _selectProject(_selectedProject!);
              }
            },
          ),
        ],
      ),
      body: _isLoadingProjects
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(strokeWidth: 3, color: AppColors.primary),
                  SizedBox(height: 16),
                  Text('Loading VHBC Projects...', style: TextStyle(color: AppColors.outline)),
                ],
              ),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Step 1: Project Selection
                  _buildProjectSection(),
                  const SizedBox(height: 16),

                  if (_selectedProject == null) ...[
                    _buildSelectProjectPrompt(),
                  ] else ...[
                    // Step 2: Lot Selection
                    _buildLotSelectionSection(),
                    const SizedBox(height: 16),

                    // Step 3 & 4: Lot Type & Active Price per SQM
                    _buildLotTypeAndPriceSection(),
                    const SizedBox(height: 16),

                    // Step 5: Payment Scheme Selection
                    _buildPaymentSchemeSection(),
                    const SizedBox(height: 24),

                    // Step 6: Compute Button
                    _buildComputeButton(),
                    const SizedBox(height: 24),

                    // Step 7 & 8: Result Card & Full Breakdown
                    if (_computationResult != null) ...[
                      _buildResultSection(),
                    ],
                  ],
                ],
              ),
            ),
    );
  }

  // ==========================================
  // STEP 1: PROJECT SELECTION
  // ==========================================
  Widget _buildProjectSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.apartment_rounded, color: AppColors.primaryContainer, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. Select Project',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      'Choose a VHBC development to load inventory & pricing',
                      style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: _showProjectPickerModal,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: _selectedProject == null ? AppColors.surfaceContainerLow : const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedProject == null
                      ? AppColors.outlineVariant
                      : const Color(0xFF0F3E2E).withValues(alpha: 0.5),
                  width: _selectedProject == null ? 1 : 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _selectedProject == null ? Icons.business_outlined : Icons.check_circle_rounded,
                    color: _selectedProject == null ? AppColors.outline : const Color(0xFF0F3E2E),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _selectedProject != null ? _selectedProject!.displayName : 'Select Project...',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: _selectedProject != null ? FontWeight.w700 : FontWeight.w500,
                        color: _selectedProject != null ? AppColors.onSurface : AppColors.outline,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_rounded, color: AppColors.outline, size: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectProjectPrompt() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.calculate_outlined, size: 40, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          const Text(
            'Begin Price Computation',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            'Please tap "Select Project" above to load the lots, active price matrix, and custom payment schemes.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant.withValues(alpha: 0.8), height: 1.4),
          ),
        ],
      ),
    );
  }

  void _showProjectPickerModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.apartment_rounded, color: AppColors.primary, size: 22),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Select Development Project',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final seen = <String>{};
                    final uniqueProjects = <ProjectModel>[];
                    for (final p in _availableProjects) {
                      if (p.paused ||
                          !ComputationService.isProjectEligibleForCalculator(
                            p.code,
                            p.displayName,
                            paused: p.paused,
                          )) {
                        continue;
                      }
                      final code = ComputationService.normalizeProjectCode(p.code, p.displayName);
                      final key = code.isNotEmpty ? code : p.displayName.trim().toUpperCase();
                      if (seen.add(key)) {
                        uniqueProjects.add(p);
                      }
                    }

                    return ListView.separated(
                      itemCount: uniqueProjects.length,
                      separatorBuilder: (context, index) => const Divider(height: 1, indent: 64),
                      itemBuilder: (context, idx) {
                        final p = uniqueProjects[idx];
                        final code = ComputationService.normalizeProjectCode(p.code, p.displayName);
                        final isSelected = _selectedProject != null &&
                            (ComputationService.normalizeProjectCode(_selectedProject!.code, _selectedProject!.displayName) == code ||
                             _selectedProject!.id == p.id);

                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          leading: CircleAvatar(
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : AppColors.primaryContainer.withValues(alpha: 0.1),
                            child: Text(
                              code.length > 3 ? code.substring(0, 3) : code,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? Colors.white : AppColors.primary,
                              ),
                            ),
                          ),
                          title: Text(
                            p.displayName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? AppColors.primary : AppColors.onSurface,
                            ),
                          ),
                          subtitle: const Text(
                            'Real-time DB Pricing',
                            style: TextStyle(fontSize: 12, color: AppColors.outline),
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                              : const Icon(Icons.chevron_right, color: AppColors.outline),
                          onTap: () {
                            Navigator.of(ctx).pop();
                            _selectProject(p);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================
  // STEP 2: LOT SELECTION
  // ==========================================
  Widget _buildLotSelectionSection() {
    final lotDisplay = _selectedLot != null
        ? '${_selectedLot!.formattedLotNo} (${_selectedLot!.sizeSqm.toStringAsFixed(0)} sqm • ${_selectedLot!.categoryDisplay})'
        : _isManualLot
            ? (_isMscc
                ? 'Manual Unit: ${_lotNumCtrl.text} (${_lotSizeCtrl.text} sqm)'
                : 'Manual Lot: Block ${_blockCtrl.text} – Lot ${_lotNumCtrl.text} (${_lotSizeCtrl.text} sqm)')
            : (_blockCtrl.text.isNotEmpty && _lotNumCtrl.text.isNotEmpty)
                ? 'Block ${_blockCtrl.text} • Lot ${_lotNumCtrl.text} (${_lotSizeCtrl.text} sqm • $_selectedLotType)'
                : (_isMscc ? 'Select Unit from Inventory...' : 'Select Lot from Inventory...');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(_isMscc ? Icons.apartment_rounded : Icons.grid_view_rounded, color: AppColors.secondary, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isMscc ? '2. Select Unit' : '2. Select Lot',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      _isMscc ? 'Pick from inventory or enter custom unit details' : 'Pick from inventory or enter custom dimensions',
                      style: const TextStyle(fontSize: 12, color: AppColors.outline),
                    ),
                  ],
                ),
              ),
              if (_isLoadingLots)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                ),
            ],
          ),
          const SizedBox(height: 14),

          // Selection Box
          InkWell(
            onTap: _showLotPickerModal,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: _selectedLot == null && !_isManualLot
                    ? AppColors.surfaceContainerLow
                    : const Color(0xFFFAF5EC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedLot != null || _isManualLot
                      ? AppColors.secondary.withValues(alpha: 0.6)
                      : AppColors.outlineVariant,
                  width: _selectedLot != null || _isManualLot ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _selectedLot != null || _isManualLot ? Icons.place_rounded : Icons.search_rounded,
                    color: _selectedLot != null || _isManualLot ? AppColors.secondary : AppColors.outline,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      lotDisplay,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: _selectedLot != null || _isManualLot ? FontWeight.w700 : FontWeight.w500,
                        color: _selectedLot != null || _isManualLot ? AppColors.onSurface : AppColors.outline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_rounded, color: AppColors.outline, size: 26),
                ],
              ),
            ),
          ),

          // Inventory Lot Status Chip
          if (_selectedLot != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getLotStatusColor(_selectedLot!.status).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Status: ${_selectedLot!.status.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _getLotStatusColor(_selectedLot!.status),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Lot ID: ${_selectedLot!.id} • ${_selectedLot!.sizeSqm.toStringAsFixed(0)} sqm',
                  style: const TextStyle(fontSize: 12, color: AppColors.outline),
                ),
              ],
            ),
          ],

          // Manual Input Form (when manual lot is selected)
          if (_isManualLot) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                if (!_isMscc) ...[
                  Expanded(
                    child: TextField(
                      controller: _blockCtrl,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Block No.',
                        hintText: 'e.g. 2',
                        isDense: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (_) => setState(() => _computationResult = null),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: TextField(
                    controller: _lotNumCtrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: _isMscc ? 'Unit No.' : 'Lot No.',
                      hintText: _isMscc ? 'e.g. 201' : 'e.g. 15',
                      isDense: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onChanged: (_) => setState(() => _computationResult = null),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _lotSizeCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: _isMscc ? 'Unit Size (sqm)' : 'Lot Size (sqm)',
                      hintText: _isMscc ? 'e.g. 45' : 'e.g. 700',
                      isDense: true,
                      suffixText: 'sqm',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onChanged: (_) => setState(() => _computationResult = null),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Quick preset pills
            Wrap(
              spacing: 8,
              children: (_isMscc
                      ? [28.0, 35.0, 45.0, 60.0, 75.0]
                      : (_projectCode == 'ERHD' ? [500.0, 600.0, 700.0, 800.0, 1000.0] : [150.0, 180.0, 200.0, 240.0, 300.0]))
                  .map((sqm) {
                final isCurrent = _lotSizeCtrl.text == sqm.toStringAsFixed(0);
                return ChoiceChip(
                  label: Text('${sqm.toStringAsFixed(0)} sqm'),
                  selected: isCurrent,
                  onSelected: (sel) {
                    if (sel) {
                      _lotSizeCtrl.text = sqm.toStringAsFixed(0);
                      setState(() => _computationResult = null);
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Color _getLotStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return const Color(0xFF16A34A);
      case 'reserved':
      case 'rsv-p':
      case 'hold':
        return const Color(0xFFD97706);
      case 'sold':
      default:
        return const Color(0xFFDC2626);
    }
  }

  void _showLotPickerModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _LotPickerSheet(
          lots: _projectLots,
          projectCode: _projectCode,
          selectedLotId: _selectedLot?.id,
          onSelectInventoryLot: (lot) {
            Navigator.of(ctx).pop();
            _applyInventoryLot(lot);
          },
          onSelectManualEntry: () {
            Navigator.of(ctx).pop();
            setState(() {
              _selectedLot = null;
              _isManualLot = true;
              if (_lotSizeCtrl.text.isEmpty) {
                _lotSizeCtrl.text = _isMscc ? '45' : (_projectCode == 'ERHD' ? '700' : '200');
              }
              if (!_isMscc && _blockCtrl.text.isEmpty) _blockCtrl.text = '1';
              if (_lotNumCtrl.text.isEmpty) _lotNumCtrl.text = _isMscc ? '201' : '1';
              _computationResult = null;
            });
          },
        );
      },
    );
  }

  // ==========================================
  // STEP 3 & 4: LOT TYPE & PRICE PER SQM
  // ==========================================
  Widget _buildLotTypeAndPriceSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceTint.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.sell_rounded, color: AppColors.surfaceTint, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isMscc ? '3. Unit Type & Pricing' : '3. Lot Type & Pricing',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const Text(
                      'Active price retrieved from database matrix',
                      style: TextStyle(fontSize: 12, color: AppColors.outline),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Phase Selector for MVLC
          if (_projectCode == 'MVLC') ...[
            const Text(
              'Select Phase:',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.onSurface),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [1, 2, 3].map((phaseNum) {
                final isSel = _selectedPhase == phaseNum;
                return ChoiceChip(
                  label: Text('Phase $phaseNum'),
                  selected: isSel,
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                    color: isSel ? Colors.white : AppColors.onSurface,
                  ),
                  onSelected: (sel) {
                    if (sel) _onPhaseChanged(phaseNum);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
          ],

          // Lot Type Display / Chips
          if (_selectedLot != null) ...[
            // Automatically assigned for inventory lot
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  Text(
                    _isMscc ? 'Unit Type: ' : 'Lot Type: ',
                    style: const TextStyle(fontSize: 13, color: AppColors.outline, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    _selectedLotType,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '(Assigned from inventory)',
                    style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: AppColors.outline),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Manual selection chips
            Text(
              _isMscc ? 'Select Unit Type:' : 'Select Lot Type:',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.onSurface),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableLotTypes.map((type) {
                final isSel = _selectedLotType == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: isSel,
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                    color: isSel ? Colors.white : AppColors.onSurface,
                  ),
                  onSelected: (sel) {
                    if (sel) _onLotTypeChanged(type);
                  },
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 14),

          // Price per sqm Banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F3E2E), Color(0xFF1E5B45)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ACTIVE PRICE PER SQM',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFBDEDD6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_projectCode • ${_projectCode == 'MVLC' && _selectedPhase != null ? 'Phase $_selectedPhase • ' : ''}$_selectedLotType',
                        style: const TextStyle(fontSize: 12, color: Colors.white70),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _pricePerSqm > 0 ? '${_currencyFmt.format(_pricePerSqm)}/sqm' : 'Price Unavailable',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // STEP 5: PAYMENT OPTION SELECTION
  // ==========================================
  Widget _buildPaymentSchemeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.payments_rounded, color: AppColors.secondary, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '4. Select Payment Option',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      'Tailored for $_projectCode payment schemes',
                      style: const TextStyle(fontSize: 12, color: AppColors.outline),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Payment Option Cards
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _paymentSchemes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, idx) {
              final scheme = _paymentSchemes[idx];
              final isSelected = _selectedScheme?.id == scheme.id;

              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedScheme = scheme;
                    _computationResult = null; // Recompute required
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF0F3E2E) : AppColors.outlineVariant.withValues(alpha: 0.6),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: isSelected ? const Color(0xFF0F3E2E) : AppColors.outline,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    scheme.schemeName,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected ? const Color(0xFF0F3E2E) : AppColors.onSurface,
                                    ),
                                  ),
                                ),
                                if (scheme.badgeText != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF0F3E2E)
                                          : AppColors.secondary.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      scheme.badgeText!,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: isSelected ? Colors.white : AppColors.secondary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              scheme.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ==========================================
  // STEP 6: COMPUTE BUTTON
  // ==========================================
  Widget _buildComputeButton() {
    final canCompute = _selectedProject != null &&
        (_selectedLot != null || _isManualLot) &&
        _pricePerSqm > 0 &&
        _selectedScheme != null;

    return ElevatedButton(
      onPressed: _isCalculating ? null : _computePrice,
      style: ElevatedButton.styleFrom(
        backgroundColor: canCompute ? const Color(0xFF0F3E2E) : Colors.grey.shade400,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: canCompute ? 3 : 0,
      ),
      child: _isCalculating
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calculate_rounded, size: 22),
                SizedBox(width: 8),
                Text(
                  'Compute Price',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
    );
  }

  // ==========================================
  // STEP 7 & 8: RESULT CARD & EXPANDED DETAILS
  // ==========================================
  Widget _buildResultSection() {
    final r = _computationResult!;

    return Column(
      key: _resultKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Primary Summary Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFFED48A), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F3E2E).withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card Header Badge
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00271B), Color(0xFF0F3E2E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.receipt_long_rounded, color: Color(0xFFFED48A), size: 20),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'PRICE COMPUTATION SUMMARY',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFED48A),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        r.projectCode,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF271900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Property Information
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.projectName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      r.lotDisplay,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${r.lotSize.toStringAsFixed(0)} sqm • ${r.lotType}',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.onSurfaceVariant.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_currencyFmt.format(r.pricePerSqm)} / sqm',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.outline,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Payment Option & Reservation Fee Details
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Down Payment',
                                style: TextStyle(fontSize: 13, color: AppColors.outline),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  r.paymentSchemeName,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Reservation Fee',
                                style: TextStyle(fontSize: 13, color: AppColors.outline),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _currencyFmt.format(r.reservationFee),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                          if (r.monthlyDownPayment > 0) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Monthly DP (${r.dpMonths} mos @ 0%)',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13, color: AppColors.outline),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${_currencyFmt.format(r.monthlyDownPayment)} / mo',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (r.monthlyAmortization > 0) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    r.interestRate > 0
                                        ? 'Est. Bank Loan (${(r.balanceMonths / 12).round()} yrs)'
                                        : 'Monthly Balance (${r.balanceMonths} mos)',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13, color: AppColors.outline),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${_currencyFmt.format(r.monthlyAmortization)} / mo',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0F3E2E),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),
                    const Divider(height: 1, color: Color(0xFFE0E3E5)),
                    const SizedBox(height: 18),

                    // Centered Prominent TCP After Discount
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'TCP AFTER DISCOUNT',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                              color: AppColors.outline,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _currencyFmt.format(r.tcpAfterDiscount),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF00271B),
                              letterSpacing: -0.5,
                            ),
                          ),
                          if (r.discountAmount > 0) ...[
                            const SizedBox(height: 4),
                            Text(
                              'You save ${_currencyFmt.format(r.discountAmount)} (${r.discountPercentage.toStringAsFixed(0)}% Off)',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Action Bar below summary card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F9FB),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _isFullComputationExpanded = !_isFullComputationExpanded;
                          });
                        },
                        icon: Icon(
                          _isFullComputationExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        label: Text(
                          _isFullComputationExpanded ? 'Hide Breakdown' : 'View Full Computation',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border_rounded, color: AppColors.secondary),
                      tooltip: 'Save Snapshot',
                      onPressed: _saveComputation,
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy_rounded, color: AppColors.outline),
                      tooltip: 'Copy Quotation',
                      onPressed: _shareQuotation,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Section 8: Optional Expanded Detailed Breakdown
        if (_isFullComputationExpanded) ...[
          const SizedBox(height: 14),
          _buildDetailedBreakdownCard(r),
        ],

        const SizedBox(height: 20),

        // Reservation Action Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: _openInstantReserve,
            icon: const Icon(Icons.lock, size: 18),
            label: const Text(
              'Instant Reserve',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: AppColors.onPrimary,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedBreakdownCard(ComputationResultModel r) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.format_list_bulleted_rounded, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Detailed Computation Breakdown',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildBreakdownRow('Original TCP', _currencyFmt.format(r.originalTCP)),
          if (r.grossDownPayment > 0)
            _buildBreakdownRow(
              'Spot Down Payment (${r.downPaymentPercentage.toStringAsFixed(0)}%)',
              _currencyFmt.format(r.grossDownPayment),
            ),
          if (r.discountPercentage > 0) ...[
            _buildBreakdownRow('Discount Rate', '${r.discountPercentage.toStringAsFixed(0)}%'),
            _buildBreakdownRow(
              'Discount Amount',
              '-${_currencyFmt.format(r.discountAmount)}',
              valueColor: const Color(0xFF16A34A),
            ),
          ],
          if (r.discountedDownPayment > 0)
            _buildBreakdownRow('Discounted Down Payment', _currencyFmt.format(r.discountedDownPayment)),
          _buildBreakdownRow(
            'Reservation Fee',
            _currencyFmt.format(r.reservationFee),
            isBold: r.grossDownPayment == 0,
            subtitle: r.grossDownPayment == 0
                ? 'Initial cash out upon reservation (credited to balance)'
                : null,
          ),
          if (r.grossDownPayment > 0)
            _buildBreakdownRow(
              'Remaining DP Payable',
              _currencyFmt.format(r.remainingDownPayment),
              isBold: true,
            ),
          if (r.monthlyDownPayment > 0)
            _buildBreakdownRow(
              'Monthly DP Amortization (${r.dpMonths} Months @ 0%)',
              '${_currencyFmt.format(r.monthlyDownPayment)} / mo',
              isBold: true,
              valueColor: AppColors.secondary,
            ),
          const Divider(height: 16),
          if (r.balance > 0) ...[
            _buildBreakdownRow(
              r.grossDownPayment == 0 ? 'Net Balance to Amortize' : 'Balance',
              _currencyFmt.format(r.balance),
            ),
            _buildBreakdownRow('Payment Term', '${r.balanceMonths} Months'),
            _buildBreakdownRow(
              r.interestRate > 0 ? 'Monthly Bank Amortization' : 'Monthly Amortization',
              '${_currencyFmt.format(r.monthlyAmortization)} / mo',
              isBold: true,
              valueColor: const Color(0xFF0F3E2E),
            ),
          ],
          const Divider(height: 16),
          _buildBreakdownRow(
            'Miscellaneous Fee (8%)',
            _currencyFmt.format(r.miscellaneousFee),
            subtitle: 'Title transfer, documentary stamp, registration',
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
    String? subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
                  color: isBold ? AppColors.onSurface : AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
                  color: valueColor ?? (isBold ? AppColors.onSurface : AppColors.onSurface),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 10, color: AppColors.outline),
            ),
          ],
        ],
      ),
    );
  }
}

/// Searchable modal bottom sheet to select an inventory lot or pick manual entry
class _LotPickerSheet extends StatefulWidget {
  final List<LotModel> lots;
  final String projectCode;
  final int? selectedLotId;
  final ValueChanged<LotModel> onSelectInventoryLot;
  final VoidCallback onSelectManualEntry;

  const _LotPickerSheet({
    required this.lots,
    required this.projectCode,
    required this.selectedLotId,
    required this.onSelectInventoryLot,
    required this.onSelectManualEntry,
  });

  @override
  State<_LotPickerSheet> createState() => _LotPickerSheetState();
}

class _LotPickerSheetState extends State<_LotPickerSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _filter = '';
  int? _phaseFilter;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMscc = widget.projectCode.toUpperCase().contains('MSCC');
    final filtered = widget.lots.where((l) {
      if (_phaseFilter != null && l.phase != _phaseFilter) return false;
      if (_filter.isEmpty) return true;
      final q = _filter.toLowerCase();
      return l.lotNo.toLowerCase().contains(q) ||
          l.category.toLowerCase().contains(q) ||
          l.status.toLowerCase().contains(q) ||
          (l.unitType?.toLowerCase().contains(q) ?? false) ||
          (l.floorLevel?.toLowerCase().contains(q) ?? false);
    }).toList();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              children: [
                Icon(isMscc ? Icons.apartment_rounded : Icons.grid_view_rounded, color: AppColors.primary, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isMscc ? 'Select Unit (${widget.projectCode})' : 'Select Lot (${widget.projectCode})',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          // Search Box & Manual Entry Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: isMscc ? 'Search unit (e.g. 201)...' : 'Search lot (e.g. B2 L15)...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      isDense: true,
                      filled: true,
                      fillColor: AppColors.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) => setState(() => _filter = val),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: widget.onSelectManualEntry,
                  icon: const Icon(Icons.edit_note_rounded, size: 18),
                  label: const Text('Manual'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.secondary,
                    backgroundColor: AppColors.secondaryContainer.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          if (widget.projectCode == 'MVLC') ...[
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('All Phases'),
                    selected: _phaseFilter == null,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      fontSize: 11,
                      fontWeight: _phaseFilter == null ? FontWeight.w700 : FontWeight.w500,
                      color: _phaseFilter == null ? Colors.white : AppColors.onSurface,
                    ),
                    onSelected: (_) => setState(() => _phaseFilter = null),
                  ),
                  const SizedBox(width: 6),
                  ...[1, 2, 3].map((pNum) {
                    final isSel = _phaseFilter == pNum;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: FilterChip(
                        label: Text('Phase $pNum'),
                        selected: isSel,
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(
                          fontSize: 11,
                          fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                          color: isSel ? Colors.white : AppColors.onSurface,
                        ),
                        onSelected: (_) => setState(() => _phaseFilter = pNum),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          const Divider(height: 1),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.inbox_rounded, size: 40, color: AppColors.outline),
                        const SizedBox(height: 8),
                        Text(
                          widget.lots.isEmpty
                              ? (isMscc ? 'No units found for ${widget.projectCode} in inventory.' : 'No lots found for ${widget.projectCode} in inventory.')
                              : (isMscc ? 'No units match "$_filter"' : 'No lots match "$_filter"'),
                          style: const TextStyle(color: AppColors.outline),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: widget.onSelectManualEntry,
                          icon: const Icon(Icons.add, size: 18),
                          label: Text(isMscc ? 'Enter Custom Unit Details' : 'Enter Custom Lot Details'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, indent: 64),
                    itemBuilder: (context, idx) {
                      final lot = filtered[idx];
                      final isSelected = widget.selectedLotId == lot.id;
                      final isSold = lot.status.toLowerCase() == 'sold';

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isSold
                              ? Colors.red.shade100
                              : (isSelected
                                  ? AppColors.primary
                                  : AppColors.surfaceContainer),
                          child: Icon(
                            isSold
                                ? Icons.block_rounded
                                : (isMscc ? Icons.apartment_rounded : Icons.home_rounded),
                            color: isSold
                                ? Colors.red.shade700
                                : (isSelected ? Colors.white : AppColors.primary),
                            size: 18,
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              lot.formattedLotNo,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isSold ? Colors.grey : AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(lot.status).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                lot.status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: _getStatusColor(lot.status),
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          lot.isMscc
                              ? '${lot.sizeSqm.toStringAsFixed(0)} sqm • ${lot.phaseLocationText}'
                              : '${lot.sizeSqm.toStringAsFixed(0)} sqm • ${lot.phase != null ? 'Phase ${lot.phase} • ' : ''}${lot.categoryDisplay}',
                          style: const TextStyle(fontSize: 12, color: AppColors.outline),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                            : const Icon(Icons.chevron_right, color: AppColors.outline),
                        onTap: () => widget.onSelectInventoryLot(lot),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return const Color(0xFF16A34A);
      case 'reserved':
      case 'rsv-p':
      case 'hold':
        return const Color(0xFFD97706);
      case 'sold':
      default:
        return const Color(0xFFDC2626);
    }
  }
}
