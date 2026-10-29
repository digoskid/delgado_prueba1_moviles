import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'viewmodels/evaluacion_viewmodel.dart';
import 'views/pantalla_inicio.dart';
import 'views/pantalla_principal.dart';
import 'views/pantalla_resultados.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EvaluacionViewModel(),
      child: MaterialApp(
        title: 'EduCalc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF7B61FF),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const PantallaInicio(),
          '/principal': (_) => const PantallaPrincipal(),
          '/resultados': (_) => const PantallaResultados(),
        },
      ),
    );
  }
}
