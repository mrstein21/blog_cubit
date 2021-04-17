import 'package:blog/bloc/home_bloc/home_bloc.dart';
import 'package:blog/bloc/home_bloc/home_state.dart';
import 'package:blog/model/article.dart';
import 'package:blog/model/video.dart';
import 'package:blog/routes.dart';
import 'package:blog/ui/home/home_page_state.dart';
import 'package:blog/ui/home/widgets/article_section.dart';
import 'package:blog/ui/home/widgets/home_loading_section.dart';
import 'package:blog/ui/home/widgets/video_section.dart';
import 'package:blog/ui/search/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HomePageState {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          automaticallyImplyLeading: false,
        title: Image.asset(
          "assets/logo.png",
          height: 60,
        ),
        actions: <Widget>[
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouterGenerator.routeSearch);
              },
              child: Icon(Icons.search)),
          SizedBox(width: 5),
          InkWell(
            child: Icon(Icons.bookmark),
          ),
          SizedBox(width: 3),
        ],
      ),
      body:BlocConsumer<HomeBloc,HomeState>(
        listener: (context,state){
          if(state is HomeFailedState){
            scaffoldState.currentState.showSnackBar(SnackBar(content: Text("Terjadi kesalahan pada server ")));
          }
        },
        builder: (context,state){
          if(state is HomeLoadedState){
            return _buildLoaded(state.video, state.article);
          }else{
            return HomeLoadingSection();
          }
        },

      )
    );
  }

  Widget _buildLoaded(List<Video>video,List<Article>article){
   return  Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Video",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 18),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouterGenerator.routeListVideo);
                },
                child: Text(
                  "More",
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          VideoSection(
            video: video,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Latest Article",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 18),
              ),
              InkWell(
                onTap: () {
                    Navigator.pushNamed(context, RouterGenerator.routeListArticle);
                },
                child: Text(
                  "More",
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          ArticleSection(
            list: article,
          ),
        ],
      ),
    );
  }


}
