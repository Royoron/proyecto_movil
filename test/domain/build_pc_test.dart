import 'package:flutter_test/flutter_test.dart';
import 'package:mi_primer_app/features/pc_builder/domain/build_pc.dart';

final _json = {
  'id': 'build-001',
  'nombre': 'Gaming Alto Rendimiento',
  'componentes': ['cpu-ryzen-7', 'gpu-rtx-4070', 'fuente-750w'],
  'resumenEnergetico': {'wattsEstimados': 520, 'wattsFuente': 750},
  'precioTotal': 6200000,
  'creadoEn': '2026-08-16T19:00:00Z',
  'estado': {'tipo': 'compatible', 'validadoEn': '2026-08-16T19:05:00Z'},
};

void main() {
  test('lee un build de PC desde JSON', () {
    final build = BuildPc.fromJson(_json);

    expect(build.id, 'build-001');
    expect(build.cantidadComponentes, 3);
    expect(build.tieneComponentes, true);
  });

  test('sobrevive la ida y vuelta JSON', () {
    final build = BuildPc.fromJson(_json);

    expect(BuildPc.fromJson(build.toJson()), build);
  });

  test('solo se puede agregar si el estado y la fuente lo permiten', () {
    final build = BuildPc.fromJson(_json);

    expect(build.sePuedeAgregarAlCarrito, true);
  });
}
