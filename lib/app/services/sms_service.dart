import 'dart:convert';
import 'package:garuda/.env.dart';
import 'package:http/http.dart' as http;

class SmsService {
  static Future<void> sendSMS(String phone, String name, String amount) async {
    final message = "🙏 గౌరవనీయమైన $name గారికి, "
        "మీరు విరాళంగా ఇచ్చిన ₹$amount కు మనస్పూర్తిగా ధన్యవాదాలు. "
        "మీ సహాయం మా వినాయక చవితి కార్యక్రమాన్ని విజయవంతంగా నిర్వహించేందుకు ఎంతో సహాయపడుతోంది. "
        "- గరుడ యూత్ అసోసియేషన్ 🙏";
        
    final response = await http.post(
      Uri.parse("https://www.fast2sms.com/dev/bulkV2"),
      headers: {
        "authorization": fast2smsApiKey,
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "route": "v3",
        "sender_id": "TXTIND",
        "message": message,
        "language": "english",
        "flash": 0,
        "numbers": phone
      }),
    );

    if (response.statusCode == 200) {
      print("✅ SMS Sent Successfully");
    } else {
      print("❌ SMS Failed: ${response.body}");
    }
  }
}
