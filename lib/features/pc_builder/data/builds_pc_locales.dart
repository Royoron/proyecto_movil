import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:mi_primer_app/core/json.dart';
import 'package:mi_primer_app/features/pc_builder/domain/build_pc.dart';
import 'package:mi_primer_app/features/pc_builder/domain/builds_pc_repository.dart';

typedef LectorDeAssets = Future<String> Function(String ruta);

class BuildsPcLocales implements BuildsPcRepository {
  BuildsPcLocales({
    LectorDeAssets? lector,
    this.ruta = 'assets/data/builds_pc.json',
  }) : _lector = lector ?? rootBundle.loadString;

  final LectorDeAssets _lector;
  final String ruta;

  List<BuildPc>? _cache;

  @override
  Future<List<BuildPc>> obtenerTodos() async {
    final guardado = _cache;
    if (guardado != null) return guardado;

    final crudo = await _lector(ruta);
    final decodificado = jsonDecode(crudo);

    if (decodificado is! List) {
      throw const CampoInvalido(
        '(raiz)',
        'el archivo debe contener una lista',
        null,
      );
    }

    return _cache = decodificado
        .map((e) => BuildPc.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<BuildPc?> obtenerPorId(String id) async {
    for (final build in await obtenerTodos()) {
      if (build.id == id) return build;
    }

    return null;
  }

  @override
  Future<List<BuildPc>> obtenerAgregablesAlCarrito() async {
    final builds = await obtenerTodos();
    return builds.where((build) => build.sePuedeAgregarAlCarrito).toList();
  }
}
