import 'package:mi_primer_app/features/pc_builder/domain/build_pc.dart';

abstract interface class BuildsPcRepository {
  Future<List<BuildPc>> obtenerTodos();

  Future<BuildPc?> obtenerPorId(String id);

  Future<List<BuildPc>> obtenerAgregablesAlCarrito();
}
