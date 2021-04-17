import 'package:blog/bloc/list_article_bloc/list_article_state.dart';
import 'package:blog/bloc/search_article_by_tags_bloc/search_article_by_tags_state.dart';
import 'package:blog/model/article.dart';
import 'package:blog/model/article_tags.dart';
import 'package:blog/resource/blog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchArticleByTagsBloc extends Cubit<ListArticleTagsState>{
  SearchArticleByTagsBloc():super(ListArticleTagsUnitializedState());

  void searchArticle(String tags)async{
    try{
      emit(ListArticleTagsUnitializedState());
      List<ArticleTags>list=await BlogRepository().searchArticleByTags(tags, 1);
      if(list.isEmpty){
        emit(ListArticleTagsEmptyState());
      }else {
        if (list.length < 10) {
          emit(ListArticleTagsLoadedState(
              article: list, isReachedEnd: true, page: 2));
        } else {
          emit(ListArticleTagsLoadedState(
              article: list, isReachedEnd: false, page: 2));
        }
      }
    }catch(e,track){
      print("kesalhan pada search result "+e.toString());
      emit(ListArticleTagsFailedState());
    }
  }

  void searchMoreArticle(String tags)async{
    ListArticleTagsLoadedState currentState = state as ListArticleTagsLoadedState;
    List<ArticleTags>list=await BlogRepository().searchArticleByTags(tags,currentState.page);
    emit(list.isEmpty?currentState.copyWith(isReachedEnd: true):
    currentState.copyWith(
        page: currentState.page+1,
        article: currentState.article+list,
        isReachedEnd: false
    )
    );
  }

}