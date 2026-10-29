import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../viewmodels/evaluacion_viewmodel.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C29),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F0C29),
              Color(0xFF1A1745),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildTopBar(context),
                  const SizedBox(height: 36),
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildFormCard(context),
                  const SizedBox(height: 32),
                  _buildCalcularButton(context),
                  const SizedBox(height: 40),
                ],
              ),
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
          onTap: () {
            context.read<EvaluacionViewModel>().limpiar();
            Navigator.pop(context);
          },
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
          'Nueva Evaluación',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF7B61FF), Color(0xFF00D2FF)],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'Evaluación Académica',
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Ingresa las\ntres notas',
          style: GoogleFonts.outfit(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.1,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Rango válido: 0 — 20 puntos por nota.',
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context) {
    final vm = context.watch<EvaluacionViewModel>();
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildNotaField(
            context: context,
            controller: vm.nota1Controller,
            label: 'Nota 1',
            icon: Icons.looks_one_rounded,
            errorText: vm.errorNota1,
          ),
          const SizedBox(height: 20),
          _buildNotaField(
            context: context,
            controller: vm.nota2Controller,
            label: 'Nota 2',
            icon: Icons.looks_two_rounded,
            errorText: vm.errorNota2,
          ),
          const SizedBox(height: 20),
          _buildNotaField(
            context: context,
            controller: vm.nota3Controller,
            label: 'Nota 3',
            icon: Icons.looks_3_rounded,
            errorText: vm.errorNota3,
          ),
        ],
      ),
    );
  }

  Widget _buildNotaField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white60,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
          ],
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF7B61FF), size: 22),
            hintText: 'ej. 15.5',
            hintStyle: GoogleFonts.outfit(color: Colors.white24, fontSize: 15),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.07),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: errorText != null
                    ? const Color(0xFFFF6B6B)
                    : Colors.white.withValues(alpha: 0.10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF7B61FF), width: 1.5),
            ),
            errorText: errorText,
            errorStyle: GoogleFonts.outfit(
              color: const Color(0xFFFF6B6B),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalcularButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final vm = context.read<EvaluacionViewModel>();
        final ok = vm.calcular();
        if (ok && vm.resultado != null) {
          Navigator.pushNamed(context, '/resultados', arguments: vm.resultado);
        }
      },
      child: Container(
        width: double.infinity,
        height: 60,
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
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calculate_rounded, color: Colors.white, size: 22),
            const SizedBox(width: 10),
            Text(
              'Calcular Promedio',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
