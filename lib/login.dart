// login.dart
import 'package:flutter/material.dart';
import 'utils/constantes.dart';
import 'dart:math';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login(){
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      if(email.isEmpty && password.isEmpty){
        _errorMessage = 'Datos Incompletos';
      } else if (email != 'test@correo.mx' && password != 'FDM2') {
        _errorMessage = 'Correo y contraseña incorrectos';
      } else if (email != 'test@correo.mx') {
        _errorMessage = 'Correo incorrecto';
      } else if (password != 'FDM2') {
        _errorMessage = 'Contraseña incorrecta';
      } else {
        _errorMessage = '';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: Stack(
        children: [
          // Cuadrados de colores al azar
          Positioned.fill(
            child: RandomColoredSquares(),
          ),
          Center(
            child: Container(
              width: 400.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bienvenido a tu primer EXAMEN',
                    style: TextStyle(color: titulos, fontSize: 24.0),
                  ),
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text('Ingresa tu correo electronico:',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Correo',
                      border:OutlineInputBorder(
                        borderRadius:BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 1,
                          style: BorderStyle.none
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text('Ingresa tu contraseña:',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 1,
                          style: BorderStyle.none
                        )
                      )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  if(_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(
                    width: 300,
                    child:
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: botones,
                      ),
                      child: Text('Iniciar Sesión',
                        style:
                        TextStyle(color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Mi primer examen, ¿estará sencillo?',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RandomColoredSquares extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final random = Random();
    final colors = [fondo, fondo2, fondo3, fondo4];
    final int rows = 6;
    final int columns = 4;

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(), // Deshabilitar el desplazamiento
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns, // Número de columnas
      ),
      itemBuilder: (context, index) {
        final row = index ~/ columns;
        final column = index % columns;

        // Generar una lista de colores aleatorios para cada fila
        if (column == 0) {
          colors.shuffle(random);
        }

        return Container(
          decoration: BoxDecoration(
            color: colors[column],
            borderRadius: BorderRadius.circular(55.0),
          ),
        );
      },
      itemCount: rows * columns, // Número total de cuadrados
    );
  }
}
