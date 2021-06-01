import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:todoapp/models/classes/user.dart';

class ApiProvider {
  Client client = Client();
  final _apiKey = 'api key here';

  Future signinUser(String username, String password) async {
    final response = await client.post("http://localhost:5000/api/signin",// Replaced ip address with localhost id
        body: jsonEncode({
          "username": username,
          "password": password,
        }));
    final Map result = json.decode(response.body);

    if (response.statusCode == 201) {
      await saveApiKey(result["data"]["api_key"]);
      return User.fromJson(result["data"]);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<User> registerUser(String username, String firstname, String lastname,
      String password, String email) async {
    final response = await client.post("http://localhost:5000/api/register", // Replaced ip address with localhost id
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
          "firstname": firstname,
          "lastname": lastname
        }));
    final Map result = json.decode(response.body);

    if (response.statusCode == 201) {
      await saveApiKey(result["data"]["api_key"]);
      return User.fromJson(result["data"]);
    } else {
      throw Exception('Failed to load post');
    }
  }

  saveApiKey(String api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('API_Token', api_key);
  }
}
