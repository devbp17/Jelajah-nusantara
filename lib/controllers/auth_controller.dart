import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/artikel/bottom_navbar.dart';
import 'package:jelajah_nusantara/models/user_model.dart';
import 'package:jelajah_nusantara/screens/auth/Login_Screen.dart';
import 'package:jelajah_nusantara/screens/home/home.dart';
import 'package:jelajah_nusantara/service/auth_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static Future<String> register(
    BuildContext context,
    String name,
    String username,
    String password,
  ) async {
    final result = await AuthService.register(name, username, password);
    final responseData = jsonDecode(result.body);

    if (result.statusCode == 200) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      return responseData['message'] ?? "regitrasi berhasil";
    } else {
      if (result.statusCode == 400) {
        final firsterror = responseData['errors'][0];
        return (firsterror['message'] ?? "Terjadi Kesalahan");
      } else {
        return (responseData['message'] ?? "Terjadi Kesalahan");
      }
    }
  }

  static Future<String> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    final result = await AuthService.login(username, password);
    final responseData = jsonDecode(result.body);

    if (result.statusCode == 200) {
      final token = responseData['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavbar()));
      return responseData['message'] ?? "Login Berhasil";
    } else {
      if (result.statusCode == 400) {
        final firstError = responseData['errors'][0];
        return (firstError['message'] ?? "Terjadi Kesalahan");
      }
      return (responseData['message'] ?? "Login Gagal");
    }
  }

  static Future<UserModel> getProfile()async{
    final result = await AuthService.getProfile();
    final responseData = jsonDecode(result.body);

    if (result.statusCode == 200){
      final data = responseData['data'];
      return UserModel.fromJson(data);
    } else {
      throw (responseData['message'] ?? "Gagal Memuat User");
    }
  } 

  static Future<String> logout(BuildContext context) async {
    final result = await AuthService.logout();
    
    final responseData = jsonDecode(result.body);

    if (result.statusCode == 200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      return responseData['message'] ?? "Logout berhasil";
    } else {
      return (responseData['message'] ?? "Terjadi Kesalahan");
    }
  }
}