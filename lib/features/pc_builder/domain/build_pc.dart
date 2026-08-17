import 'package:mi_primer_app/core/comparaciones.dart';
import 'package:mi_primer_app/core/json.dart';
import 'package:mi_primer_app/features/pc_builder/domain/estado_build_pc.dart';
import 'package:mi_primer_app/features/pc_builder/domain/resumen_energetico.dart';

class BuildPc {
  const BuildPc({
    required this.id,
    required this.nombre,
    required this.componentes,
    required this.resumenEnergetico,
    required this.precioTotal,
    required this.creadoEn,
    required this.estado,
  });

  factory BuildPc.fromJson(Map<String, dynamic> json) => BuildPc(
    id: leerTexto(json, 'id'),
    nombre: leerTexto(json, 'nombre'),
    componentes: leerTextos(json, 'componentes'),
    resumenEnergetico: ResumenEnergetico.fromJson(
      leerMapa(json, 'resumenEnergetico'),
    ),
    precioTotal: leerDecimal(json, 'precioTotal'),
    creadoEn: leerFecha(json, 'creadoEn'),
    estado: EstadoBuildPc.fromJson(leerMapa(json, 'estado')),
  );

  final String id;
  final String nombre;
  final List<String> componentes;
  final ResumenEnergetico resumenEnergetico;
  final double precioTotal;
  final DateTime creadoEn;
  final EstadoBuildPc estado;

  bool get tieneComponentes => componentes.isNotEmpty;

  bool get sePuedeAgregarAlCarrito =>
      estado.sePuedeAgregarAlCarrito && resumenEnergetico.fuenteSuficiente;

  int get cantidadComponentes => componentes.length;

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'componentes': componentes,
    'resumenEnergetico': resumenEnergetico.toJson(),
    'precioTotal': precioTotal,
    'creadoEn': creadoEn.toUtc().toIso8601String(),
    'estado': estado.toJson(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildPc &&
          other.id == id &&
          other.nombre == nombre &&
          listasIguales(other.componentes, componentes) &&
          other.resumenEnergetico == resumenEnergetico &&
          other.precioTotal == precioTotal &&
          other.creadoEn == creadoEn &&
          other.estado == estado;

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    Object.hashAll(componentes),
    resumenEnergetico,
    precioTotal,
    creadoEn,
    estado,
  );

  @override
  String toString() => 'BuildPc($id, $nombre, ${estado.etiqueta})';
}
