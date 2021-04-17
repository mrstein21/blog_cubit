import 'package:blog/ui/search_result/search_result_page_state.dart';
import 'package:blog/ui/search_result/widgets/article_section.dart';
import 'package:blog/ui/search_result/widgets/video_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  String keyword;
  SearchResultPage({
    this.keyword
  });
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends SearchResultPageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Container(
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              // color: Color.fromARGB(58, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchQueryController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String terms) {
                      if (searchQueryController.text.length>= 3) {
                        setState(() {
                          searchVideoBloc.searchVideo(searchQueryController.text);
                          searchArticleBloc.searchArticle(searchQueryController.text);
                        });

                      }
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Search..",
                        hintStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          )),
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
                    ArticleSection(keyword: searchQueryController.text,),
                    VideoSection(keyword: searchQueryController.text,),
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
