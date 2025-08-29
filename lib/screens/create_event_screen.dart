import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_service.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { isLoading = true; error = null; });
    try {
      final event = Event(
        title: _titleController.text,
        description: _descController.text,
        date: _dateController.text,
        time: _timeController.text,
        location: _locationController.text,
      );
      await EventService().createEvent(event);
      Navigator.pop(context, true);
    } catch (e) {
      setState(() { error = 'Failed to create event'; });
    } finally {
      setState(() { isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Create Event', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    label: 'Title',
                    controller: _titleController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Description',
                    controller: _descController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Date (YYYY-MM-DD)',
                    controller: _dateController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Time (HH:MM)',
                    controller: _timeController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Location',
                    controller: _locationController,
                  ),
                  const SizedBox(height: 24),
                  if (error != null)
                    Text(
                      error!,
                      style: const TextStyle(color: Color(0xFFC9ADA7), fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  if (error != null) const SizedBox(height: 12),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'Create Event',
                          onPressed: _submit,
                          color: AppColors.button,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
