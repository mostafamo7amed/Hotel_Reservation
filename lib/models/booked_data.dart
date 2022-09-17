import 'package:hotel/models/room_model.dart';

class BookedRoomData{
  String roomType;
  List<String> guests;
  double cost;
  int databaseId;
  Room room;
  String from;
  String to;
  BookedRoomData({
    required this.roomType,
    required this.guests,
    required this.cost,
    required this.databaseId,
    required this.room,
    required this.from,
    required this.to,
});
}