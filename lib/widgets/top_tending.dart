import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:project_flutter_news_app/consts/vars.dart';
import 'package:project_flutter_news_app/inner_screen/blog_details.dart';
import 'package:project_flutter_news_app/inner_screen/news_details_webview.dart';
import 'package:project_flutter_news_app/services/utils.dart';
import 'package:project_flutter_news_app/widgets/vertical_spacing.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScrrenSize;
    final Color color = Utils(context).getColor;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child:  Material(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12.0),

       child:  InkWell(
          onTap: () {
            Navigator.pushNamed(context, NewsDetailsScreen.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                    height: size.height * 0.33,
                    width: double.infinity,
                    boxFit: BoxFit.fill,
                    errorWidget: Image.asset('assets/image/empty_image.png'),
                    imageUrl:
                        "https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1"),

              ),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Title '  ,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: NewsDetailsWebView(),
                              inheritTheme: true,
                              ctx: context),
                        );
                      },
                      icon: const Icon(
                        Icons.link,
                        color: Colors.blue,
                      )),
                  const Spacer(),

                  SelectableText(
                    '3-12-2022 ' ,

                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                ],
              )
            ],
          ),
      ),
      ),
    );
  }
}
