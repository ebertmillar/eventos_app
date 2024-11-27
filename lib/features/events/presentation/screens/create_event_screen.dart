import 'package:easy_stepper/easy_stepper.dart';
import 'package:eventos_app/features/events/presentation/providers/create_event_form_provider.dart';
import 'package:eventos_app/features/events/presentation/providers/event_provider.dart';
import 'package:eventos_app/features/events/presentation/providers/step_provider.dart';
import 'package:eventos_app/features/events/presentation/screens/agenda_form_screen.dart';
import 'package:eventos_app/features/events/presentation/screens/datos_contacto_screen.dart';
import 'package:eventos_app/features/events/presentation/screens/datos_del_evento_form.dart';
import 'package:eventos_app/features/events/presentation/screens/incripciones_form.dart';
import 'package:eventos_app/shared/shared.dart';
import 'package:eventos_app/shared/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  
  final String? eventId;

  const CreateEventScreen({super.key, this.eventId});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    //ref.read(eventProvider(widget.eventId).notifier);
    if (widget.eventId != null) {
      ref.read(eventProvider(widget.eventId!).notifier);
    }
  }

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
    final eventState = ref.watch(eventProvider(widget.eventId!));
    //final eventFormNotifier =ref.watch(createEventFormProvider);

    if (widget.eventId != null && eventState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final event = widget.eventId != null ? eventState.event : null;

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
                    if (currentStep == 0) DatosDelEventoForm(event: event,),
                    if (currentStep == 1) InscriptionsForm(event: event,),
                    if (currentStep == 2) AgendaFormScreen(event: event),
                    if (currentStep == 3) DatosContactoScreen(event: event),

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
                                onPressed: () async {
                                  if(currentStep == 0){
                                    final eventFormNotifier = ref.read(createEventFormProvider(event!).notifier);
                                    await eventFormNotifier.onSubmitEventInformation();

                                    final eventFormState = ref.read(createEventFormProvider(event));
                                    if (!eventFormState.isEventInfoPosted || !eventFormState.isValid) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Por favor, completa la información del evento.')),
                                      );
                                      return;
                                    }      
                                  }
                                  if(currentStep == 1){
                                    final eventFormNotifier = ref.read(createEventFormProvider(event!).notifier);
                                    await eventFormNotifier.onSubmitEventInscription();

                                    final eventFormState = ref.read(createEventFormProvider(event));
                                    if (!eventFormState.isEventIncriptionPosted || !eventFormState.isValid) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Por favor, completa los detalles de inscripción.')),
                                      );
                                      return;
                                    }
                                  }
                                  if(currentStep == 2){
                                    final eventFormNotifier = ref.read(createEventFormProvider(event!).notifier);
                                    await eventFormNotifier.onSubmitEventAgenda();

                                    final eventFormState = ref.read(createEventFormProvider(event));
                                    if (!eventFormState.isEventAgendaPosted || !eventFormState.isValid) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Por favor, completa la agenda del evento.')),
                                      );
                                      return;
                                    }   
                                  }
                                  if (currentStep == 3) {
                                    if (eventState.event == null) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('No se encontró el evento para actualizar o crear.')),
                                        );
                                        return;
                                      }
                                      final eventFormNotifier = ref.read(createEventFormProvider(eventState.event!).notifier);
                                      await eventFormNotifier.onSubmitCreateEvent();   

                                      final eventFormState = ref.read(createEventFormProvider(eventState.event!));
                                      if (!eventFormState.isEventInfoPosted ||
                                          !eventFormState.isEventIncriptionPosted ||
                                          !eventFormState.isEventAgendaPosted ||
                                          !eventFormState.isEventContactPosted ||
                                          !eventFormState.isValid) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Por favor, completa toda la información del evento.')),
                                        );
                                        return;
                                      } 

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Evento creado correctamente')),
                                    );

                                    // Aquí puedes redirigir al usuario a otra pantalla o realizar cualquier otra acción necesaria
                                    GoRouter.of(context).go('/success'); // Redirigir al usuario a una página de éxito, por ejemplo
                                  }
                                  
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
