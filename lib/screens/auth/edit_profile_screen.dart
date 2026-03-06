import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: Color(0XFFD1A824),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/avatar.png"),
              radius: 50,
              child: Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.camera_alt_rounded),
                  onPressed: Future<void> _imagepicker() async {
                    String imagePath;
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {

                      })
                    }
                  }
                ),
              )
            ),
          ),
          SizedBox(height: 10),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Masukkan Nama Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
