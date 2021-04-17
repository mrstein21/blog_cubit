import 'package:blog/model/article.dart';
import 'package:equatable/equatable.dart';

abstract class ListArticleState extends Equatable{

}


 class ListArticleLoadedState extends ListArticleState{
  bool isReachedEnd=false;
  int page;
  List<Article>article;

   ListArticleLoadedState({
     this.isReachedEnd,
     this.page,
     this.article
   });

   ListArticleLoadedState copyWith({int page,bool isReachedEnd,List<Article>article})=>ListArticleLoadedState(
     article: article ?? this.article,
       isReachedEnd:isReachedEnd?? this.isReachedEnd,
     page: page ?? this.page
   );

  @override
  // TODO: implement props
  List<Object> get props => [page,isReachedEnd,article];
}

class ListArticleFailedState extends ListArticleState{
  String Message;
  ListArticleFailedState({
    this.Message
  });

  @override
  // TODO: implement props
  List<Object> get props => [Message];
}

class ListArticleUnitializedState extends ListArticleState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class ListArticleEmptyState extends ListArticleState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
