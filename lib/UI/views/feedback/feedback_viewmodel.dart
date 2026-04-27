import 'dart:convert';

import 'package:englify_app/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class FeedbackViewmodel extends BaseViewModel {
    final _navigationService = locator<NavigationService>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

   int selectedRating = 0;
  bool isSubmitted = false;

  // ── EmailJS credentials
  static const _serviceId = 'service_y2dslea';
  static const _templateId = 'template_gs9ogyb';
  static const _publicKey = 'lhC0Nw746qvKyDnZP';

  void setRating(int rating) {
    selectedRating = rating;
    notifyListeners();
  }

  Future<void> submitFeedback() async {
    if (nameController.text.trim().isEmpty ||
        messageController.text.trim().isEmpty ||
        selectedRating == 0) {
      return;
    }

    setBusy(true);
    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost',
        },
        body: jsonEncode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': {
            'from_name': nameController.text.trim(),
            'user_email': emailController.text.trim().isEmpty
                ? 'Not provided'
                : emailController.text.trim(),
            'rating': '$selectedRating / 5',
            'message': messageController.text.trim(),
          },
        }),
      );

      if (response.statusCode == 200) {
        isSubmitted = true;
        notifyListeners();
        await Future.delayed(const Duration(seconds: 2));
        _navigationService.back();
      } else {
        print('EmailJS error: ${response.body}');
      }
    } catch (e) {
      print('Failed to send feedback: $e');
    }
    setBusy(false);
  }

  void onBack() => _navigationService.back();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}