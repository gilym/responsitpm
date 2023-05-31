import 'package:flutter/material.dart';
import 'package:responsitpm/detail.dart';
import 'api.dart';

class food extends StatefulWidget {
  final String categorie;
  const food({Key? key, required this.categorie}) : super(key: key);

  @override
  State<food> createState() => _foodState();
}

class _foodState extends State<food> {
  @override

  late List<dynamic> food=[];
  @override
  void initState() {
    super.initState();
    food = [];

    getFood.fetchFood(widget.categorie).then((data) {
      setState(() {
        food = data;
      });
    }).catchError((error) {
      print(error);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categorie,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFBEF0CB),
        iconTheme: IconThemeData(color: Colors.black), // Mengatur warna ikon menjadi hitam
      ),

      body: GridView.count(
        crossAxisCount: 2, // Menentukan jumlah kategori dalam satu baris
        mainAxisSpacing: 10, // Spasi antara kontainer secara vertikal
        crossAxisSpacing: 10, // Spasi antara kontainer secara horizontal
        shrinkWrap: true, // Untuk mencegah scrolling di dalam GridView
        childAspectRatio: 0.7, // Menentukan perbandingan lebar terhadap tinggi
        children: List.generate(food.length, (index) {
          return InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => detail(id: food[index]['idMeal'],)));
            },
            child: Card(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      child: ClipRRect(

                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          food[index]['strMealThumb'],
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),

                    Text(
                      food[index]['strMeal'],
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
