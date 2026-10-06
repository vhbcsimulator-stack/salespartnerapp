import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/theme/app_theme.dart';
import 'package:vhbc_broker_app/features/splash/presentation/splash_screen.dart';

void main() {
  testWidgets('SplashScreen renders asset/bhrilogo.jpg with progress indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );

    // Initial render
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    final imageWidget = tester.widget<Image>(find.byType(Image));
    expect((imageWidget.image as AssetImage).assetName, 'asset/bhrilogo.jpg');

    // Settle pending timer
    await tester.pump(const Duration(milliseconds: 2500));
  });
}
