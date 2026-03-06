import 'package:flutter/material.dart';
import 'dart:io';

class ImageUpload extends StatefulWidget {
  final VoidCallback ontap;
  final String? imagePath;

  const ImageUpload({
    super.key,
    required this.ontap,
    this.imagePath,
    });

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        height: MediaQuery.of(context).size.width / 2,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          image: widget.imagePath != null ? DecorationImage(
            image: FileImage(File(widget.imagePath!)),
            fit: BoxFit.cover
            )
            :null
        ),
        child: widget.imagePath == null ? 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image,
            size: 70,
            color: Colors.black54,),
            SizedBox(height: 8),
            Text("Upload Gambar",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),),
          ],
        )
        :null
      ),
    );
  }
}