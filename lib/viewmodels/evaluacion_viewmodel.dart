import 'package:flutter/material.dart';
import '../models/evaluacion_model.dart';

class EvaluacionViewModel extends ChangeNotifier {
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();

  String? errorNota1;
  String? errorNota2;
  String? errorNota3;

  EvaluacionModel? _resultado;
  EvaluacionModel? get resultado => _resultado;

  bool _validarNota(String valor, int campo) {
    final parsed = double.tryParse(valor.replaceAll(',', '.'));
    if (parsed == null) {
      _setError(campo, 'Ingresa un número válido');
      return false;
    }
    if (parsed < 0 || parsed > 20) {
      _setError(campo, 'La nota debe estar entre 0 y 20');
      return false;
    }
    _setError(campo, null);
    return true;
  }

  void _setError(int campo, String? mensaje) {
    if (campo == 1) errorNota1 = mensaje;
    if (campo == 2) errorNota2 = mensaje;
    if (campo == 3) errorNota3 = mensaje;
  }

  bool calcular() {
    final v1 = _validarNota(nota1Controller.text.trim(), 1);
    final v2 = _validarNota(nota2Controller.text.trim(), 2);
    final v3 = _validarNota(nota3Controller.text.trim(), 3);
    notifyListeners();
    if (!v1 || !v2 || !v3) return false;

    final n1 = double.parse(nota1Controller.text.trim().replaceAll(',', '.'));
    final n2 = double.parse(nota2Controller.text.trim().replaceAll(',', '.'));
    final n3 = double.parse(nota3Controller.text.trim().replaceAll(',', '.'));
    final promedio = (n1 + n2 + n3) / 3;

    String estado;
    if (promedio >= 14) {
      estado = 'Aprobado';
    } else if (promedio >= 10) {
      estado = 'En Recuperación';
    } else {
      estado = 'Reprobado';
    }

    _resultado = EvaluacionModel(
      nota1: n1,
      nota2: n2,
      nota3: n3,
      promedio: promedio,
      estado: estado,
    );
    notifyListeners();
    return true;
  }

  void limpiar() {
    nota1Controller.clear();
    nota2Controller.clear();
    nota3Controller.clear();
    errorNota1 = null;
    errorNota2 = null;
    errorNota3 = null;
    _resultado = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nota1Controller.dispose();
    nota2Controller.dispose();
    nota3Controller.dispose();
    super.dispose();
  }
}
