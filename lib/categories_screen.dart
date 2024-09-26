import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newspaper_api/home_screen.dart';
import 'package:newspaper_api/model/catagory_channel.dart';
import 'package:newspaper_api/news_model/news_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}


class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat('MMMM dd, yyyy');

  String categoriesName = 'general';
 List<String>categoriesList=[
   'General',
   'Entertainment ',
   'Health',
   'Sports',
   'Business'
   'Techonology',
 ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body:
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    itemBuilder:(context,index){
                  return InkWell(
                    onTap: (){
                      categoriesName =categoriesList[index];
                      setState(() {
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoriesName==categoriesList[index]? Colors.blue:Colors.grey,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:5),
                          child: Center(child: Text(categoriesList[index].toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                            ),)),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: FutureBuilder<CategoryNewsModel>(
                  future: newsViewModel.fetchCategoriesNewsApi(categoriesName),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.articles!.isEmpty) {
                      return Center(
                        child: Text(
                          'No data available',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(
                              snapshot.data!.articles![index].publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                               children: [
                                 ClipRRect(
                                   borderRadius: BorderRadius.circular(15),
                                   child: CachedNetworkImage(
                                     imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                     fit: BoxFit.cover,
                                     height: height*.18,
                                     width: width*.3,
                                     placeholder: (context, url) =>
                                         Container(
                                             child: Center(
                                               child: SpinKitCircle(
                                                 size: 50,
                                                 color: Colors.blue,
                                               ),
                                             ),
                                         ),
                                     errorWidget: (context, url, error) =>
                                         Icon(Icons.error_outline, color: Colors.red),
                                   ),
                                 ),
                                 Expanded(
                                     child: Container(
                                   height: height*.15,
                                   padding: EdgeInsets.only(left: 5,),
                                   child: Column(
                                     children: [
                                       Text(snapshot.data!.articles![index].title.toString(),
                                         maxLines: 4,
                                         style: GoogleFonts.poppins(
                                           fontSize: 10,
                                           color: Colors.black54,
                                           fontWeight: FontWeight.w700,
                                         ),
                                 ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Text(snapshot.data!.articles![index].source!.name.toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text( format.format(dateTime),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      )
                                     ],
                                   ),
                                 ))
                               ],
                            ),
                          ) ;
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
       ),


    );
  }
}
