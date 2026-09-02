import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/pc_builder/data/builds_pc_locales.dart';
import 'package:mi_primer_app/features/pc_builder/domain/build_pc.dart';
import 'package:mi_primer_app/presentation/widgets/build_pc_card.dart';

void main() => runApp(const NexusApp());

class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'NEXUS Movil',
    theme: ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
        brightness: Brightness.dark,
      ),
    ),
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      'Buscar',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.search,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text('Builds', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<BuildPc>>(
                  future: _builds,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'No se pudo leer:\n${snapshot.error}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    }

                    final builds = snapshot.data ?? const <BuildPc>[];
                    return ListView.builder(
                      itemCount: builds.length,
                      itemBuilder: (context, i) =>
                          BuildPcCard(buildPc: builds[i]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
