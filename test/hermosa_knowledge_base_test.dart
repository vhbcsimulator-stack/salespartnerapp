import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/features/chat/services/hermosa_knowledge_base.dart';

void main() {
  group('Hermosa Knowledge Base (Asset Files for AI)', () {
    test('System context directly provides all 3 official developer documents for the AI to read', () {
      final ctx = HermosaKnowledgeBase.systemContext;

      // Ensure all 3 document source files are identified
      expect(ctx, contains('DOCUMENT 1: Mountain View Leisure Community (MVLC) FAQ & Guidelines'));
      expect(ctx, contains('Source File: asset/mvlc.pdf'));
      expect(ctx, contains('DOCUMENT 2: EastWest Resort Hub Development (ERHD) FAQ & Specifications'));
      expect(ctx, contains('Source File: asset/erhd.pdf'));
      expect(ctx, contains('DOCUMENT 3: Mountain Suites and Country Club (MSCC) FAQ & Specifications'));
      expect(ctx, contains('Source File: asset/mscc.pdf'));

      // Ensure no hallucinated contacts or corporate addresses
      expect(ctx, isNot(contains('+63 (2) 8888-VHBC')));
      expect(ctx, isNot(contains('Ortigas Center')));
      expect(ctx, isNot(contains('Alulod')));
    });

    test('MVLC Document contains verbatim facts from asset/mvlc.pdf', () {
      final doc = HermosaKnowledgeBase.mvlcDocument;

      expect(doc, contains('FREQUENTLY ASKED QUESTIONS'));
      expect(doc, contains('MVLC: Brgy. Munting Indang, Nasugbu, Batangas'));
      expect(doc, contains('MVLC: Flame Fuel (then turn right, 5.7 km from Highway, around 8-10mins)'));
      expect(doc, contains('Residential - 105 sqm'));
      expect(doc, contains('Residential – 1,346 sqm'));
      expect(doc, contains('Westgate Ph 1'));
      expect(doc, contains('Eastgate Ph 1'));
      expect(doc, contains('0001950'));
      expect(doc, contains('BATELEC 1'));
      expect(doc, contains('PRIME WATER'));
      expect(doc, contains('West Valley Fault'));
    });

    test('ERHD Document contains verbatim facts from asset/erhd.pdf', () {
      final doc = HermosaKnowledgeBase.erhdDocument;

      expect(doc, contains('EASTWEST RESORT HUB DEVELOPMENT (ERHD)'));
      expect(doc, contains('Brgy. Daine 1, Indang, Cavite, along East-West Road'));
      expect(doc, contains('12.5-hectare'));
      expect(doc, contains('natural river flowing through'));
      expect(doc, contains('Japanese teppanyaki'));
      expect(doc, contains('Farm lots ranging from 600–1,200 sqm'));
      expect(doc, contains('PHIVOLCS certificate'));
    });

    test('MSCC Document contains verbatim facts from asset/mscc.pdf', () {
      final doc = HermosaKnowledgeBase.msccDocument;

      expect(doc, contains('MOUNTAIN SUITES AND COUNTRY CLUB (MSCC)'));
      expect(doc, contains('Inside Mountain View Leisure Community, Brgy. Munting Indang, Nasugbu'));
      expect(doc, contains('14,000 sqm with 2 towers'));
      expect(doc, contains('6 floors and 135 units'));
      expect(doc, contains('₱80/sqm (starting rate)'));
      expect(doc, contains('Fully-Furnished Units Inclusions'));
      expect(doc, contains('Semi-Furnished Units Inclusions'));
      expect(doc, contains('Refrigerator'));
      expect(doc, contains('Air Conditioning Unit'));
    });
  });
}
