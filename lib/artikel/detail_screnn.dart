import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/models/artikel_model.dart';

class DetailScrenn extends StatelessWidget {
  final Blog detailArtikel;
  const DetailScrenn({super.key, required this.detailArtikel});

  @override
  Widget build(BuildContext context) {
    const baseUrl = 'https://api-pariwisata.rakryan.id';
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: Image.network(
                        "$baseUrl/${detailArtikel.image}",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Positioned(
                          left: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0XFFD1A824),
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      detailArtikel.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Lihat Di Maps',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0XFFD1A824),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0XFFD1A824), size: 19),
                    SizedBox(width: 5),
                    Text('4.5 (355 Reviews)', style: TextStyle(fontSize: 11)),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  detailArtikel.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
