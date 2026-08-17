import 'package:flutter_test/flutter_test.dart';
import 'package:mi_primer_app/main.dart';

void main() {
  testWidgets('muestra la pantalla principal de NEXUS', (tester) async {
    await tester.pumpWidget(const NexusApp());

    expect(find.text('NEXUS PC Builder'), findsOneWidget);
  });
}
