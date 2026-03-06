import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/artikel/detail_screnn.dart';
import 'package:jelajah_nusantara/artikel/form_Screen.dart';
import 'package:jelajah_nusantara/controllers/artikel_controller.dart';
import 'package:jelajah_nusantara/models/artikel_model.dart';

class GridArtikelscreen extends StatelessWidget {
  final List<Blog> artikelList;
  const GridArtikelscreen({super.key, required this.artikelList});

  @override
  Widget build(BuildContext context) {
    const baseUrl = 'https://api-pariwisata.rakryan.id';
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 20,
        childAspectRatio: 1.3,
      ),
      itemCount: artikelList.length,
      itemBuilder: (context, index) {
        final artikel = artikelList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScrenn(detailArtikel: artikel),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    child: Image.network(
                      '$baseUrl/${artikel.image}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${artikel.title}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FormScreen(isEdit: true, artikelid: artikel.id),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    iconSize: 17,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () async {
                      final message = await ArtikelController.deleteArtikel(
                        artikel.id,
                        context
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                    },
                    icon: Icon(Icons.delete_rounded),
                    color: Colors.red,
                    iconSize: 17,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                artikel.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
