import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myshop/models/http_exeception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAhabkHQjfQVL_--A_Ow2IbizWFrzSc3P0';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
    // const url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:?key=AIzaSyAhabkHQjfQVL_--A_Ow2IbizWFrzSc3P0';
    // final response = await http.post(
    //   url,
    //   body: json.encode({
    //     'email': email,
    //     'password': password,
    //     'returnSecureToken': true,
    //   }),
    // );
    // print(json.decode(response.body));
  }
}
