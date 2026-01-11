// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {
//   static const String baseUrl = 'http://192.168.8.5/myAuthApp/api';

//   Future<Map<String, dynamic>> register(String phone, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/register'),
//       body: {'phone': phone, 'password': password},
//     );
//     return json.decode(response.body);
//   }

//   Future<Map<String, dynamic>> login(String phone, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       body: {'phone': phone, 'password': password},
//     );
//     return json.decode(response.body);
//   }

//   Future<Map<String, dynamic>> loginWithOtp(String phone, String otp) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login-with-otp'),
//       body: {'phone': phone, 'otp': otp},
//     );
//     return json.decode(response.body);
//   }

//   Future<void> saveToken(String token, bool rememberMe) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('auth_token', token);
//     await prefs.setBool('remember_me', rememberMe);
//   }

//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('auth_token');
//   }

//   Future<bool> getRememberMe() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('remember_me') ?? false;
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('auth_token');
//     await prefs.remove('remember_me');
//   }

//   Future<bool> isTokenValid() async {
//     final token = await getToken();
//     if (token == null) return false;
//     final response = await http.get(
//       Uri.parse('$baseUrl/validate-token'),
//       headers: {'Authorization': 'Bearer $token'},
//     );
//     return response.statusCode == 200;
//   }

//   Future<Map<String, dynamic>> resetPassword(
//       String phone, String otp, String newPassword) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/reset-password'),
//       body: {'phone': phone, 'otp': otp, 'new_password': newPassword},
//     );
//     return json.decode(response.body);
//   }
// }
