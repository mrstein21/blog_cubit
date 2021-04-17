import 'package:blog/bloc/list_article_bloc/list_article_bloc.dart';
import 'package:blog/ui/list_article/list_article_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ListArticlePageState extends State<ListArticlePage>{
  ListArticleBloc listArticleBloc;
  ScrollController controller =ScrollController();
  @override
  void initState() {
    listArticleBloc=BlocProvider.of<ListArticleBloc>(context);
    listArticleBloc.getListArticle();
    super.initState();
  }

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
    if(maxScroll==currentScroller){
      listArticleBloc.getListArticle();
    }
  }

}