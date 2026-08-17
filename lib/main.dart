import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/pc_builder/data/builds_pc_locales.dart';
import 'package:mi_primer_app/features/pc_builder/domain/build_pc.dart';

void main() => runApp(const NexusApp());

class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'NEXUS Movil',
    theme: ThemeData(colorSchemeSeed: Colors.teal),
    home: const PantallaBuildsPc(),
  );
}

class PantallaBuildsPc extends StatefulWidget {
  const PantallaBuildsPc({super.key});

  @override
  State<PantallaBuildsPc> createState() => _PantallaBuildsPcState();
}

class _PantallaBuildsPcState extends State<PantallaBuildsPc> {
  late final Future<List<BuildPc>> _builds = BuildsPcLocales().obtenerTodos();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('NEXUS PC Builder')),
    body: FutureBuilder<List<BuildPc>>(
      future: _builds,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('No se pudo leer:\n${snapshot.error}'));
        }

        final builds = snapshot.data ?? const <BuildPc>[];
        return ListView.separated(
          itemCount: builds.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final build = builds[i];

            return ListTile(
              title: Text(build.nombre),
              subtitle: Text(
                '${build.estado.etiqueta} · '
                '${build.cantidadComponentes} componentes · '
                '${build.resumenEnergetico.wattsEstimados} W',
              ),
              trailing: build.sePuedeAgregarAlCarrito
                  ? const Icon(Icons.shopping_cart_outlined)
                  : const Icon(Icons.warning_amber_outlined),
            );
          },
        );
      },
    ),
  );
}
