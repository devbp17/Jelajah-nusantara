import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/artikel/detail_screnn.dart';
import 'package:jelajah_nusantara/models/artikel_model.dart';

class ArtikelAll extends StatelessWidget {
  final List<Blog> artikelList;
  const ArtikelAll({
    super.key,
    required this.artikelList
    });

  @override
  Widget build(BuildContext context) {
    const baseUrl = 'https://api-pariwisata.rakryan.id';
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1
        ),
        itemCount: artikelList.length,
      itemBuilder: (context, index) {
        final artikel = artikelList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScrenn(detailArtikel: artikel)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage('$baseUrl/${artikel.image}'),
                      fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(artikel.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              ),
              Text(artikel.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12
              ),)
            ],
          ),
        );
      });
  }
}