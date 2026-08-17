import 'package:flutter_test/flutter_test.dart';
import 'package:mi_primer_app/core/json.dart';
import 'package:mi_primer_app/features/pc_builder/domain/estado_build_pc.dart';

void main() {
  test('lee un estado compatible con fecha de validacion', () {
    final estado = EstadoBuildPc.fromJson({
      'tipo': 'compatible',
      'validadoEn': '2026-08-16T19:05:00Z',
    });

    expect(estado is BuildCompatible, true);
    expect(estado.sePuedeAgregarAlCarrito, true);
  });

  test('lee un estado incompleto con sus faltantes', () {
    final estado = EstadoBuildPc.fromJson({
      'tipo': 'incompleto',
      'faltantes': ['fuente', 'gabinete'],
    });

    expect(estado, const BuildIncompleto(['fuente', 'gabinete']));
  });

  test('rechaza estados desconocidos', () {
    var lanzo = false;

    try {
      EstadoBuildPc.fromJson({'tipo': 'pausado'});
    } on CampoInvalido {
      lanzo = true;
    }

    expect(lanzo, true);
  });
}
