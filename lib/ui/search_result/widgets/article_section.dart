import 'package:blog/bloc/list_article_bloc/list_article_state.dart';
import 'package:blog/bloc/search_article_bloc/search_article_bloc.dart';
import 'package:blog/mixins/server.dart';
import 'package:blog/model/article.dart';
import 'package:blog/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleSection extends StatelessWidget {
  String keyword;
  ArticleSection({
    this.keyword
  });
  SearchArticleBloc searchArticleBloc;
  ScrollController controller = new ScrollController();

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
    if(maxScroll==currentScroller){
      searchArticleBloc.searchMoreArticle(keyword);
    }
  }


  @override
  Widget build(BuildContext context) {
    print("hasil keywords "+keyword);
    searchArticleBloc=BlocProvider.of<SearchArticleBloc>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: BlocBuilder<SearchArticleBloc,ListArticleState>(
        builder: (ctx,state){
          if(state is ListArticleLoadedState){
            return _buildListArticle(state.article, state.isReachedEnd,context);
          }else if(state is ListArticleFailedState){
            print(state.Message);
            return _buildMessage();
          }else if(state is ListArticleUnitializedState){
            return _buildLoading();
          }else if(state is ListArticleEmptyState){
            return _buildMessageEmpty();
          }
        },
      ),
    );
  }


  Widget _buildLoading(){
    return Center(
      child: CircularProgressIndicator(),
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


  Widget _buildMessageEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey,
              size: 70,
            ),
            Text(
              "Pencarian tidak ditemukan",
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


  Widget _buildListArticle(List<Article>list,bool isReachedEnd,var context){
    return ListView.builder(
        controller: controller,
        itemCount: isReachedEnd?list.length:list.length+1,
        itemBuilder: (contet,index){
          if(index<list.length){
            return _buildRowArticle(list[index],context);
          }else{
            return _buildLoading();
          }
        }
    );
  }

  Widget _buildRowArticle(Article article,context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouterGenerator.routeDetailArticle,arguments: {
          "id":article.id
        });
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage(Server.url+article.image),
                      fit: BoxFit.fill
                  )
              ),
            ),
            SizedBox(width: 4,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    article.title,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    article.short_description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: "Roboto",
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(Server.url + article.author.avatar),
                              radius: 50,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            article.author.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
