import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/pc_builder/domain/build_pc.dart';

class BuildPcCard extends StatelessWidget {
  const BuildPcCard({super.key, required this.buildPc});

  final BuildPc buildPc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(buildPc.nombre, style: theme.textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  '${buildPc.estado.etiqueta} · '
                  '${buildPc.cantidadComponentes} componentes · '
                  '${buildPc.resumenEnergetico.wattsEstimados} W',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              buildPc.sePuedeAgregarAlCarrito
                  ? Icons.shopping_cart_outlined
                  : Icons.warning_amber_outlined,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
