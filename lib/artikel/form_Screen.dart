import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jelajah_nusantara/controllers/artikel_controller.dart';
import 'package:jelajah_nusantara/screens/widgets/image_input.dart';
import 'package:file_picker/file_picker.dart';

class FormScreen extends StatefulWidget {
  final bool isEdit;
  final String? artikelid;
  const FormScreen({super.key, required this.isEdit, this.artikelid});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? imagePath;
  Future<void> _pickimage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        imagePath = result.files.single.path;
      });
    }
  }

  Future<void> _create(String title, String description) async {
    if (imagePath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Pilih Gambar Terlebih Dahulu")));
      return;
    }
    final imageFile = File(imagePath!);

    final message = await ArtikelController.createArtikel(
      imageFile,
      title,
      description,
      context,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _update(String title, String description) async {
    File? imageFile;
    if (imagePath != null) {
      imageFile = File(imagePath!);
    }

    final message = await ArtikelController.updateArtikel(
      id: widget.artikelid!,
      title: title.isNotEmpty ? title : null,
      description: description.isNotEmpty ? description : null,
      image: imageFile,
      context: context,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEdit ? "Edit Artikel" : "Tambah Artikel",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          backgroundColor: Color(0XFFD1A824),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageUpload(ontap: _pickimage, imagePath: imagePath),
                SizedBox(height: 20),
                Text(
                  'Judul Artikel',
                  style: TextStyle(
                    color: Color(0XFF404637),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: judulController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Lokasi',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: Color(0XFFD9D9D9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.all(12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0XFFD9D9D9),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0XFFD9D9D9),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  minLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Deskripsi Lokasi',
                    hintStyle: TextStyle(
                      color: Color(0XFFD9D9D9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0XFFD9D9D9),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0XFFD9D9D9),
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              final title = judulController.text;
              final description = descriptionController.text;

              if (widget.isEdit == false) {
                _create(title, description);
              } else if (widget.isEdit && widget.artikelid != null) {
                _update(title, description);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0XFFD1A824),
              minimumSize: Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              widget.isEdit ? "Edit" : "Tambah",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
