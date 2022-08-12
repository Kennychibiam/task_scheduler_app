import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/database.dart';

import '../database_model.dart';
import '../route_generator.dart';
import "package:flutter_slidable/flutter_slidable.dart";
import 'package:to_do_list_app/widgets/show_dialog_widget.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  late Future<List<DatabaseModel>> futureToDoListItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureToDoListItems = DatabaseClass.instance
        .retrieveTable(tableName: DatabaseClass.TO_DO_LIST_TABLE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NOTES")),
      body: buildViews(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            moveToNotesView();
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget buildViews() => FutureBuilder<List<DatabaseModel>>(
      future: futureToDoListItems,
      builder: (context, snapshots) {
        if (snapshots.hasData && snapshots.data!.length > 0) {
          return buildLists(snapshots.data!);
        } else {
          return const Center(
            child: Text("YOUR TO DO IS EMPTY",),
          );
        }
      });

  void moveToNotesView() async {
    await Navigator.pushNamed(context, RouteGenerator.TEXT_NOTES_SCREEN,
        arguments: {});
    setState(() {
      futureToDoListItems = DatabaseClass.instance
          .retrieveTable(tableName: DatabaseClass.TO_DO_LIST_TABLE);
    });
  }

  Widget buildLists(List<DatabaseModel> dataModel) => RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
            itemCount: dataModel.length,
            itemBuilder: (context, index) => Slidable(
                  key: ValueKey<DatabaseModel?>(dataModel.elementAt(index)),
                  actions: [
                    SlideAction(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                      color: Colors.blue,
                      onTap: () => removeItemFromToDoList(
                          dataModel.elementAt(index).title),
                    ),
                  ],
                  actionPane: const SlidableScrollActionPane(),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(
                          context, RouteGenerator.TEXT_NOTES_SCREEN,
                          arguments: {
                            "Title": dataModel[index].title,
                            "Body": dataModel[index].body,
                            "Date": dataModel[index].dateCreated,
                            "IsCompleted": dataModel[index].isCompleted,
                          });
                      setState(() {
                        futureToDoListItems = DatabaseClass.instance
                            .retrieveTable(
                                tableName: DatabaseClass.TO_DO_LIST_TABLE);
                      });
                    },
                    child: Container(
                      height: 100.0,
                      margin: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dataModel[index].title!.split("///")[0],
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "${dataModel[index].body}",
                              style: const TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                              maxLines: 1,
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Checkbox(
                                    value: dataModel[index].isCompleted==0?false:true,
                                    onChanged: (boolValue) async {
                                      bool currentBoolValue =
                                      dataModel[index].isCompleted==0?false:true;
                                      if (boolValue == true) {
                                        dynamic option = await showDialogWidget(
                                            context,
                                            "Task Completion",
                                            "Do you want to mark this task as completed.");
                                        if (option!=null && option[0] != null && option[0] == true) {

                                          updateTaskCompletion(
                                              dataModel[index].title, 1);
                                        } else {

                                          setState(() {
                                            dataModel[index].isCompleted =
                                                currentBoolValue==true?1:0;
                                          });
                                        }
                                      } else {
                                        dynamic option = await showDialogWidget(
                                            context,
                                            "Task Completion",
                                            "Are you sure you want to undo this task completion");

                                        if (option!=null && option[0] != null && option[0] == true) {
                                          updateTaskCompletion(
                                              dataModel[index].title, 0);
                                        } else {
                                          setState(() {
                                            dataModel[index].isCompleted =
                                                currentBoolValue==true?1:0;
                                          });
                                        }
                                      }
                                    })),
                          ]),
                    ),
                  ),
                )),
      );

  Future<void> refresh() async {
    setState(() {
      futureToDoListItems = DatabaseClass.instance
          .retrieveTable(tableName: DatabaseClass.TO_DO_LIST_TABLE);
    });
  }

  void removeItemFromToDoList(String? listTitle) async {
    await DatabaseClass.instance
        .removeFromDatabase(DatabaseClass.TO_DO_LIST_TABLE, listTitle);
    setState(() {
      futureToDoListItems = DatabaseClass.instance
          .retrieveTable(tableName: DatabaseClass.TO_DO_LIST_TABLE);
    });
  }

  void updateTaskCompletion(String? listTitle, int isTaskCompleted) async {
    await DatabaseClass.instance.updateTaskCompletionOnDatabase(
        DatabaseClass.TO_DO_LIST_TABLE, listTitle, isTaskCompleted);

    setState(() {
      futureToDoListItems = DatabaseClass.instance
          .retrieveTable(tableName: DatabaseClass.TO_DO_LIST_TABLE);
    });
  }
}
