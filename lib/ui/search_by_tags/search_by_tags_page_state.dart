import 'package:blog/bloc/search_article_by_tags_bloc/search_article_by_tags_bloc.dart';
import 'package:blog/bloc/search_video_by_tags_bloc/search_video_by_tags_bloc.dart';
import 'package:blog/ui/search_by_tags/search_by_tags_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchByTagsPageState extends State<SearchByTagsPage>{
  SearchVideoByTagsBloc searchVideoByTagsBloc;
  SearchArticleByTagsBloc searchArticleByTagsBloc;

  @override
  void initState() {
    searchArticleByTagsBloc=BlocProvider.of<SearchArticleByTagsBloc>(context);
    searchVideoByTagsBloc=BlocProvider.of<SearchVideoByTagsBloc>(context);
    searchVideoByTagsBloc.searchVideo(widget.tags);
    searchArticleByTagsBloc.searchArticle(widget.tags);
    // TODO: implement initState
    super.initState();
  }

}