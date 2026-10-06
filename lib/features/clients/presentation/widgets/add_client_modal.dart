import 'package:flutter/material.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/services/auth_service.dart';
import '../../models/client_model.dart';

class AddClientModal extends StatefulWidget {
  final List<String> availableProjects;
  final ValueChanged<ClientModel> onClientAdded;
  final String? initialProject;

  const AddClientModal({
    super.key,
    required this.availableProjects,
    required this.onClientAdded,
    this.initialProject,
  });

  /// Evaluates whether a project is currently active for new client leads.
  /// Strictly excludes projects that are Sold Out (e.g. EBLF) and Soon to Rise (e.g. GLS).
  static bool isProjectEligibleForClient(String project) {
    final p = project.trim().toUpperCase();
    // Exclude Sold Out projects
    if (p == 'EBLF' ||
        p.contains('EBLF') ||
        p.contains('EASTWEST BREEZE') ||
        p.contains('BREEZE') ||
        p.contains('SOLD OUT')) {
      return false;
    }
    // Exclude Soon to Rise / Paused projects
    if (SupabaseService.isProjectPaused(p, p)) {
      return false;
    }
    return true;
  }

  static Future<void> show(
    BuildContext context, {
    required List<String> availableProjects,
    required ValueChanged<ClientModel> onClientAdded,
    String? initialProject,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AddClientModal(
        availableProjects: availableProjects,
        onClientAdded: onClientAdded,
        initialProject: initialProject,
      ),
    );
  }

  @override
  State<AddClientModal> createState() => _AddClientModalState();
}

class _AddClientModalState extends State<AddClientModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  ClientStage _selectedStage = ClientStage.hot;
  late String _selectedProject;
  bool _isSaving = false;

  List<String> get _filteredEligibleProjects {
    final list = widget.availableProjects
        .where(AddClientModal.isProjectEligibleForClient)
        .toList();
    if (list.isEmpty) {
      return const ['MVLC', 'ERHD', 'MSCC'];
    }
    return list;
  }

  String _getProjectDisplayName(String code) {
    final c = code.trim().toUpperCase();
    if (c == 'MVLC' || c.contains('MVLC')) {
      return 'MVLC • Mountain View Leisure Community';
    }
    if (c == 'ERHD' || c.contains('ERHD')) {
      return 'ERHD • Eastwest Resort Hub and Development';
    }
    if (c == 'MSCC' || c.contains('MSCC')) {
      return 'MSCC • Mountain Suites Country Club';
    }
    return code;
  }

  @override
  void initState() {
    super.initState();
    final eligible = _filteredEligibleProjects;
    if (widget.initialProject != null &&
        eligible.contains(widget.initialProject) &&
        AddClientModal.isProjectEligibleForClient(widget.initialProject!)) {
      _selectedProject = widget.initialProject!;
    } else {
      _selectedProject = eligible.first;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final notes = _notesController.text.trim();

    String statusNote;
    String tagNote;
    String? holdSub;

    switch (_selectedStage) {
      case ClientStage.hot:
        statusNote = notes.isNotEmpty ? notes : 'Initial consultation complete';
        tagNote = 'Site Tripping';
        break;
      case ClientStage.reserved:
        statusNote = notes.isNotEmpty ? notes : 'Unit hold requested • Awaiting docs';
        tagNote = 'Hold Active';
        holdSub = 'Priority Hold';
        break;
      case ClientStage.warm:
        statusNote = notes.isNotEmpty ? notes : 'Computation and brochure sent';
        tagNote = 'Follow-up';
        break;
      case ClientStage.cold:
        statusNote = notes.isNotEmpty ? notes : 'Unreachable on phone • Inactive';
        tagNote = 'Nurturing';
        break;
      case ClientStage.closed:
        statusNote = notes.isNotEmpty ? notes : 'Account verified • 100% Commission';
        tagNote = 'Turnover';
        break;
    }

    setState(() => _isSaving = true);

    final brokerName = AuthService.currentUser?.displayName ?? 'Juan Dela Cruz';
    final brokerId = AuthService.currentUser?.id;

    final clientCandidate = ClientModel(
      id: '',
      name: name,
      subtitle: 'Registered Lead • $_selectedProject Inquirer',
      phone: phone.isNotEmpty ? phone : '+63 900 000 0000',
      stage: _selectedStage,
      isVip: false,
      projectCode: _selectedProject,
      unitDescription: '$_selectedProject Development Unit',
      tcpFormatted: 'Price Upon Request',
      statusNote: statusNote,
      tagNote: tagNote,
      lastActivityText: 'Created just now',
      holdSubtitle: holdSub,
      createdAt: DateTime.now(),
      brokerName: brokerName,
      notes: notes.isNotEmpty ? notes : null,
    );

    ClientModel finalClient;
    try {
      finalClient = await SupabaseService.addClient(
        clientCandidate,
        brokerName: brokerName,
        brokerId: brokerId,
      );
    } catch (e) {
      finalClient = clientCandidate.copyWith(
        id: 'client-${DateTime.now().millisecondsSinceEpoch}',
      );
    }

    if (mounted) {
      setState(() => _isSaving = false);
      widget.onClientAdded(finalClient);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + bottomInset,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primaryFixed,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.badge_outlined,
                            size: 20,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Register New Buyer Lead',
                            style: AppTextStyles.headlineSm.copyWith(
                              fontSize: 18,
                              color: AppColors.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.outline),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Create an accredited broker folder to lock priority unit hold requests.',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.outline),
              ),
              const SizedBox(height: 18),

              // Full Legal Name
              Text(
                'FULL CLIENT LEGAL NAME',
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.outline,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'e.g. Dr. Alejandro Ramos',
                  hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.outline),
                  filled: true,
                  fillColor: AppColors.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter client name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Phone & Stage row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MOBILE NUMBER',
                          style: AppTextStyles.labelSm.copyWith(
                            color: AppColors.outline,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: '+63 9XX XXX XXXX',
                            hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.outline),
                            filled: true,
                            fillColor: AppColors.surfaceContainerLow,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Enter mobile number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PIPELINE STAGE',
                          style: AppTextStyles.labelSm.copyWith(
                            color: AppColors.outline,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<ClientStage>(
                              isExpanded: true,
                              value: _selectedStage,
                              items: const [
                                DropdownMenuItem(
                                  value: ClientStage.hot,
                                  child: Text('Hot Lead'),
                                ),
                                DropdownMenuItem(
                                  value: ClientStage.warm,
                                  child: Text('Warm Prospect'),
                                ),
                                DropdownMenuItem(
                                  value: ClientStage.reserved,
                                  child: Text('Reserved / Hold'),
                                ),
                                DropdownMenuItem(
                                  value: ClientStage.cold,
                                  child: Text('Cold Lead'),
                                ),
                                DropdownMenuItem(
                                  value: ClientStage.closed,
                                  child: Text('Closed Buyer'),
                                ),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _selectedStage = val);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Interested Development
              Text(
                'INTERESTED DEVELOPMENT',
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.outline,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _filteredEligibleProjects.contains(_selectedProject)
                        ? _selectedProject
                        : _filteredEligibleProjects.first,
                    items: _filteredEligibleProjects
                        .map(
                          (proj) => DropdownMenuItem(
                            value: proj,
                            child: Text(
                              _getProjectDisplayName(proj),
                              style: AppTextStyles.bodyMd.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedProject = val);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Active developments only (sold out & upcoming projects are excluded).',
                style: AppTextStyles.bodySm.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 14),

              // Notes / Unit inquiry
              Text(
                'INITIAL NOTES / INQUIRY DETAILS (OPTIONAL)',
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.outline,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  hintText: 'e.g. Inquiring for 250 sqm corner lot or 1-BR Villa',
                  hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.outline),
                  filled: true,
                  fillColor: AppColors.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 22),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: AppColors.surfaceContainerHigh),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.labelLg.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isSaving ? null : _handleSubmit,
                      icon: _isSaving
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.onPrimary,
                              ),
                            )
                          : const Icon(Icons.save, size: 18),
                      label: Text(
                        _isSaving ? 'Saving...' : 'Save & Lock',
                        style: AppTextStyles.labelLg.copyWith(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
