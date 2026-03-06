import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/artikel/bottom_navbar.dart';
import 'package:jelajah_nusantara/models/artikel_model.dart';
import 'package:jelajah_nusantara/service/artikel_service.dart';
import 'package:http/http.dart' as http;

class ArtikelController {
  static Future <List<Blog>> getArtikel(int page, int limit) async {
    final result = await ArtikelService.getArtikel(page, limit);

    if (result.statusCode == 200) {
      final data = jsonDecode(result.body)['data'] as List<dynamic>?;
      return data?.map((item) => Blog.fromJson(item)).toList() ?? [];
    } else {
      throw Exception('Gagal Memuat data artikel');
    }
  }

  static Future<List<Blog>> getMyArtikel() async {
    final result = await ArtikelService.getMyArtikel();
    if (result.statusCode == 200) {
      final data = jsonDecode(result.body)['data'] as List<dynamic>?;
      return data?.map((item) => Blog.fromJson(item)).toList() ?? [];
    } else if (result.statusCode == 404){
      throw('Kamu Belum Mempunyai Artikel');
    } else {
      throw ('Gagal Memuat Data');
    }
  }

  static Future<String> createArtikel(
    File image,
    String title,
    String description,
    BuildContext context,
  ) async {
    final result = await ArtikelService.createArtikel(
      image,
      title,
      description
    );

    final response = await http.Response.fromStream(result);
    final objectResponse = jsonDecode(response.body);
    if (response.statusCode == 201){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavbar()));
      return objectResponse['message'] ?? 'Tambah Data Berhasil';
    } else if (response.statusCode == 400){
      final firstError = objectResponse['errors'][0];
      return (firstError['message'] ?? "Terjadi Kesalahan");
    } else {
      return (objectResponse['message'] ?? "Terjadi Kesalahan");
    }
  }

  static Future<String> updateArtikel({
    required String id,
    File? image,
    String? title,
    String? description,
    required BuildContext context,
  }) async {
    final result = await ArtikelService.updateArtikel(
      id : id,
      image : image,
      title : title,
      description : description
    );

    final response = await http.Response.fromStream(result);
    final objectResponse = jsonDecode(response.body);

    if (response.statusCode == 200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavbar()));
      return objectResponse['message'] ?? 'Update Data Berhasil';
    } else if (response.statusCode == 400){
      final firstError = objectResponse['errors'][0];
      return firstError?['message'] ?? "Terjadi Kesalahan";
    } else {
      return objectResponse['message'] ?? "Terjadi Kesalahan";
    }
  }

  static Future<String> deleteArtikel(
    String id,
    BuildContext context
  ) async {
    final result = await ArtikelService.deleteArtikel(id);
    final responseData = jsonDecode(result.body);

    if (result.statusCode == 200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavbar()));
      return responseData['message'] ?? 'Delete Data Berhasil';
    } else {
      return (responseData['message'] ?? "Terjadi Kesalahan");
    }
  }
}