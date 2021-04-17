import 'dart:math';

import 'package:blog/bloc/list_article_bloc/list_article_state.dart';
import 'package:blog/model/article.dart';
import 'package:blog/resource/blog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListArticleBloc extends Cubit<ListArticleState>{
  ListArticleBloc():super(ListArticleUnitializedState());

  void getListArticle()async{
    if(state is ListArticleUnitializedState){
      try{
        List<Article>list=await BlogRepository().getAllArticle(1);
        if(list.length<10){
          emit(ListArticleLoadedState(article: list,isReachedEnd: true,page: 2));
        }else{
          emit(ListArticleLoadedState(article: list,isReachedEnd: false,page: 2));
        }

      }catch(e){
        print("terjadi kesalahan pada server "+e.toString());
        emit(ListArticleFailedState(Message: e.toString()));
      }
    }else{
      ListArticleLoadedState listArticleLoadedState=state as ListArticleLoadedState;
      List<Article>list=await BlogRepository().getAllArticle(listArticleLoadedState.page);
      emit(list.isEmpty?listArticleLoadedState.copyWith(isReachedEnd: true):
        listArticleLoadedState.copyWith(
          page: listArticleLoadedState.page+1,
          article: listArticleLoadedState.article+list,
            isReachedEnd: false
        )
      );
    }
  }

  bool isReachedMax(ListArticleState listArticleState){
    return listArticleState is ListArticleLoadedState && listArticleState.isReachedEnd;
  }

}