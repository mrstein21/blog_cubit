import 'package:blog/model/article.dart';
import 'package:blog/model/article_tags.dart';
import 'package:equatable/equatable.dart';

abstract class ListArticleTagsState extends Equatable{

}


class ListArticleTagsLoadedState extends ListArticleTagsState{
  bool isReachedEnd=false;
  int page;
  List<ArticleTags>article;

  ListArticleTagsLoadedState({
    this.isReachedEnd,
    this.page,
    this.article
  });

  ListArticleTagsLoadedState copyWith({int page,bool isReachedEnd,List<ArticleTags>article})=>ListArticleTagsLoadedState(
      article: article ?? this.article,
      isReachedEnd:isReachedEnd?? this.isReachedEnd,
      page: page ?? this.page
  );

  @override
  // TODO: implement props
  List<Object> get props => [page,isReachedEnd,article];
}

class ListArticleTagsFailedState extends ListArticleTagsState{
  String Message;
  ListArticleTagsFailedState({
    this.Message
  });

  @override
  // TODO: implement props
  List<Object> get props => [Message];
}

class ListArticleTagsUnitializedState extends ListArticleTagsState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class ListArticleTagsEmptyState extends ListArticleTagsState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
