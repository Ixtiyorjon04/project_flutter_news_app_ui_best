import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_flutter_news_app/inner_screen/search_screen.dart';
import 'package:project_flutter_news_app/services/utils.dart';
import 'package:project_flutter_news_app/widgets/articles_widget.dart';
import 'package:project_flutter_news_app/widgets/drawer_widget.dart';
import 'package:project_flutter_news_app/widgets/tabs.dart';
import 'package:project_flutter_news_app/consts/vars.dart';
import 'package:project_flutter_news_app/widgets/top_tending.dart';
import 'package:project_flutter_news_app/widgets/vertical_spacing.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScrrenSize;
    final Color color = Utils(context).getColor;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: color),
          title: Text(
            'News app',
            style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: SearchScreen(),
                    inheritTheme: true,
                    ctx: context),
              );

            }, icon: Icon(IconlyLight.search))
          ],
        ),
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TabsWidget(
                      text: 'All news',
                      color: newsType == NewsType.allNews
                          ? Theme.of(context).cardColor
                          : Colors.transparent,
                      function: () {
                        if (newsType == NewsType.allNews) {
                          return;
                        }
                        setState(() {
                          newsType = NewsType.allNews;
                        });
                      },
                      fontSize: newsType == NewsType.allNews ? 22 : 14),
                  SizedBox(
                    width: 25,
                  ),
                  TabsWidget(
                      text: 'Top Trending',
                      color: newsType == NewsType.topTrending
                          ? Theme.of(context).cardColor
                          : Colors.transparent,
                      function: () {
                        if (newsType == NewsType.topTrending) {
                          return TopTrendingWidget();
                        }
                        setState(() {
                          newsType = NewsType.topTrending;
                        });
                      },
                      fontSize: newsType == NewsType.topTrending ? 22 : 14)
                ],
              ),
            ),
            VerticalSpacing(10),
            newsType == NewsType.topTrending
                ? Container()
                : SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          paginationButtons(() {
                            setState(() {
                              if (currentPageIndex == 0) {
                                return;
                              }
                              currentPageIndex -= 1;
                            });
                          }, 'Prev'),
                          Flexible(
                            flex: 2,
                            child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentPageIndex = index;
                                        });
                                      },
                                      child: Material(
                                        color: currentPageIndex == index
                                            ? Colors.blue
                                            : Theme.of(context).cardColor,
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${index + 1}"),
                                        )),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          paginationButtons(() {
                            setState(() {
                              if (currentPageIndex == 4) {
                                return;
                              }
                              currentPageIndex += 1;
                            });
                          }, 'Next'),
                        ],
                      ),
                    ),
                  ),
            VerticalSpacing(10),
            newsType == NewsType.topTrending
                ? Container()
                : Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButton(
                            value: sortBy,
                            items: dropDownItems,
                            onChanged: (String? value) {}),
                      ),
                    )),
            if (newsType == NewsType.allNews)
              Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (ctx, index) {
                      return const ArticlesWidget();
                    }),
              ),
            if (newsType == NewsType.topTrending)
              SizedBox(
                height: size.height * 0.8,
                child: Swiper(
                  autoplayDelay: 8000,
                  autoplay: true,
                  itemWidth: size.width * 0.9,
                  layout: SwiperLayout.STACK,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return TopTrendingWidget();
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text(SortByEnum.relevancy.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text(SortByEnum.publishedAt.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(SortByEnum.popularity.name),
      ),
    ];

    return menuItem;
  }

  Widget paginationButtons(Function function, String text) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: EdgeInsets.all(6),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
