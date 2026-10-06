import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/inventory/models/inventory_item.dart';
import 'package:vhbc_broker_app/features/inventory/models/project_model.dart';
import 'package:vhbc_broker_app/features/computation/services/computation_service.dart';

void main() {
  group('ProjectModel paused column tests', () {
    test('ProjectModel parses paused column correctly from JSON', () {
      final pausedJson = {
        'id': 21,
        'code': 'LCN',
        'name': 'LCN',
        'description': null,
        'paused': true,
      };
      final activeJson = {
        'id': 14,
        'code': 'MVLC',
        'name': 'MVLC',
        'description': null,
        'paused': false,
      };

      final pausedProject = ProjectModel.fromJson(pausedJson);
      final activeProject = ProjectModel.fromJson(activeJson);

      expect(pausedProject.paused, isTrue);
      expect(pausedProject.isSoonToRise, isTrue);

      expect(activeProject.paused, isFalse);
      expect(activeProject.isSoonToRise, isFalse);

      expect(pausedProject.toJson()['paused'], isTrue);
      expect(activeProject.toJson()['paused'], isFalse);
    });

    test('InventoryProjectOption reflects paused status', () {
      const optionPaused = InventoryProjectOption(
        id: 'LCN',
        label: 'LCN',
        paused: true,
      );
      const optionActive = InventoryProjectOption(
        id: 'MVLC',
        label: 'MVLC',
        paused: false,
      );

      expect(optionPaused.paused, isTrue);
      expect(optionPaused.isSoonToRise, isTrue);
      expect(optionActive.paused, isFalse);
      expect(optionActive.isSoonToRise, isFalse);
    });
  });

  group('Flexible Calculations Exclusion based on paused status', () {
    test('isProjectEligibleForCalculator excludes projects when paused is true', () {
      const pausedProject = ProjectModel(
        id: '99',
        code: 'NEW_UPCOMING',
        name: 'New Upcoming Project',
        paused: true,
      );

      const activeProject = ProjectModel(
        id: '100',
        code: 'NEW_ACTIVE',
        name: 'New Active Project',
        paused: false,
      );

      // Directly checking with paused parameter
      expect(
        ComputationService.isProjectEligibleForCalculator(
          pausedProject.code,
          pausedProject.displayName,
          paused: pausedProject.paused,
        ),
        isFalse,
      );

      expect(
        ComputationService.isProjectEligibleForCalculator(
          activeProject.code,
          activeProject.displayName,
          paused: activeProject.paused,
        ),
        isTrue,
      );
    });

    test('isProjectEligibleForCalculator dynamically respects Supabase projects cache', () {
      SupabaseService.setMockData(
        projects: const [
          ProjectModel(
            id: '1',
            code: 'FLEX_PROJ',
            name: 'Flexible Project',
            paused: true,
          ),
          ProjectModel(
            id: '2',
            code: 'ACTIVE_PROJ',
            name: 'Active Project',
            paused: false,
          ),
        ],
      );

      // FLEX_PROJ is paused in database -> excluded from calculator
      expect(
        ComputationService.isProjectEligibleForCalculator('FLEX_PROJ', 'Flexible Project'),
        isFalse,
      );

      // ACTIVE_PROJ is NOT paused -> eligible for calculator
      expect(
        ComputationService.isProjectEligibleForCalculator('ACTIVE_PROJ', 'Active Project'),
        isTrue,
      );

      // Now unpause FLEX_PROJ in database
      SupabaseService.setMockData(
        projects: const [
          ProjectModel(
            id: '1',
            code: 'FLEX_PROJ',
            name: 'Flexible Project',
            paused: false,
          ),
        ],
      );

      // FLEX_PROJ is unpaused -> now automatically appears on calculations
      expect(
        ComputationService.isProjectEligibleForCalculator('FLEX_PROJ', 'Flexible Project'),
        isTrue,
      );

      SupabaseService.clearCache();
    });
  });
}
