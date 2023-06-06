import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mybench/constants.dart';

Future sendEmail({
  required String email,
  required String replayTo,
  required String password,
}) async {
  final serviceId = 'service_0xievll';
  final templateId = 'template_zj849yc';
  final userId = 'rC50PyHR_p1lTs2GV';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json', 'origin': kip},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'reciver_email': email,
          'reply_to': replayTo,
          'message1':
              'Vote employeur vous a donner access à l\'application MyBench\n voici vos coordonnées:',
          //Email: $email\n Mot de passe: $password',
          'message2': 'Email: $email',
          'message3': 'Mot de passe: $password',
        }
      }));
}
