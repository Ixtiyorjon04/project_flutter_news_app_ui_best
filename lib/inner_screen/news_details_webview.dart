import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:project_flutter_news_app/services/global_methods.dart';

import 'package:project_flutter_news_app/widgets/vertical_spacing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/utils.dart';

class NewsDetailsWebView extends StatefulWidget {
  const NewsDetailsWebView({Key? key}) : super(key: key);

  @override
  State<NewsDetailsWebView> createState() => _NewsDetailsWuebViewState();
}

class _NewsDetailsWuebViewState extends State<NewsDetailsWebView> {
  late WebViewController _webViewController;
  double _progress = 0.0;
  final url =   "https://techcrunch.com/2022/06/17/marc-lores-food-delivery-startup-wonder-raises-350m-3-5b-valuation";

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconlyLight.arrowLeft2)),
          iconTheme: IconThemeData(color: color),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Url',
            style: TextStyle(color: color),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await _showModalSheetFct();
                },
                icon: Icon(Icons.more_horiz))
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress == 1.0 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebView(
                initialUrl:
                  url,
                zoomEnabled: true,
                onProgress: (progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
Future <void> errorDialog(String  errorMessage)async{
    await showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text(errorMessage),
        title: Row(
          children: [
        Icon(IconlyBold.danger,color: Colors.red,),
        SizedBox(width: 8,),
            Text('An error occured')
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
          }, child: Text('Ok')
          )
        ],
      );
    });
}
  Future<void> _showModalSheetFct() async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const VerticalSpacing(20),
              Center(
                  child: Container(
                      height: 5,
                      width: 35,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30))))),
              const VerticalSpacing(20),
              Text(
                "More Option",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const VerticalSpacing(20),
              Divider(
                thickness: 2,
              ),
              const VerticalSpacing(20),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () async{

                try{
                  await Share.share('url', subject: 'Look what I made!');
                } catch(err) {
                  GlobalMethods().errorDialog(err.toString(), context);
                }

                },
              ),
              ListTile(
                leading: Icon(Icons.open_in_browser),
                title: Text('Open in browser'),
                onTap: () async{
                    if (!await launchUrl(Uri.parse(url))) {
                      throw 'Could not launch $url';

                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.refresh),
                title: Text('Refresh'),
                onTap: () async {
                  try{
                    await _webViewController.reload();
                  }catch(err){
                  }finally{
                    Navigator.pop(context);
                  }


                },
              ),
            ]),
          );
        });
  }
}
