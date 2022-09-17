
import '../../models/room_type.dart';

RoomType roomType = RoomType();
//let suggesting we have 3 branches / locations
const branchesData = [
  {"branch": "Cairo", "rate": 5, "image":"one"},
  {"branch": "Giza", "rate": 4, "image":"two"},
  {"branch": "Minya", "rate": 7, "image":"three"},
  {"branch": "Sohag", "rate": 5, "image":"four"},
  {"branch": "Alix", "rate": 4, "image":"five"},
  {"branch": "Loxur", "rate": 7, "image":"six"},
  {"branch": "Aswan", "rate": 7, "image":"seven"},
  {"branch": "Sharm Elshikh", "rate": 5, "image":"eight"},
  {"branch": "Hurghada", "rate": 7, "image":"nine"},
  {"branch": "Gona", "rate": 7, "image":"teen"},
];// and let every branch have 6 rooms
List roomsData = [
  {"branch":"","room_number":1,"booked":false,"type":"${roomType.singleRoom.toString()}","guest":"","cost":300,"bookfrom":"","bookto":""},
  {"branch":"","room_number":2,"booked":false,"type":"${roomType.singleRoom.toString()}","guest":"","cost":300,"bookfrom":"","bookto":""},

  {"branch":"","room_number":3,"booked":false,"type":"${roomType.doubleRoom.toString()}","guest":"","cost":500,"bookfrom":"","bookto":""},
  {"branch":"","room_number":4,"booked":false,"type":"${roomType.doubleRoom.toString()}","guest":"","cost":500,"bookfrom":"","bookto":""},

  {"branch":"","room_number":5,"booked":false,"type":"${roomType.suitRoom.toString()}","guest":"","cost":700,"bookfrom":"","bookto":""},
  {"branch":"","room_number":6,"booked":false,"type":"${roomType.suitRoom.toString()}","guest":"","cost":700,"bookfrom":"","bookto":""},

  {"branch":"","room_number":7,"booked":false,"type":"${roomType.singleRoom.toString()}","guest":"","cost":300,"bookfrom":"","bookto":""},
  {"branch":"","room_number":8,"booked":false,"type":"${roomType.singleRoom.toString()}","guest":"","cost":300,"bookfrom":"","bookto":""},

  {"branch":"","room_number":9,"booked":false,"type":"${roomType.doubleRoom.toString()}","guest":"","cost":500,"bookfrom":"","bookto":""},
  {"branch":"","room_number":10,"booked":false,"type":"${roomType.doubleRoom.toString()}","guest":"","cost":500,"bookfrom":"","bookto":""},

  {"branch":"","room_number":11,"booked":false,"type":"${roomType.suitRoom.toString()}","guest":"","cost":700,"bookfrom":"","bookto":""},
  {"branch":"","room_number":12,"booked":false,"type":"${roomType.suitRoom.toString()}","guest":"","cost":700,"bookfrom":"","bookto":""},


];

