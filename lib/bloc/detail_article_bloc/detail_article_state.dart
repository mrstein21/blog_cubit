import 'package:blog/model/article.dart';
import 'package:blog/model/article_tags.dart';
import 'package:blog/model/video.dart';
import 'package:equatable/equatable.dart';

abstract class DetailArticleState extends Equatable{}

class DetailArticleUnitializedState extends DetailArticleState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class DetailArticleFailedState extends DetailArticleState{
  String message;
  DetailArticleFailedState({
    this.message
  });
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class DetailArticleLoadedState extends DetailArticleState{
  Article article;
  List<ArticleTags>related;
  DetailArticleLoadedState({
    this.article,
    this.related,
  });

  @override
  // TODO: implement props
  List<Object> get props => [article,related];

}