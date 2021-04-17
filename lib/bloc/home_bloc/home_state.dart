import 'package:blog/model/article.dart';
import 'package:blog/model/video.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable{}

class HomeUnitializedState extends HomeState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class HomeFailedState extends HomeState{
  String message;
  HomeFailedState({
    this.message
   });
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class HomeLoadedState extends HomeState{
  List<Video>video;
  List<Article>article;
  HomeLoadedState({
    this.video,
    this.article
  });

  @override
  // TODO: implement props
  List<Object> get props => [video,article];

}