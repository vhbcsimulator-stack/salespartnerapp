import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/map/models/map_upload_model.dart';
import 'package:vhbc_broker_app/features/map/presentation/interactive_sales_map_screen.dart';

void main() {
  group('MVLC Uploads table fetching and phase choice chip label tests', () {
    test('MapUploadModel strictly reads image_URL and map_section from json', () {
      final json = {
        'id': 99,
        'project_id': 14,
        'kind': 'map',
        'name': 'mvlc-phase-2east-colored.svg',
        'image_URL': 'https://example.com/storage/v1/object/public/mvlc/phase-2.svg',
        'type': 'residential',
        'Phase': 2,
        'map_section': 'East',
      };
      final model = MapUploadModel.fromJson(json);
      expect(model.id, 99);
      expect(model.image_URL, 'https://example.com/storage/v1/object/public/mvlc/phase-2.svg');
      expect(model.imageUrl, 'https://example.com/storage/v1/object/public/mvlc/phase-2.svg');
      expect(model.phase, 2);
      expect(model.mapSection, 'East');
    });

    test('MVLC choice chip names format as phase number + map_section (e.g. Phase 2 with East -> Phase 2E)', () {
      // Phase 2 East -> Phase 2E
      final upload2East = MapUploadModel.fromJson({
        'id': 8,
        'name': 'Sept MVLC Phase 2 smaller.svg',
        'Phase': 2,
        'map_section': 'East',
        'image_URL': 'https://example.com/phase-2-east.svg',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload2East), equals('Phase 2E'));

      // Phase 1 East -> Phase 1E
      final upload1East = MapUploadModel.fromJson({
        'id': 7,
        'name': 'MV Phase 1 East Gate(Phase 1E).svg',
        'Phase': 1,
        'map_section': 'East',
        'image_URL': 'https://example.com/phase-1-east.svg',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload1East), equals('Phase 1E'));

      // Phase 2A -> Phase 2A
      final upload2A = MapUploadModel.fromJson({
        'id': 26,
        'name': 'BegoniaPS(Phase 2A).svg',
        'Phase': 2,
        'map_section': 'A',
        'image_URL': 'https://example.com/phase-2-a.svg',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload2A), equals('Phase 2A'));

      // Phase 2B -> Phase 2B
      final upload2B = MapUploadModel.fromJson({
        'id': 27,
        'name': 'Bergenia Ph-2B(Phase 2B).svg',
        'Phase': 2,
        'map_section': 'B',
        'image_URL': 'https://example.com/phase-2-b.svg',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload2B), equals('Phase 2B'));

      // Phase 3 (null map_section) -> Phase 3
      final upload3 = MapUploadModel.fromJson({
        'id': 9,
        'name': 'CarnationPS v2(Phase 3).svg',
        'Phase': 3,
        'map_section': null,
        'image_URL': 'https://example.com/phase-3.svg',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload3), equals('Phase 3'));

      // Phase 1 Commercial -> Phase 1 Commercial
      final uploadComm = MapUploadModel.fromJson({
        'id': 11,
        'name': 'update-map-color-mvlc-commercial-colored.svg',
        'Phase': 1,
        'type': 'commercial',
        'image_URL': 'https://example.com/commercial.svg',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(uploadComm), equals('Phase 1 Commercial'));
    });

    test('Live fetch all data under MVLC project and verify chip labels', () async {
      final uploads = await SupabaseService.fetchMapUploads(
        project: 'MVLC',
        projectId: 14,
        forceRefresh: true,
      );

      expect(uploads, isNotEmpty);

      // Verify all uploads have valid image_URL
      for (final u in uploads) {
        expect(u.image_URL, isNotEmpty);
      }

      final chipLabels = uploads
          .map((u) => InteractiveSalesMapScreen.formatMapChipLabel(u))
          .toList();

      // Specifically verify Phase 2 with map section East is Phase 2E
      expect(chipLabels.contains('Phase 2E'), isTrue);
      // Verify Phase 1 with map section East is Phase 1E
      expect(chipLabels.contains('Phase 1E'), isTrue);
      // Verify Phase 3
      expect(chipLabels.contains('Phase 3'), isTrue);
      // Verify subphases 2A, 2B, 1A, 1B, 1C
      expect(chipLabels.contains('Phase 2A'), isTrue);
      expect(chipLabels.contains('Phase 2B'), isTrue);
      expect(chipLabels.contains('Phase 1A'), isTrue);
      expect(chipLabels.contains('Phase 1B'), isTrue);
      expect(chipLabels.contains('Phase 1C'), isTrue);
      // Verify Commercial
      expect(chipLabels.contains('Phase 1 Commercial'), isTrue);
    });

    test('MSCC choice chip names format as floor level (e.g. 2nd Floor, 3rd Floor)', () {
      final upload2 = MapUploadModel.fromJson({
        'id': 12,
        'project': 'MSCC - paused',
        'name': 'secondfloor.jpg',
        'Phase': 2,
        'image_URL': 'https://example.com/secondfloor.jpg',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload2), equals('2nd Floor'));

      final upload3 = MapUploadModel.fromJson({
        'id': 13,
        'project': 'MSCC - paused',
        'name': '3rd floor Condo Official.png',
        'Phase': 3,
        'image_URL': 'https://example.com/3rd_floor.png',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload3), equals('3rd Floor'));

      final upload4 = MapUploadModel.fromJson({
        'id': 14,
        'project': 'MSCC',
        'name': '4th floor Condo Official.png',
        'Phase': 4,
        'image_URL': 'https://example.com/4th_floor.png',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload4), equals('4th Floor'));

      final upload5 = MapUploadModel.fromJson({
        'id': 15,
        'project': 'MSCC',
        'name': '5th floor Condo Official.png',
        'Phase': 5,
        'image_URL': 'https://example.com/5th_floor.png',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload5), equals('5th Floor'));

      final upload6 = MapUploadModel.fromJson({
        'id': 16,
        'project': 'MSCC',
        'name': '6th floor Condo Official.png',
        'Phase': 6,
        'image_URL': 'https://example.com/6th_floor.png',
      });
      expect(InteractiveSalesMapScreen.formatMapChipLabel(upload6), equals('6th Floor'));
    });

    test('Live fetch all data under MSCC project and verify choice chip labels are floor levels', () async {
      final uploads = await SupabaseService.fetchMapUploads(
        project: 'MSCC',
        projectId: 16,
        forceRefresh: true,
      );

      expect(uploads, isNotEmpty);

      final chipLabels = uploads
          .map((u) => InteractiveSalesMapScreen.formatMapChipLabel(u, activeProject: 'MSCC'))
          .toList();

      expect(chipLabels.contains('2nd Floor'), isTrue);
      expect(chipLabels.contains('3rd Floor'), isTrue);
      expect(chipLabels.contains('4th Floor'), isTrue);
      expect(chipLabels.contains('5th Floor'), isTrue);
      expect(chipLabels.contains('6th Floor'), isTrue);

      // Verify none of them contain 'Phase'
      for (final label in chipLabels) {
        expect(label.toLowerCase().contains('phase'), isFalse);
        expect(label.toLowerCase().contains('floor'), isTrue);
      }
    });
  });
}

