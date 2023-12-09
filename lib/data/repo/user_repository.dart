import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locator_mobile/data/model/user.dart';

class UserRepository {
  Future<List<User>> fetchUserData() async {
    const apiUrl =
        'https://656f9f596529ec1c62381499.mockapi.io/api/location/users';
    // https://656f9f596529ec1c62381499.mockapi.io/api/location/:endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        if (jsonData is List) {
          final users = jsonData
              .map((data) => User.fromJson(data as Map<String, dynamic>))
              .toList();
          return users;
        } else {
          throw Exception('Failed to load user data');
        }
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Failed to load user data');
    }
  }
}
