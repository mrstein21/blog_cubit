import 'package:blog/bloc/detail_article_bloc/detail_article_bloc.dart';
import 'package:blog/bloc/detail_article_bloc/detail_article_state.dart';
import 'package:blog/mixins/custom_gesture.dart';
import 'package:blog/mixins/platform.dart';
import 'package:blog/mixins/server.dart';
import 'package:blog/model/article.dart';
import 'package:blog/model/article_tags.dart';
import 'package:blog/routes.dart';
import 'package:blog/ui/detail_article/detail_article_page_state.dart';
import 'package:blog/ui/detail_article/widget/related_article_section.dart';
import 'package:blog/ui/full_image_page.dart';
import 'package:blog/ui/full_youtube_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailArticlePage extends StatefulWidget {
  int id;
  DetailArticlePage({this.id});
  @override
  _DetailArticlePageState createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends DetailArticlePageState {
var size;
var kHtml = """
<h1>Heading</h1>
<p>A paragraph with <strong>strong</strong> <em>emphasized</em> text.</p>
<ol>
  <li>List item number one</li>
  <li>
    Two
    <ul>
      <li>2.1 (nested)</li>
      <li>2.2</li>
    </ul>
  </li>
  <li>Three</li>
</ol>
<p>And YouTube video!</p>
<iframe src="https://www.youtube.com/embed/jNQXAC9IVRw" width="560" height="315"></iframe>
""";


  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    size=MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<DetailArticleBloc,DetailArticleState>(
          builder: (ctx,state) {
           if (state is DetailArticleFailedState) {
                return _buildMessage();
            }else if (state is DetailArticleUnitializedState) {
             return _buildLoading();
           } else  if(state is DetailArticleLoadedState){
             return _buildDetail(state.article,state.related);
           }
      }),
    );
  }

  Widget _buildDetail(Article detailArticle,List<ArticleTags>list) {
    return SafeArea(
      child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, scroller) {
            return <Widget>[
              SliverAppBar(
                leading: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
                actions: [
                  InkWell(
                    child: Icon(Icons.bookmark),
                  ),
                  SizedBox(width: 5,)
                ],
                titleSpacing: 0,
                title: Text(
                  "",
                  style: TextStyle(fontFamily: "Roboto"),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expandedHeight: 240.0,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildCover(detailArticle),
                ),
              )
            ];
          },
          body: Container(
            color: Colors.white,
            child: ListView(children: <Widget>[
              progress != 1.0
                  ? LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple))
                  : Container(
                height: 0,
              ),
              // _buildRenderHtml2()
               _buildRenderHtml(detailArticle.content),
              RelatedArticleSection(list: list,context: context,)
            ]),
          )),
    );
  }

  Widget _buildRenderHtml(String content){
    return Padding(
        padding: EdgeInsets.all(8),
        child:HtmlWidget(
         content,
          customWidgetBuilder: (element){
           if(element.localName=="img" && element.attributes.containsKey("src")){
             return InkWell(
               child: Image.network(element.attributes["src"]),
               onTap: (){
                 Navigator.pushNamed(context,RouterGenerator.routeFullImage,arguments: {
                   "url": element.attributes["src"]
                 });
               },
             );
             print("source element "+element.attributes["src"]);
           }else if(element.localName=="iframe" && element.attributes["src"].contains("youtube")){
             String url=element.attributes["src"];
             YoutubePlayerController _controller= YoutubePlayerController(
                 initialVideoId: YoutubePlayer.convertUrlToId(url),
                 flags: YoutubePlayerFlags(
                   autoPlay: false,
                 )
             );
             return YoutubePlayer(
                 controller: _controller,
               bottomActions: [
                 const SizedBox(width: 14.0),
                 CurrentPosition(),
                 const SizedBox(width: 8.0),
                 ProgressBar(
                   isExpanded: true,
                 ),
                 RemainingDuration(),
                 InkWell(
                   onTap: (){
                     _controller.pause();
                     Navigator.pushNamed(context,RouterGenerator.routeFullYoutube,arguments: {
                       "url": element.attributes["src"]
                     });
                   },
                   child: Icon(Icons.fullscreen,color: Colors.white,size: 20,),
                 ),

               ],
             );
           }
          },
          onTapUrl: (String url){
           print("click url "+url);
           launchURL(url, context);
          },
          webViewJs: true,
          webView: true,
          unsupportedWebViewWorkaroundForIssue37: false,
    ));
  }



  Widget _buildCover(Article detailArticle) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(Server.url + detailArticle.image),
          )),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(detailArticle.title,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 8,
            ),
            _buildTags(detailArticle.tags),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircleAvatar(
                        backgroundImage:
                        NetworkImage(Server.url + detailArticle.author.avatar),
                        radius: 50,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      detailArticle.author.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 14),
                    ),
                  ],
                ),
                Text(
                  detailArticle.date,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            // Text(
            //   detailArticle.tags.join(" - "),
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //       fontFamily: 'Montserrat',
            //       fontSize: 14),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTags(List<ArticleTags> tags){
    return Wrap(
      children: tags.map<Widget>((e){
        return InkWell(
          onTap: (){
            Navigator.pushNamed(context, RouterGenerator.routeSearchByTags,
                arguments: {
                  "tags":e.topic_id.toString(),
                  "tags_name":e.topic.topic_name
                });
          },
          child: Container(
            margin: EdgeInsets.only(right: 4),
            padding: EdgeInsets.all(3),
            child: Text(e.topic.topic_name,style: TextStyle(fontSize: 12,fontFamily: "Roboto",color: Colors.white,fontWeight: FontWeight.bold),),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.white)
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 6,
          ),
          Text(
            "Loading..",
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_cellular_connected_no_internet_4_bar,
              color: Colors.grey,
              size: 70,
            ),
            Text(
              "Can't Connect to Server",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
