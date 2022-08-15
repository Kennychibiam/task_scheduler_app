import 'dart:io';

import "package:sqflite/sqflite.dart";
import "package:path_provider/path_provider.dart";
import 'package:path/path.dart';
import 'package:to_do_list_app/database_model.dart';

class DatabaseClass {
  static DatabaseClass instance = DatabaseClass();
  static Database? database;
  static const String TO_DO_LIST_TABLE = "TO_DO_LIST_TABLE";
  static const String NOTIFICATION_TABLE = "NOTIFICATION_TABLE";

  DatabaseClass();

  //gets the instance of the Database if database object is null
  Future<Database> get openGetDatabase async {
    return database ?? await createOrOpenTableDatabase();
  }

  Future<Database> createOrOpenTableDatabase() async {
    Directory path = Platform.isIOS
        ? await getLibraryDirectory()
        : await getApplicationDocumentsDirectory();
    ;
    return openDatabase(
      join(path.path, 'example.db'),

      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE TO_DO_LIST_TABLE(ID INTEGER PRIMARY KEY AUTOINCREMENT,"
              " TITLE TEXT NOT NULL, "
              "BODY TEXT NOT NULL, "
              "DATE_CREATED TEXT NOT NULL, "
              "IS_COMPLETED INTEGER NOT NULL"
              ")",
        );
        await database.execute("CREATE TABLE NOTIFICATION_TABLE(ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT NOT NULL, DATE TEXT NOT NULL, TIME TEXT NOT NULL )");
      },
      version: 1,
    );
  }

  Future<int?> insertIntoToDoTable(
      {required String tableName, required DatabaseModel modelDatabase}) async {
    int? result;

    database =
    await instance.openGetDatabase; //returns instance of itself if not null

    List<Map<String, Object?>>? resultCheck = await database
        ?.query(tableName, where: "Title=?", whereArgs: [modelDatabase.title]);

    if (resultCheck?.isNotEmpty ?? false) {
      result = await updateToDoTable(
          tableName: tableName, modelDatabase: modelDatabase);
    } else {
      result =
      await database?.insert(tableName, modelDatabase.convertDataToMap());
    }
    return result;
  }

  Future<int?> updateToDoTableTitle(
      {required String tableName, required String oldTableTitle, required String newTableTitle, required DatabaseModel modelDatabase}) async {
    int? result;

    database =
    await instance.openGetDatabase; //returns instance of itself if not null

    List<Map<String, Object?>>? resultCheck = await database
        ?.query(tableName, where: "Title=?", whereArgs: [oldTableTitle]);

    if (resultCheck?.isNotEmpty ?? false) {
      result = await database?.update(tableName, modelDatabase.convertDataToMap(),
          where: "Title=?", whereArgs: [oldTableTitle]);
    }
    return result;
  }

  Future<List<DatabaseModel>> retrieveTable({required String tableName}) async {
    database =
    await instance.openGetDatabase; //returns instance of itself if not null

    List<Map<String, Object?>>? result = await database?.query(tableName);
    return DatabaseModel.toMap().convertToModelClass(result);
  }

  Future<int?> updateToDoTable(
      {required String tableName, required DatabaseModel modelDatabase}) async {
    int? result;
    database = await instance.openGetDatabase;

    result = await database?.update(tableName, modelDatabase.convertDataToMap(),
        where: "Title=?", whereArgs: [modelDatabase.title]);
    //print(result??""+ "  update");
    return result;
  }

  Future<int?> removeFromDatabase(String tableName, String? listTitle) async {
    int? result;
    database = await instance.openGetDatabase;
    result = await database
        ?.delete(tableName, where: "TITLE=?", whereArgs: [listTitle]);
    return result;
  }

  Future<int?> updateTaskCompletionOnDatabase(String tableName,
      String? listTitle, int ?isTaskCompleted) async {
    int? result;
    database = await instance.openGetDatabase;
    result = await database
        ?.update(tableName, {"IS_COMPLETED": isTaskCompleted}, where: "TITLE=?",
        whereArgs: [listTitle]);
    return result;
  }


  Future<int?> insertIntoNotificationTable(
      {required String tableName, required DatabaseModel modelDatabase}) async {
    int? result;

    database =
    await instance.openGetDatabase; //returns instance of itself if not null

    List<Map<String, Object?>>? resultCheck = await database
        ?.query(tableName, where: "Title=?", whereArgs: [modelDatabase.title]);

    if (resultCheck?.isNotEmpty ?? false) {
      result = await updateNotificationTable(
          tableName: tableName, modelDatabase: modelDatabase);
    } else {
      result =
      await database?.insert(tableName, modelDatabase.convertDataToMap());
    }
    return result;
  }
  Future<int?> updateNotificationTable(
      {required String tableName, required DatabaseModel modelDatabase}) async {
    int? result;
    database = await instance.openGetDatabase;

    result = await database?.update(tableName, modelDatabase.convertDataToMap(),
        where: "Title=?", whereArgs: [modelDatabase.title]);
    //print(result??""+ "  update");
    return result;
  }

  Future<int> retrieveIdFromNotificationTable(String title) async {
    database =
    await instance.openGetDatabase; //returns instance of itself if not null

    List<Map<String, dynamic>>? result = await database?.query(NOTIFICATION_TABLE,where: "TITLE=?",whereArgs: [title]);
    int id=result?.first["ID"];
    return id;
  }

}
