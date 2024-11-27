import 'package:eventos_app/shared/shared.dart';
import 'package:flutter/material.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Placeholder(),
      bottomNavigationBar: const CustomNavigationbar(),
    );
  }
}