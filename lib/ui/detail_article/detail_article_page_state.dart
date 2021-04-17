import 'package:blog/bloc/detail_article_bloc/detail_article_bloc.dart';
import 'package:blog/ui/detail_article/detail_article_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

abstract class DetailArticlePageState extends State<DetailArticlePage>{
  DetailArticleBloc detailArticleBloc;
  bool isError = false;
  double progress = 0;
  ScrollController scrollController;
  var top = 0.0;
  String title = "";
  String setEmbedHtml(String url) {
    return """<!DOCTYPE html>
          <html>
            <head>
            <style>
            a {
    color: inherit;
    text-decoration: none;
         }
        img{
          width:100%;
          height:30%;
        }   f
        iframe {
          width:100%;
          height:30%;
          top:0;
          left:0;
          position:absolute; 
         }
        </style>

        <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
          <meta http-equiv="X-UA-Compatible" content="ie=edge">
           </head>
          <body>                                    
        <div id='pageContent'>
         $url
        </div>
          </body>                                    
        </html>
  """;
  }

  bool get isAppBarExpanded {
    return scrollController.hasClients &&
        scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    scrollController = new ScrollController()
      ..addListener(() {
        if (isAppBarExpanded) {
          setState(() {
            title = "Beritaa";
          });
        } else {
          title = "";
        }
      });
    detailArticleBloc=BlocProvider.of<DetailArticleBloc>(context);
    detailArticleBloc.getDetail(widget.id);
    // TODO: implement initState
    super.initState();
  }

  void launchURL(String url,BuildContext context) async {
    try {
      await launch(
        url,
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,

        extraCustomTabs: <String>[
          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
          'org.mozilla.firefox',
          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
          'com.microsoft.emmx',
        ],
      ),
    );
    } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
    }
  }
}
