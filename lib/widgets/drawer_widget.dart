import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_flutter_news_app/inner_screen/bookmarks_screen.dart';
import 'package:project_flutter_news_app/widgets/vertical_spacing.dart';

import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider.getDarkTheme? Colors.white:Colors.black;
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Image.asset(
                    'assets/images/newspaper.png',
                    height: 60,
                    width: 60,
                  )),
                  const VerticalSpacing(20),
                  Flexible(
                    child: Text(
                      'News app',
                      style: GoogleFonts.lobster(
                          textStyle:
                              TextStyle(fontSize: 20, letterSpacing: 0.6)),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalSpacing(20),
            ListTilesWidget(
              icon: IconlyBold.home,
              label: 'Home',
              fct: () {},
            ),
            ListTilesWidget(
              icon: IconlyBold.bookmark,
              label: 'Bookmark',
              fct: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: BookmarkScreen(),
                      inheritTheme: true,
                      ctx: context),
                );
              },
            ),
            Divider(
              thickness: 5,
            ),
            SwitchListTile(
                title: Text(
                  style: TextStyle(fontSize: 20),
                  themeProvider.getDarkTheme ? 'Dark' : 'Light',
                ),
                secondary: Icon(
                  themeProvider.getDarkTheme
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                value: themeProvider.getDarkTheme,
                onChanged: (bool value) {
                  setState(() {
                    themeProvider.setDarkTheme = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}

class ListTilesWidget extends StatelessWidget {
  const ListTilesWidget(
      {Key? key, required this.label, required this.fct, required this.icon})
      : super(key: key);
  final String label;
  final Function fct;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        fct();
      },
    );
  }
}
