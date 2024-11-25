import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationbar extends StatefulWidget {
  const CustomNavigationbar({super.key});  

  @override
  CustomNavigationbarState createState() => CustomNavigationbarState();
  
}

class CustomNavigationbarState extends State<CustomNavigationbar> {
  // Controla el índice actual
  
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = getIndexFromLocation(location);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex, // Actualiza el índice actual
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Descubre',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_number),
          label: 'Mis Tickets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rocket_launch),
          label: 'Crear evento',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/search');
            break;
          case 2:
            context.go('/my-tickets');
            break;
          case 3:
            context.go('/create-event');
            break;
        }
      },
    );
  }
}

int getIndexFromLocation(String location) {
  if (location == '/') return 0;
  if (location == '/search') return 1;
  if (location == '/my-tickets') return 2;
  if (location == '/create-event' || location =='/register') return 3;
  return -1; // Si la ruta no pertenece al BottomNavigationBar
}