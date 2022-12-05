import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter_news_app/widgets/vertical_spacing.dart';

import '../services/utils.dart';

class NewsDetailsScreen extends StatefulWidget {
  static const routeName = '/NewsDetailsScreen';

  const NewsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScrrenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "My Auyhor",
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(IconlyLight.arrowLeft),
        //   color: color,
        // ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title" * 10,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                VerticalSpacing(25),
                Row(
                  children: [
                    Text(
                      '20/12.2025',
                      style: GoogleFonts.montserrat(fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      'readingTimeText',
                      style: GoogleFonts.montserrat(fontSize: 15),
                    )
                  ],
                ),
                VerticalSpacing(25),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: FancyShimmerImage(
                      boxFit: BoxFit.fill,
                      errorWidget: Image.asset("assets/images/empty_image.png"),
                      imageUrl:
                      "https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1"
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child:  Card(
                          elevation: 10,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(IconlyLight.send,size: 28,color: color,),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){},
                        child:  Card(
                          elevation: 10,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(IconlyLight.bookmark,size: 28,color: color,),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8.0, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const TextContent(
                  label: "Desctiption ",
                  fontSize:  20,
                  fontWeight: FontWeight.bold,
                ),
                const VerticalSpacing(10),
                 TextContent(
                  label: "desctiption "*12,
                  fontSize:  18,
                  fontWeight: FontWeight.normal,
                ),
                const VerticalSpacing(20),
                TextContent(
                  label: "Contents ",
                  fontSize:  20,
                  fontWeight: FontWeight.bold,
                ),
                const VerticalSpacing(10),
                TextContent(
                  label: "contents "*12,
                  fontSize:  18,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    Key? key,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
