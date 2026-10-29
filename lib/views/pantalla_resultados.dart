import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/evaluacion_model.dart';
import '../viewmodels/evaluacion_viewmodel.dart';

class PantallaResultados extends StatelessWidget {
  const PantallaResultados({super.key});

  @override
  Widget build(BuildContext context) {
    final resultado = ModalRoute.of(context)!.settings.arguments as EvaluacionModel;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0C29),
              Color(0xFF302B63),
              Color(0xFF24243E),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildTopBar(context),
                const SizedBox(height: 40),
                _buildStatusBadge(resultado),
                const SizedBox(height: 32),
                _buildPromedioCard(resultado),
                const SizedBox(height: 20),
                _buildNotasCard(resultado),
                const Spacer(),
                _buildActions(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white12),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white70, size: 18),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'Resultados',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Color _estadoColor(String estado) {
    switch (estado) {
      case 'Aprobado':
        return const Color(0xFF00E5A0);
      case 'En Recuperación':
        return const Color(0xFFFFB347);
      default:
        return const Color(0xFFFF6B6B);
    }
  }

  IconData _estadoIcon(String estado) {
    switch (estado) {
      case 'Aprobado':
        return Icons.check_circle_rounded;
      case 'En Recuperación':
        return Icons.warning_amber_rounded;
      default:
        return Icons.cancel_rounded;
    }
  }

  Widget _buildStatusBadge(EvaluacionModel resultado) {
    final color = _estadoColor(resultado.estado);
    final icon = _estadoIcon(resultado.estado);
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.12),
            border: Border.all(color: color.withValues(alpha: 0.40), width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.30),
                blurRadius: 30,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 48),
        ),
        const SizedBox(height: 20),
        Text(
          resultado.estado,
          style: GoogleFonts.outfit(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: color,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Evaluación académica completada',
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }

  Widget _buildPromedioCard(EvaluacionModel resultado) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF7B61FF).withValues(alpha: 0.25),
            const Color(0xFF00D2FF).withValues(alpha: 0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF7B61FF).withValues(alpha: 0.30)),
      ),
      child: Column(
        children: [
          Text(
            'Promedio Final',
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: Colors.white54,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            resultado.promedio.toStringAsFixed(2),
            style: GoogleFonts.outfit(
              fontSize: 58,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'sobre 20 puntos',
            style: GoogleFonts.outfit(fontSize: 13, color: Colors.white38),
          ),
        ],
      ),
    );
  }

  Widget _buildNotasCard(EvaluacionModel resultado) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        children: [
          _buildNotaItem('Nota 1', resultado.nota1),
          _buildDivider(),
          _buildNotaItem('Nota 2', resultado.nota2),
          _buildDivider(),
          _buildNotaItem('Nota 3', resultado.nota3),
        ],
      ),
    );
  }

  Widget _buildNotaItem(String label, double valor) {
    return Expanded(
      child: Column(
        children: [
          Text(
            valor.toStringAsFixed(1),
            style: GoogleFonts.outfit(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(fontSize: 12, color: Colors.white38),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 50,
      color: Colors.white12,
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.read<EvaluacionViewModel>().limpiar();
            Navigator.popUntil(context, ModalRoute.withName('/principal'));
          },
          child: Container(
            width: double.infinity,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Color(0xFF7B61FF), Color(0xFF00D2FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7B61FF).withValues(alpha: 0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Nueva Evaluación',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () {
            context.read<EvaluacionViewModel>().limpiar();
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          },
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
              color: Colors.white.withValues(alpha: 0.05),
            ),
            child: Center(
              child: Text(
                'Ir al Inicio',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white60,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
