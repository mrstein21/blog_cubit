import 'package:blog/bloc/detail_video_bloc/detail_video_bloc.dart';
import 'package:blog/ui/detail_article/detail_article_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'detail_video_page.dart';

abstract class DetailVideoPageState extends State<DetailVideoPage>{
  YoutubePlayerController controller;
  DetailVideoBloc detailVideoBloc;

  @override
  void initState() {
    detailVideoBloc=BlocProvider.of<DetailVideoBloc>(context);
    detailVideoBloc.getDetail(widget.id);
    // TODO: implement initState
    super.initState();
  }



}