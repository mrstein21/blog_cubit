import 'package:blog/ui/search_by_tags/search_by_tags_page_state.dart';
import 'package:blog/ui/search_by_tags/widgets/article_section.dart';
import 'package:blog/ui/search_by_tags/widgets/video_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchByTagsPage extends StatefulWidget {
  String tags;
  String tags_name;
  SearchByTagsPage({
    this.tags,
    this.tags_name
   });
  @override
  _SearchByTagsPageState createState() => _SearchByTagsPageState();
}

class _SearchByTagsPageState extends SearchByTagsPageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: Text("Topic : '"+widget.tags_name+"'",style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.bold),)
      ),
      body: Container(
        color: Colors.white,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Material(
                color: Colors.white,
                elevation: 2,
                child: TabBar(
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(child: Text("Articles",style: TextStyle(color: Colors.black,fontFamily: "Roboto",fontWeight: FontWeight.bold),),),
                      Tab(child: Text("Videos",style: TextStyle(color: Colors.black,fontFamily: "Roboto",fontWeight: FontWeight.bold),),)
                    ]
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ArticleSection(keyword: widget.tags,),
                    VideoSection(keyword: widget.tags,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }






}
