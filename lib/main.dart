import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa el paquete firebase_auth
import 'package:flutter_osavet_1/admin/home.dart';
import 'usuarios/principalpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBezupTH07YA92gXTHDCYzIdd-9tVWQ6mM",
      authDomain: "proyecto-osavet-31a8d.firebaseapp.com",
      projectId: "proyecto-osavet-31a8d",
      storageBucket: "proyecto-osavet-31a8d.appspot.com",
      messagingSenderId: "73165062602",
      appId: "1:73165062602:web:751e3dce314e5c550b0f33",
      measurementId: "G-628RH99342",
    ),
  );

  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Crea una instancia de FirebaseAuth

  User? user = _auth.currentUser; // Verifica si el usuario está autenticado
  if (user != null) {
    // El usuario está autenticado
    print('Usuario autenticado: ${user.uid}');
  } else {
    // El usuario no está autenticado
    print('Usuario no autenticado');

    try {
      // Auténtica al usuario con correo electrónico y contraseña
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: 'usuario@example.com',
        password: 'contraseña',
      );
      print('Usuario autenticado: ${userCredential.user!.uid}');
    } catch (e) {
      print('Error al autenticar al usuario: $e');
    }
  }

  // Verifica las reglas de seguridad de Firebase Storage
  // rules_version = '2';
  // service firebase.storage {
  //   match /b/{bucket}/o {
  //     match /{allPaths=**} {
  //       allow read: if request.auth != null;
  //       allow write: if false;
  //     }
  //   }
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OSAVET',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrincipalPage(),
    );
  }
}
