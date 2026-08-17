import 'package:flutter_test/flutter_test.dart';
import 'package:mi_primer_app/features/pc_builder/domain/resumen_energetico.dart';

void main() {
  test('se compara por contenido', () {
    expect(
      const ResumenEnergetico(wattsEstimados: 300, wattsFuente: 500),
      const ResumenEnergetico(wattsEstimados: 300, wattsFuente: 500),
    );
  });

  test('detecta si la fuente tiene margen suficiente', () {
    expect(
      const ResumenEnergetico(
        wattsEstimados: 520,
        wattsFuente: 750,
      ).fuenteSuficiente,
      true,
    );
    expect(
      const ResumenEnergetico(
        wattsEstimados: 520,
        wattsFuente: 600,
      ).fuenteSuficiente,
      false,
    );
  });
}
