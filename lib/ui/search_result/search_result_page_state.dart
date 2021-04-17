import 'package:blog/bloc/search_article_bloc/search_article_bloc.dart';
import 'package:blog/bloc/video_bloc/search_video_bloc.dart';
import 'package:blog/ui/search_result/search_result_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchResultPageState extends State<SearchResultPage>{
  TextEditingController searchQueryController = new TextEditingController();
  SearchArticleBloc searchArticleBloc;
  SearchVideoBloc searchVideoBloc;

  @override
  void initState() {
    searchVideoBloc=BlocProvider.of<SearchVideoBloc>(context);
    searchArticleBloc=BlocProvider.of<SearchArticleBloc>(context);
    setState(() {
      searchQueryController.text=widget.keyword;
    });
    searchArticleBloc.searchArticle(widget.keyword);
    searchVideoBloc.searchVideo(widget.keyword);
    // TODO: implement initState
    super.initState();
  }

}