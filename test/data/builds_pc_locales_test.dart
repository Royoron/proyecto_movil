import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_primer_app/core/json.dart';
import 'package:mi_primer_app/features/pc_builder/data/builds_pc_locales.dart';

const _json = '''
[
  {
    "id": "build-001",
    "nombre": "Gaming Alto Rendimiento",
    "componentes": ["cpu-ryzen-7", "gpu-rtx-4070", "fuente-750w"],
    "resumenEnergetico": { "wattsEstimados": 520, "wattsFuente": 750 },
    "precioTotal": 6200000,
    "creadoEn": "2026-08-16T19:00:00Z",
    "estado": { "tipo": "compatible", "validadoEn": "2026-08-16T19:05:00Z" }
  },
  {
    "id": "build-002",
    "nombre": "Build incompleto",
    "componentes": ["cpu-i5"],
    "resumenEnergetico": { "wattsEstimados": 120, "wattsFuente": 0 },
    "precioTotal": 900000,
    "creadoEn": "2026-08-16T20:00:00Z",
    "estado": { "tipo": "incompleto", "faltantes": ["fuente"] }
  }
]
''';

void main() {
  test('lee la lista completa del archivo', () async {
    final repo = BuildsPcLocales(lector: (_) async => _json);

    expect((await repo.obtenerTodos()).length, 2);
  });

  test('busca por id y devuelve null cuando no existe', () async {
    final repo = BuildsPcLocales(lector: (_) async => _json);

    expect(
      (await repo.obtenerPorId('build-001'))?.nombre.contains('Gaming'),
      true,
    );
    expect(await repo.obtenerPorId('no-existe'), null);
  });

  test('filtra builds que se pueden agregar al carrito', () async {
    final repo = BuildsPcLocales(lector: (_) async => _json);

    expect((await repo.obtenerAgregablesAlCarrito()).length, 1);
  });

  test('un archivo que no es lista se rechaza', () async {
    final repo = BuildsPcLocales(lector: (_) async => '{"a": 1}');
    var lanzo = false;

    try {
      await repo.obtenerTodos();
    } on CampoInvalido {
      lanzo = true;
    }

    expect(lanzo, true);
  });

  test(
    'el asset declarado en pubspec existe y el modelo lo entiende',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      final repo = BuildsPcLocales(lector: rootBundle.loadString);

      expect((await repo.obtenerTodos()).length >= 3, true);
    },
  );
}
