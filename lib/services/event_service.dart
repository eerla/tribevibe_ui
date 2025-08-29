import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';
import '../constants.dart';

class EventService {
  static const String baseUrl = AppConstants.baseUrl;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Event> createEvent(Event event) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/events/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(event.toJson()),
    );
    if (response.statusCode == 201) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create event');
    }
  }

  Future<List<Event>> getEvents() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/events/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Event.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<Event> getEventById(int id) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/events/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load event');
    }
  }
}
