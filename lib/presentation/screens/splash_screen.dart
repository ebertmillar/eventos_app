import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Redirige al HomeScreen después de 5 segundos
    Future.delayed(const Duration(seconds: 5), () {
      // Verifica si el widget sigue estando en el árbol antes de intentar navegar
      if (mounted) {
        context.go('/'); // Navega al HomeScreen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Evento ',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        TextSpan(
                          text: 'Fácil',
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                      ],
                    ),
                  )
                ],
              ),
        
              Center(
                
                child: Text('La manera más sencilla de crear y organizar tus eventos', 
                  style:TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              )
        
        
            ],
          ),       // Aquí puedes poner tu logo o imagen
              
          
          ),
      ),
      );
    
  }
}
