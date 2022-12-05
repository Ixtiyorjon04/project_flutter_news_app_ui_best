import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../services/utils.dart';
import '../widgets/articles_widget.dart';
import '../widgets/empty_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    Size size = Utils(context).getScrrenSize;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: color),
        title: Text(
          'Bookmarks',
          style: GoogleFonts.lobster(
              textStyle:
              TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
        ),
        centerTitle: true,
      ),
      body:  EmptyNewsWidget(
          text: 'You didn\'t add anything yet to your bookmarks',
          imagepath: 'assets/images/search.png')

    );
  }
}
