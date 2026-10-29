import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(flex: 2),
                _buildLogo(),
                const SizedBox(height: 40),
                _buildTitle(),
                const SizedBox(height: 16),
                _buildSubtitle(),
                const Spacer(flex: 3),
                _buildStartButton(context),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF7B61FF), Color(0xFF00D2FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B61FF).withValues(alpha: 0.5),
            blurRadius: 35,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.school_rounded,
        color: Colors.white,
        size: 52,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'EduCalc',
      style: GoogleFonts.outfit(
        fontSize: 42,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: -1,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Evaluación Académica\nInteligente',
      textAlign: TextAlign.center,
      style: GoogleFonts.outfit(
        fontSize: 17,
        color: Colors.white60,
        height: 1.5,
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/principal'),
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
            'Comenzar',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
