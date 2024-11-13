import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationbar extends StatefulWidget {
  const CustomNavigationbar({super.key});

  @override
  CustomNavigationbarState createState() => CustomNavigationbarState();
}

class CustomNavigationbarState extends State<CustomNavigationbar> {
  // Controla el índice actual
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex, // Actualiza el índice actual
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded, color: Colors.black38),
          label: 'Descubre',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.black38),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_number, color: Colors.black38),
          label: 'Mis Tickets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rocket_launch, color: Colors.black38),
          label: 'Crear evento',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index; // Actualiza el índice cuando se selecciona una opción
        });

        // Navegar según el índice seleccionado
        switch (index) {
          case 0:
            context.go('/'); // Home Screen
            break;
          case 1:
            context.go('/search'); // Buscar Screen
            break;
          case 2:
            context.go('/my-tickets'); // Mis Tickets Screen
            break;
          case 3:
            context.go('/create-event'); // Crear Evento Screen
            break;
        }
      },
    );
  }
}
