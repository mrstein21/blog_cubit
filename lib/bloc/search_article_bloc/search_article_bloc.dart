import 'package:blog/bloc/list_article_bloc/list_article_state.dart';
import 'package:blog/model/article.dart';
import 'package:blog/resource/blog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchArticleBloc extends Cubit<ListArticleState>{
  SearchArticleBloc():super(ListArticleUnitializedState());

  void searchArticle(String keyword)async{
   try{
     emit(ListArticleUnitializedState());
     List<Article>list=await BlogRepository().searchArticle(keyword, 1);
     if(list.isEmpty){
        emit(ListArticleEmptyState());
     }else {
       if (list.length < 10) {
         emit(ListArticleLoadedState(
             article: list, isReachedEnd: true, page: 2));
       } else {
         emit(ListArticleLoadedState(
             article: list, isReachedEnd: false, page: 2));
       }
     }
   }catch(e,track){
     print("kesalhan pada search result "+e.toString());
     emit(ListArticleFailedState());
   }
  }

  void searchMoreArticle(String keyword)async{
    ListArticleLoadedState currentState = state as ListArticleLoadedState;
    List<Article>list=await BlogRepository().searchArticle(keyword, 1);
    emit(list.isEmpty?currentState.copyWith(isReachedEnd: true):
    currentState.copyWith(
        page: currentState.page+1,
        article: currentState.article+list,
        isReachedEnd: false
    )
    );
  }

}