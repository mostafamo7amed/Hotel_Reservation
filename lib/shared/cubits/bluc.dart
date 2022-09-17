import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/shared/cubits/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/booked_data.dart';
import '../../models/room_model.dart';
import '../data/sqflite_helper.dart';

class HotelCubit extends Cubit<HotelStates> {

  HotelCubit() : super(HotelInitState());

  static HotelCubit getCubit(context) => BlocProvider.of(context);



  List<String> branch = ['Cairo' , 'Minya' , 'Sohag' , 'Alix'];
  String? branchSelected = 'Cairo';

  void selectedBranch(String item){
    branchSelected = item;
    emit(HotelBranchSelectedState());
  }



  List<String> roomType = ['Single' , 'Double' , 'Suit'];
  String? roomTypeSelected = 'Single';
  void selectedRoomType(String item){
    roomTypeSelected = item;
    emit(HotelRoomTypeSelectedState());
  }


  DbHelper dBHelper = DbHelper();
  bool isLoggedIn = false;
  String login = "login";
  String logout = "logout";
  List<Room> rooms = [];
  List guests = [];
  List<Room> branchRooms = [];
  List<BookedRoomData> bookedRooms = [];
  double allCost = 0;
  String currentGuest = "";
  var preferences;
  bool haveSale = false;


  void createDB() async {
    emit(HotelLoadingDatabaseState());
    preferences = await SharedPreferences.getInstance();
    await dBHelper.createDataBase();
    dBHelper.getRoomsDatabase().then((value) {
      rooms = value;
      emit(HotelGetRoomsSuccessState());
    }).catchError((error) {
      emit(HotelGetRoomsErrorState());
    });
    dBHelper.getGuestDatabase().then((value) {
      guests = value;
      for (String g in guests) {
        if (currentGuest == g) {
          preferences.setBool("currentGuestSale", true);
          guestHaveSale();
        }
      }
      emit(HotelGetGustsSuccessState());
    }).catchError((error) {
      emit(HotelGetGustsErrorState());
    });
  }

  //save guest who booked only in the datatbase
  saveNewGuestDatabase() {
    dBHelper.insertNewGuest(currentGuest).then((value) {
      rooms = value;
      emit(HotelAddGustsSuccessState());
    }).catchError((error) {
      emit(HotelAddGustsErrorState());
    });
  }

  //change flag
  changeLoggedIn() {
    isLoggedIn = !isLoggedIn;
    emit(HotelIsLoggedChangedState());
  }

  //keep guest logged in also if closed the app
  getCurrentGuest() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getString('guest') != null) {
      currentGuest = preferences.getString('guest');
      changeLoggedIn();
      emit(HotelChangeGuestState());
    }
    if (preferences.getBool('currentGuestSale') != null) {
      guestHaveSale();
    }
    print(
        "name: $currentGuest, isLoggedIn: $isLoggedIn, have a sale: $haveSale");
  }

  setCurrentGuest(String guest) {
    preferences.setString('guest', guest);
    currentGuest = guest;
    emit(HotelChangeGuestState());
  }

  getBranchRooms(String branchName) {
    branchRooms = [];
    for (Room room in rooms) {
      if (room.branch == branchName) {
        branchRooms.add(room);
      }
    }
    emit(HotelGetBranchRoomsState());
  }

  //this guest have a sale
  guestHaveSale() {
    haveSale = true;
    emit(HotelHaveSaleState());
  }

  //update statues of the task
  void updateRoom(String branchName) async {
    for (BookedRoomData r in bookedRooms) {
      String allGuests = r.guests[0];
      for (int i = 1; i < r.guests.length; i++) {
        allGuests += ",${r.guests[i]}";
      }
      await dBHelper.updateRoom(r.databaseId, true, allGuests);
      allGuests = "";
    }
    dBHelper.getRoomsDatabase().then((value) {
      rooms = value;
      getBranchRooms(branchName);
      emit(HotelUpdateRoomsSuccessState());
    }).catchError((error) {
      emit(HotelUpdateRoomsErrorState());
    });
  }

  //update the list of booked rooms
  updateBookedList(BookedRoomData room) {
    bookedRooms.add(room);
    emit(HotelUpdateBookedListState());
  }

  clearBookedList() {
    bookedRooms = [];
    emit(HotelClearBookedListState());
  }

  sumAllCost() {
    allCost = 0;
    for (BookedRoomData i in bookedRooms) {
      allCost += i.cost;
    }
    emit(HotelUpdateAllCostState());
  }

}