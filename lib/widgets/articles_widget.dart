import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:project_flutter_news_app/consts/vars.dart';
import 'package:project_flutter_news_app/inner_screen/blog_details.dart';
import 'package:project_flutter_news_app/inner_screen/news_details_webview.dart';
import 'package:project_flutter_news_app/services/utils.dart';
import 'package:project_flutter_news_app/widgets/vertical_spacing.dart';

class ArticlesWidget extends StatelessWidget {
  const ArticlesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScrrenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, NewsDetailsScreen.routeName);
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                          height: size.height * 0.12,
                          width: size.height * 0.12,
                          boxFit: BoxFit.fill,
                          errorWidget: Image.asset("assets/images/empty_image.png"),
                          imageUrl:
                              "https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1"
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'title ' * 100,
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(fontSize: 15),
                          ),
                          VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '???? Reading time',
                              style: GoogleFonts.montserrat(fontSize: 15),
                            ),
                          ),
                          FittedBox(
                            child: Row(
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
                                    icon: Icon(
                                      Icons.link,
                                      color: Colors.blue,
                                    )),
                                Text(
                                  '3-12-2022 ' * 2,
                                  maxLines: 1,
                                  style: GoogleFonts.montserrat(fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
