import 'package:mi_primer_app/core/json.dart';

/// Consumo estimado de una configuracion de PC frente a su fuente.
class ResumenEnergetico {
  const ResumenEnergetico({
    required this.wattsEstimados,
    required this.wattsFuente,
  });

  factory ResumenEnergetico.fromJson(Map<String, dynamic> json) =>
      ResumenEnergetico(
        wattsEstimados: leerEntero(json, 'wattsEstimados'),
        wattsFuente: leerEntero(json, 'wattsFuente'),
      );

  final int wattsEstimados;
  final int wattsFuente;

  bool get fuenteSuficiente =>
      wattsFuente > 0 && wattsFuente >= (wattsEstimados * 1.25).ceil();

  Map<String, dynamic> toJson() => {
    'wattsEstimados': wattsEstimados,
    'wattsFuente': wattsFuente,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResumenEnergetico &&
          other.wattsEstimados == wattsEstimados &&
          other.wattsFuente == wattsFuente;

  @override
  int get hashCode => Object.hash(wattsEstimados, wattsFuente);

  @override
  String toString() => 'ResumenEnergetico($wattsEstimados/$wattsFuente W)';
}
