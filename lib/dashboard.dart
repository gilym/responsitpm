import 'package:responsitpm/food.dart';

import 'api.dart';
import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  late List<dynamic> categories=[];
  @override
  void initState() {
    super.initState();
    categories = [];
    getCategories.fetchcategories().then((data) {
      setState(() {
        categories = data;
      });
    }).catchError((error) {
      print(error);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori",style: TextStyle(color: Colors.black),),
          backgroundColor:  Color(0xFFBEF0CB),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2, // Menentukan jumlah kategori dalam satu baris
        mainAxisSpacing: 10, // Spasi antara kontainer secara vertikal
        crossAxisSpacing: 10, // Spasi antara kontainer secara horizontal
        shrinkWrap: true, // Untuk mencegah scrolling di dalam GridView
        childAspectRatio: 1.2, // Menentukan perbandingan lebar terhadap tinggi
        children: List.generate(categories.length, (index) {
          return InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => food(categorie: categories[index]['strCategory'],)));
            },
            child: Card(



              margin: EdgeInsets.symmetric(vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: ClipRRect(

                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                       categories[index]['strCategoryThumb'],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  Text(
                    categories[index]['strCategory'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,

                    ),
                  ),
                ],
              )
            ),
          );
        }),
      ),
    );
  }
}
