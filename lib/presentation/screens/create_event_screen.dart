import 'package:easy_stepper/easy_stepper.dart';
import 'package:eventos_app/presentation/providers/create_event_form_provider.dart';
import 'package:eventos_app/presentation/providers/step_provider.dart';
import 'package:eventos_app/presentation/screens/agenda_form_screen.dart';
import 'package:eventos_app/presentation/screens/datos_contacto_screen.dart';
import 'package:eventos_app/presentation/screens/datos_del_evento_form.dart';
import 'package:eventos_app/presentation/screens/incripciones_form.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_appbar.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_filled_button.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(stepProvider);
    final eventFormNotifier =ref.watch(createEventFormProvider);

    return Scaffold(
      appBar: const CustomAppbar(),
      body: SafeArea(
        child: Column(
          children: [
            // Línea de tiempo fija en la parte superior
            Container(
              height: 55,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(4),
              child: EasyStepper(
                activeStep: currentStep,
                direction: Axis.horizontal,
                fitWidth: false,
                internalPadding: 0,
                lineStyle: const LineStyle(
                  lineLength: 65,
                  lineType: LineType.normal,
                  lineThickness: 2,
                  finishedLineColor: Colors.orange,
                  activeLineColor: Colors.grey,
                  unreachedLineColor: Colors.grey,
                ),
                stepShape: StepShape.circle,
                borderThickness: 1,
                stepRadius: 7,
                activeStepBorderType: BorderType.normal,
                activeStepBackgroundColor: Colors.orange,
                activeStepBorderColor: Colors.orange,
                unreachedStepBorderColor: Colors.grey,
                finishedStepBorderColor: Colors.red,
                steps: [
                  const EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.orange,
                    ),
                    customTitle: Center(
                      child: Text(
                        'Datos del Evento',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: currentStep >= 1 ? Colors.orange : Colors.grey,
                    ),
                    customTitle: Center(
                      child: Text(
                        'Inscripciones',
                        style: TextStyle(
                          fontSize: 9,
                          color: currentStep >= 1 ? Colors.black87 : Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: currentStep >= 2 ? Colors.orange : Colors.grey,
                    ),
                    customTitle: Center(
                      child: Text(
                        'Agenda',
                        style: TextStyle(
                          fontSize: 9,
                          color: currentStep >= 2 ? Colors.black87 : Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: currentStep == 3 ? Colors.orange : Colors.grey,
                    ),
                    customTitle: Center(
                      child: Text(
                        'Datos de Contacto',
                        style: TextStyle(
                          fontSize: 9,
                          color: currentStep == 3 ? Colors.black87 : Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Contenido desplazable
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController, // Asigna el controlador
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (currentStep == 0) const DatosDelEventoForm(),
                    if (currentStep == 1) const InscriptionsForm(),
                    if (currentStep == 2) const AgendaFormScreen(),
                    if (currentStep == 3) const DatosContactoScreen(),

                    const SizedBox(height: 25),

                    // Botones desplazables junto con el contenido
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomOutlinedButton(
                                text: currentStep == 0 ? 'Cancelar' : 'Volver',
                                textColor: Colors.black,
                                borderColor: Colors.black,
                                onPressed: () {
                                  if (currentStep > 0) {
                                    ref.read(stepProvider.notifier).previousStep();
                                    _scrollToTop(); // Desplaza hacia arriba
                                  } else {
                                    GoRouter.of(context).go('/');// Cierra el diálogo o regresa a la pantalla anterior
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomFilledButton(
                                text: currentStep == 3 ? 'Crear evento' : 'Siguiente',
                                textColor: Colors.orange,
                                buttonColor: Colors.black87,
                                onPressed: () {
                                  ref.read(stepProvider.notifier).nextStep();
                                  _scrollToTop(); // Desplaza hacia arriba
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
