import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/controllers/artikel_controller.dart';
import 'package:jelajah_nusantara/controllers/auth_controller.dart';
import 'package:jelajah_nusantara/models/artikel_model.dart';
import 'package:jelajah_nusantara/screens/widgets/grid_ArtikelPop.dart';
import 'package:jelajah_nusantara/screens/widgets/grid_artikel_all.dart';
import 'package:jelajah_nusantara/service/artikel_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Blog> artikelAll = [];
  int page = 1;
  int limit = 1;
  bool isloading = false;
  bool hasmore = true;
  late Future<List<Blog>> _futureArtikelPopuler;
  bool loadingProfile = true;
  String username = "";
  File? imagePath;

  Future<void> loadArtikel() async {
    if (isloading || !hasmore) return;
    setState(() => isloading = true);
    try {
      final getArtikel = await ArtikelService.getArtikel(page, limit);
      final totalData = jsonDecode(getArtikel.body)["totalData"];
      final data = await ArtikelController.getArtikel(page, limit);

      setState(() {
        artikelAll.addAll(data);
        if (artikelAll.length >= totalData) {
          hasmore = false;
        } else {
          page++;
        }
      });
    } catch (e) {
      debugPrint("Gagal Memuat Data");
    } finally {
      setState(() => isloading = false);
    }
  }

  Future<void> loadLocalProfile() async {
    final prefs = await SharedPreferences.getInstance();

    username = prefs.getString("username") ?? "User";

    String? imgPath = prefs.getString("profile_image");
    if (imgPath != null && File(imgPath).existsSync()) {
      imagePath = File(imgPath);
    }

    setState(() => loadingProfile = false);
  }

  @override
  void initState() {
    super.initState();
    loadArtikel();
    _futureArtikelPopuler = ArtikelController.getArtikel(1, 4);
    loadLocalProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //avatar icon
                Row(
                  children: [
                    loadingProfile
                        ? CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/images/avatar.png",
                            ),
                            radius: 25,
                          )
                        : CircleAvatar(
                            backgroundImage: imagePath != null
                                ? FileImage(imagePath!)
                                : const AssetImage("assets/images/avatar.png")
                                      as ImageProvider,
                            radius: 25,
                          ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                //end Avatar Icon
                SizedBox(height: 20),
                //SearchFIeld
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
                  onChanged: (value) {
                    print("Kata kunci: $value");
                  },
                ),
                //end SearchField
                //Artikel populer
                SizedBox(height: 20),
                Text(
                  "Populer",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                FutureBuilder(
                  future: _futureArtikelPopuler,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final artikelList = snapshot.data ?? [];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ArtikelPopuler(artikelList: artikelList),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Color(0XFFD1A824),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/newspaper.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Lihar Artikel Kamu',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Yuk Mulai Artikel Kamu Sendiri',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: Color(0XFFD1A824),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    }
                  },
                ),
                //end artikel populer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Artikel Lainnya',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(fontSize: 12, color: Color(0XFFD1A824)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ArtikelAll(artikelList: artikelAll),
                SizedBox(height: 20),
                if (hasmore)
                  Center(
                    child: ElevatedButton(
                      onPressed: isloading ? null : loadArtikel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFFD1A824),
                      ),
                      child: isloading
                          ? Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text('Load More'),
                    ),
                  )
                else
                  Center(child: Text("Semua Artikel Sudah Dimuat")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
