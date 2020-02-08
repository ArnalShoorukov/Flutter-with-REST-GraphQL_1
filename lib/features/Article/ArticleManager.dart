import 'package:flutter_with_rest_and_graphql/features/Article/ArticleModel.dart';
import 'package:flutter_with_rest_and_graphql/features/Article/ArticleService.dart';
import 'package:flutter_with_rest_and_graphql/helpers/Manager.dart';
import 'package:rxdart/rxdart.dart';

class ArticleManager implements Manager{
  
  

final PublishSubject<String> _filterSubject = PublishSubject<String>();
final PublishSubject<List<ArticleModel>> _collectionSubject = 
      PublishSubject<List<ArticleModel>>();

Stream<List<ArticleModel>> get browse$ => _collectionSubject.stream; 
Sink<String> get inFilter => _filterSubject.sink; 

ArticleManager(){
  _filterSubject.switchMap((filter) async* {
    yield await ArticleService.query();
  }).listen((collection){
    _collectionSubject.add(collection);
  });
}

  @override
  void dispose() {
    // TODO: implement dispose
  }

}