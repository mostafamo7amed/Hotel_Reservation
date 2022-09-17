
import 'package:hotel/shared/cubits/bluc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/room_model.dart';
import 'constant_data.dart';

class DbHelper {
 late Database database;
 var preferences ;

 //create new database and get the values of database
  Future createDataBase() async {
    preferences = await SharedPreferences.getInstance();
    //create the branches table
    database = await openDatabase('hotel.db', version: 1,
        onCreate: (database, version) {
      database
          .execute('CREATE TABLE branches (name TEXT)')
          .then((value) => print('table created'))
          .catchError((onError) =>
              {print('error in create table: ${onError.toString()}')});
    }, onOpen: (database) {
    });
    //create table for all guest who booked before
    await database.execute(
        'CREATE TABLE IF NOT EXISTS guests ( guest TEXT)');

    //create table for rooms
      await database.execute(
          'CREATE TABLE IF NOT EXISTS rooms (id INTEGER PRIMARY KEY, branch TEXT, room_number INTEGER, booked TEXT,type TEXT,guest TEXT,cost REAL, bookfrom Text, bookto Text)');

      // insert branches and rooms in database for the first time only
    if( preferences.getBool("isSavedBefore") == null){
      //insert branches
      for(String branchN in branchesData){
        await database.transaction((txn) async{
          txn.rawInsert('INSERT INTO branches (name) VALUES ("$branchN")');
        });
      }
      //insert rooms for every branch
      for(String branchN in branchesData){
        for(var r in roomsData){
          await database.transaction((txn) async{
            txn.rawInsert('INSERT INTO rooms (branch, room_number, booked, type, guest, cost, bookfrom, bookto) VALUES ("$branchN", ${r['room_number']},"${r['booked']}","${r['type']}","${r['guest']}",${r['cost']},"${r['bookfrom']}", "${r['bookto']}")');
          });
        }
      }
      preferences.setBool("isSavedBefore",true);
    }
  }

  Future getRoomsDatabase() async {
    var db = await openDatabase('hotel.db');
    List<Map> servicesdata = await db.rawQuery('SELECT * FROM rooms');
    List<Room> newList = servicesdata.map((e) => Room(dbId: e["id"],branch: e["branch"],roomNumber: e["room_number"],booked: e["booked"] == "false"? false : true,type: e["type"],guest:e["guest"],cost: e["cost"],bookFrom: e["bookfrom"],bookTo: e["bookto"] )).toList();
    return newList ;
  }
 Future getGuestDatabase() async {
   var db = await openDatabase('hotel.db');
   List<Map> servicesdata = await db.rawQuery('SELECT * FROM guests');
   List newList = servicesdata.map((e) => e['guest'].toString()).toList();
   return newList ;
 }
 //insert new guest into the database
 Future insertNewGuest(String guestName) async {
   var db = await openDatabase('hotel.db');
   await db.transaction((txn) async{
     txn.rawInsert('INSERT INTO guests (guest) VALUES ("$guestName")');
   });
 }
 //update the room data after booking
 Future updateRoom(int dbId, bool isBooked, String names) async {
   await database
       .rawUpdate('UPDATE rooms SET booked = ?, guest = ? WHERE id = ?', ['$isBooked',names,dbId]);
 }
}
