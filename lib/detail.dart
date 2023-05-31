import 'package:url_launcher/url_launcher.dart';

import 'api.dart';
import 'package:flutter/material.dart';

class detail extends StatefulWidget {
  final String id;
  const detail({Key? key, required this.id}) : super(key: key);

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  late List<dynamic> food=[];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    food = [];

    getDetail.fetchDetail(widget.id).then((data) {
      setState(() {
        food = data;
        isLoading = false; // Mengubah isLoading menjadi false setelah data selesai dimuat
      });
    }).catchError((error) {
      print(error);
      isLoading = false; // Mengubah isLoading menjadi false jika terjadi kesalahan
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could Not Launch $_url');
    }
  }
  @override
  Widget build(BuildContext context) {
    final data =food;
    return Scaffold(backgroundColor:  Color(0xFFBEF0CB),

body: isLoading? Center(
  child: CircularProgressIndicator(),
) : ListView(
  children: [
    Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child:   InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child:  Icon(Icons.arrow_back_outlined,
            size: 35,
            color: Colors.black,),
        ),
      ),
    ),

    SizedBox(height: 20,),
    CircleAvatar(
      radius: 100,
      backgroundColor: Colors.transparent,
      child:ClipOval(
        child: data.isNotEmpty
            ? Image.network(
          data[0]['strMealThumb'],
          fit: BoxFit.cover,
          width: 200,
          height: 200,
        )
            : Container(),
      ),

    ),
 SizedBox(height: 10,),
    Center(
      child: Text(
        data.isNotEmpty ? data[0]['strMeal'] : '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Poppins",
        ),
        textAlign: TextAlign.center,
      ),
    ),
 SizedBox(height: 20,),
 SizedBox(
   height: 500,
   child:
   ListView(
     children: [
       Expanded(child: Container(
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.only(
             topRight: Radius.circular(25),
             topLeft: Radius.circular(25),
           ),
         ),
         child: Column(
           children: [
             SizedBox(height: 20,),
             Align(
               alignment: Alignment.centerLeft,
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                 child: Text(
                   data.isNotEmpty ? 'Categories : ' + data[0]['strCategory'] : '',
                   style: TextStyle(
                     fontSize: 18,
                     fontFamily: "Poppins",
                   ),
                 ),
               ),
             ),
             Align(
               alignment: Alignment.centerLeft,
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                 child: Text(
                   data.isNotEmpty ? 'Area : ' + data[0]['strArea'] : '',
                   style: TextStyle(
                     fontSize: 18,
                     fontFamily: "Poppins",
                   ),
                 ),
               ),
             ),
             SizedBox(height: 10,),
             Center(child: Text("Instructions",
               style: TextStyle(
                 fontFamily: "Poppins",
                 fontSize: 25,

               ),),),
             Container(
               margin: EdgeInsets.only(top: 2),
               width: 350,
               child: Text(
                 data.isNotEmpty ? data[0]['strInstructions'] : '',
                 style: TextStyle(
                   fontFamily: "Poppins",
                 ),
                 textAlign: TextAlign.justify,
               ),
             ),
             SizedBox(height: 20,),
             Container(

               width: 200,
               child: ElevatedButton(
                   onPressed: () {
                     if (data.isNotEmpty) {
                       _launchUrl(data[0]['strYoutube']);
                     }
                   }
               , child: Text("Watch"),
               ),
             ),
             SizedBox(height: 50,)
           ],
         ),
       ),)

     ],
   ),

 )

  ],
)

    );
  }
}
