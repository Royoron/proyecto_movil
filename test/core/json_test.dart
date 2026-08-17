import 'package:flutter_test/flutter_test.dart';
import 'package:mi_primer_app/core/json.dart';

void main() {
  test('leerTexto rechaza textos vacios y nombra el campo', () {
    var lanzo = false;

    try {
      leerTexto({'nombre': '   '}, 'nombre');
    } on CampoInvalido catch (error) {
      lanzo = true;
      expect(error.toString().contains('nombre'), true);
    }

    expect(lanzo, true);
  });

  test('leerDecimal acepta enteros y decimales JSON', () {
    expect(leerDecimal({'precio': 10}, 'precio'), 10.0);
    expect(leerDecimal({'precio': 10.5}, 'precio'), 10.5);
  });

  test('leerTextos convierte un campo ausente en lista vacia', () {
    expect(leerTextos({}, 'componentes').isEmpty, true);
  });
}
