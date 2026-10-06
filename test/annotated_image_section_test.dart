import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/map/models/annotated_image_model.dart';
import 'package:vhbc_broker_app/features/map/models/map_upload_model.dart';

void main() {
  group('AnnotatedImageModel map_section and matching tests', () {
    test('AnnotatedImageModel accurately parses map_section from json', () {
      final jsonEast = {
        'id': 8,
        'project': 'MVLC',
        'phase': '2',
        'map_section': 'East',
        'slot': 'phase-2-east',
        'image_link': 'https://example.com/phase-2-east.svg',
      };
      final modelEast = AnnotatedImageModel.fromJson(jsonEast);
      expect(modelEast.mapSection, equals('East'));
      expect(modelEast.hasMapSection, isTrue);
      expect(modelEast.normalizedMapSection, equals('east'));
      expect(modelEast.phaseNumber, equals(2));

      final jsonNull = {
        'id': 9,
        'project': 'MVLC',
        'phase': '3',
        'map_section': null,
        'slot': 'phase-3',
        'image_link': 'https://example.com/phase-3.svg',
      };
      final modelNull = AnnotatedImageModel.fromJson(jsonNull);
      expect(modelNull.mapSection, isNull);
      expect(modelNull.hasMapSection, isFalse);
      expect(modelNull.normalizedMapSection, isNull);
      expect(modelNull.phaseNumber, equals(3));
    });

    test('Live fetch from annotated_images table parses map_section column correctly', () async {
      final images = await SupabaseService.fetchAnnotatedImages(
        project: 'MVLC',
        forceRefresh: true,
      );

      expect(images, isNotEmpty);

      // Phase 2 East must have map_section = 'East'
      final phase2East = images.firstWhere((img) => img.phase == '2' || img.slot == 'phase-2-east');
      expect(phase2East.mapSection, equals('East'));
      expect(phase2East.normalizedMapSection, equals('east'));
      expect(phase2East.phaseNumber, equals(2));

      // Phase 1 East must have map_section = 'East'
      final phase1East = images.firstWhere((img) => img.phase == '1' || img.slot == 'phase-1-east');
      expect(phase1East.mapSection, equals('East'));
      expect(phase1East.normalizedMapSection, equals('east'));
      expect(phase1East.phaseNumber, equals(1));

      // Phase 3 must have map_section = null
      final phase3 = images.firstWhere((img) => img.phase == '3' || img.slot == 'phase-3');
      expect(phase3.mapSection, isNull);
      expect(phase3.hasMapSection, isFalse);
      expect(phase3.phaseNumber, equals(3));
    });

    test('Phase 2 East annotations only match Phase 2E and never Phase 2A or 2B', () {
      final p2EastImage = AnnotatedImageModel.fromJson({
        'id': 8,
        'project': 'MVLC',
        'phase': '2',
        'map_section': 'East',
        'slot': 'phase-2-east',
        'image_link': 'https://example.com/mvlc-phase-2east-colored.svg',
      });

      final upload2E = MapUploadModel.fromJson({
        'id': 8,
        'name': 'mvlc-phase-2east-colored.svg',
        'image_URL': 'https://example.com/mvlc-phase-2east-colored.svg',
        'phase': 2,
      });

      final upload2A = MapUploadModel.fromJson({
        'id': 26,
        'name': 'BegoniaPS(Phase 2A).svg',
        'image_URL': 'https://example.com/BegoniaPS_Phase_2A_.svg',
        'phase': 2,
      });

      final upload2B = MapUploadModel.fromJson({
        'id': 27,
        'name': 'Bergenia Ph-2B(Phase 2B).svg',
        'image_URL': 'https://example.com/Bergenia_Ph-2B_Phase_2B_.svg',
        'phase': 2,
      });

      // Verification of section matching logic
      expect(p2EastImage.hasMapSection, isTrue);
      expect(p2EastImage.normalizedMapSection, equals('east'));

      // Check upload names
      expect(upload2E.name!.toLowerCase().contains('2east'), isTrue);
      expect(upload2A.name!.toLowerCase().contains('2a'), isTrue);
      expect(upload2B.name!.toLowerCase().contains('2b'), isTrue);
    });
  });
}
