import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/artikel/form_Screen.dart';
import 'package:jelajah_nusantara/controllers/artikel_controller.dart';
import 'package:jelajah_nusantara/controllers/auth_controller.dart';
import 'package:jelajah_nusantara/models/artikel_model.dart';
import 'package:jelajah_nusantara/screens/widgets/grid_artikelScreen.dart';

class ArtikelScreen extends StatelessWidget {
  const ArtikelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 25,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder(
                          future: AuthController.getProfile(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Error : ${snapshot.error}");
                            } else {
                              final user = snapshot.data!;
                              return Column(
                                children: [
                                       Text(
                                          user.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18
                                          ),
                                        )
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications,
                      color: Color(0XFFD1A824),
                      size: 30,
                    ),
                  ],
                ),

                SizedBox(height: 20),

                TextField(
                  decoration: InputDecoration(
                    hintText: "Cari Tempat Wisata",
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Color(0XFFD1A824).withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) => print("Kata kunci: $value"),
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Text(
                      "List Artikel Kamu",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormScreen(isEdit: false),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Color(0XFFD1A824),
                        size: 20,
                      ),
                      label: Text(
                        "Buat Artikel",
                        style: TextStyle(
                          color: Color(0XFFD1A824),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                FutureBuilder(
                  future: ArtikelController.getMyArtikel(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text(
                        "Terjadi Kesalahan ${snapshot.error}",
                        style: TextStyle(color: Colors.red),
                      );
                    }

                    final artikelList = snapshot.data ?? [];
                    return GridArtikelscreen(artikelList: artikelList);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
