import 'package:flutter/material.dart';

import '../database_model.dart';
import '../models/database.dart';

class TodoListSearchDelegate extends SearchDelegate{
  //preceeding icon
  Function updateSearchItemsFuture;
  TodoListSearchDelegate(this.updateSearchItemsFuture);

  @override
  List<Widget>? buildActions(BuildContext context)=>[IconButton(onPressed:(){
    if(query.isNotEmpty){
    query="";
    }else{
      close(context, null);
    }
  }, icon:Icon(Icons.clear))];

//leading icon
  @override
  Widget? buildLeading(BuildContext context)=>IconButton(onPressed:(){close(context,null);}, icon:Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    Future<List<DatabaseModel>>futureToDoListItems = DatabaseClass.instance
        .retrieveTable(tableName: DatabaseClass.TO_DO_LIST_TABLE);
    updateSearchItemsFuture(futureToDoListItems);
    return SizedBox();
  }



}