import 'package:mi_primer_app/core/comparaciones.dart';
import 'package:mi_primer_app/core/json.dart';

sealed class EstadoBuildPc {
  const EstadoBuildPc();

  factory EstadoBuildPc.fromJson(Map<String, dynamic> json) {
    final tipo = leerTexto(json, 'tipo');

    return switch (tipo) {
      'borrador' => const BuildBorrador(),
      'incompleto' => BuildIncompleto(leerTextos(json, 'faltantes')),
      'compatible' => BuildCompatible(leerFecha(json, 'validadoEn')),
      'incompatible' => BuildIncompatible(leerTextos(json, 'conflictos')),
      'listo_para_carrito' => BuildListoParaCarrito(
        leerFecha(json, 'aprobadoEn'),
      ),
      _ => throw CampoInvalido('tipo', 'no es un estado de build valido', tipo),
    };
  }

  String get etiqueta;

  bool get sePuedeAgregarAlCarrito;

  Map<String, dynamic> toJson();
}

class BuildBorrador extends EstadoBuildPc {
  const BuildBorrador();

  @override
  String get etiqueta => 'Borrador';

  @override
  bool get sePuedeAgregarAlCarrito => false;

  @override
  Map<String, dynamic> toJson() => {'tipo': 'borrador'};

  @override
  bool operator ==(Object other) => other is BuildBorrador;

  @override
  int get hashCode => runtimeType.hashCode;
}

class BuildIncompleto extends EstadoBuildPc {
  const BuildIncompleto(this.faltantes);

  final List<String> faltantes;

  @override
  String get etiqueta => 'Incompleto';

  @override
  bool get sePuedeAgregarAlCarrito => false;

  @override
  Map<String, dynamic> toJson() => {
    'tipo': 'incompleto',
    'faltantes': faltantes,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildIncompleto && listasIguales(other.faltantes, faltantes);

  @override
  int get hashCode => Object.hash(runtimeType, Object.hashAll(faltantes));
}

class BuildCompatible extends EstadoBuildPc {
  const BuildCompatible(this.validadoEn);

  final DateTime validadoEn;

  @override
  String get etiqueta => 'Compatible';

  @override
  bool get sePuedeAgregarAlCarrito => true;

  @override
  Map<String, dynamic> toJson() => {
    'tipo': 'compatible',
    'validadoEn': validadoEn.toUtc().toIso8601String(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildCompatible && other.validadoEn == validadoEn;

  @override
  int get hashCode => Object.hash(runtimeType, validadoEn);
}

class BuildIncompatible extends EstadoBuildPc {
  const BuildIncompatible(this.conflictos);

  final List<String> conflictos;

  @override
  String get etiqueta => 'Incompatible';

  @override
  bool get sePuedeAgregarAlCarrito => false;

  @override
  Map<String, dynamic> toJson() => {
    'tipo': 'incompatible',
    'conflictos': conflictos,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildIncompatible && listasIguales(other.conflictos, conflictos);

  @override
  int get hashCode => Object.hash(runtimeType, Object.hashAll(conflictos));
}

class BuildListoParaCarrito extends EstadoBuildPc {
  const BuildListoParaCarrito(this.aprobadoEn);

  final DateTime aprobadoEn;

  @override
  String get etiqueta => 'Listo para carrito';

  @override
  bool get sePuedeAgregarAlCarrito => true;

  @override
  Map<String, dynamic> toJson() => {
    'tipo': 'listo_para_carrito',
    'aprobadoEn': aprobadoEn.toUtc().toIso8601String(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildListoParaCarrito && other.aprobadoEn == aprobadoEn;

  @override
  int get hashCode => Object.hash(runtimeType, aprobadoEn);
}
