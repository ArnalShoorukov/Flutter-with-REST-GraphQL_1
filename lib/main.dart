import 'package:flutter/material.dart';
import 'package:flutter_with_rest_and_graphql/features/Article/ArticleManager.dart';
import 'package:flutter_with_rest_and_graphql/features/Article/ArticleModel.dart';
import 'package:flutter_with_rest_and_graphql/helpers/Observer.dart';
import 'package:flutter_with_rest_and_graphql/helpers/Overseer.dart';
import 'package:flutter_with_rest_and_graphql/helpers/Provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      data: Overseer(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primaryColor: Colors.white,
      ),
      home: MyHomePage(title: 'Dev to Mobile'),
    ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
   ArticleManager manager = Provider.of(context).fetch(ArticleManager);
  
    manager.inFilter.add('');

    return Scaffold(
      appBar: AppBar(
         title: Text(widget.title),
      ),
      body: Observer(
        stream: manager.browse$,
        onSuccess: (context, data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          ArticleModel element = data[index];

          return Card(
            child: Column(
              children: <Widget>[
                 ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(element.avator),
            ),
            title: Text(element.title),
            subtitle: Column(
              children: <Widget>[
                Text(element.description),
                Row(
                  children: <Widget>[
                    for(var tag in element.tags) Text("#$tag")
                  ],
                )
              ],
            ),
            isThreeLine: true,
          ),  
             Padding(padding: EdgeInsets.all(8.0),
             child: Row(children: <Widget>[
               Container(child: Text(element.reactionCount.toString()),)
             ],),)
              ],
            ),
          );
        },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
