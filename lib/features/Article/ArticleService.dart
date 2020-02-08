import 'dart:convert';

import 'package:flutter_with_rest_and_graphql/features/Article/ArticleModel.dart';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';

const ArticleQuery = '''
 query Articles {
  devTo {
    articles(state: "rising", tag: "") {
      edges {
        node {
          id
          title
          description
         positiveReactionsCount
          tags
        
        }
      }
    }
  }
}
''';

class ArticleService{
    static String _url = "https://dev.to/api/articles"; 

    static HttpLink link = HttpLink(uri: 'https://serve.onegraph.com/dynamic?app_id=0b33e830-7cde-4b90-ad7e-2a39c57c0e11&show_metrics=true&show_api_requests=false' ); 

    static GraphQLClient client = GraphQLClient(
      cache: InMemoryCache(), 
      link: link );
  //Get /articles
    static Future<List<ArticleModel>> browse() async{
      http.Response response = await http.get("$_url"); 
      String payload = response.body; 

      List collection = json.decode(payload); 

      Iterable<ArticleModel> elements = collection
        .map((_) => ArticleModel.fromJSON(_));

        return elements.toList(); 

    }

    static Future<List<ArticleModel>> query() async {
        final QueryOptions _options = QueryOptions(
          documentNode: gql(ArticleQuery),
          variables: {},             
        );

        QueryResult result = await client.query(_options); 
      

        List data = result.data['devTo']['articles']['edges'];

        Iterable<ArticleModel> elements = data
        .map((_) => ArticleModel.fromJSON(_));

        return elements.toList(); 
    }

  //GET /articfles/:id
    static Future<ArticleModel> fetch(){}
}
