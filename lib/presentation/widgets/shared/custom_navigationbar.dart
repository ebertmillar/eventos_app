import 'package:flutter/material.dart';

class CustomNavigationbar extends StatelessWidget {
  const CustomNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, color: Colors.black38,),
            label: 'Descubre',
          ),              
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black38,),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number, color: Colors.black38,),
            label: 'Mis Ticktes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch, color: Colors.black38,),
            label: 'Crear evento',
          ), 
        ],
        currentIndex: 0,// Cambia este índice para mostrar el ítem activo
        onTap: (index) {
        //   // Maneja lanavegación aquí
        },
        // unselectedItemColor: Colors.black38,
        // unselectedLabelStyle: TextStyle(fontSize: 2)
      );
  }
}