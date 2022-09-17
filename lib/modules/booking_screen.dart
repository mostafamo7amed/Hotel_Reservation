import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/models/room_model.dart';
import 'package:hotel/shared/components/components.dart';
import 'package:hotel/shared/cubits/bluc.dart';
import 'package:hotel/shared/cubits/states.dart';

import '../models/booked_data.dart';
import '../shared/components/booked_listview.dart';
import '../shared/components/dialog_alert.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var nameController = TextEditingController();
  var nameController2 = TextEditingController();
  var nameController3 = TextEditingController();

  final bookFormKey = GlobalKey<FormState>();
  List<Room> availableRooms = [];
  int chooseRoomDbId = 0;
  Room? currentRoom;

  @override
  void initState() {
    super.initState();
    HotelCubit.getCubit(context)
        .getBranchRooms(HotelCubit.getCubit(context).branchSelected!);
    filterAvailableRooms("single");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<HotelCubit, HotelStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HotelCubit cubit = HotelCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Booking',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: bookFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to ${cubit.branchSelected} branch',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (cubit.haveSale)
                      Text(
                        'You have a sale up to 95%',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text(
                            'Room type : ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 200,
                            child: Center(
                              child: Container(
                                height: size.height * 0.07,
                                width: 200,
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.0, style: BorderStyle.solid),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: cubit.roomTypeSelected,
                                    items: cubit.roomType
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (item) {
                                      cubit.selectedRoomType(item!);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConditionalBuilder(
                      condition: true,
                      builder: (context) => Column(
                        children: [
                          cubit.roomTypeSelected == 'Single'
                              ? singleWidget(
                                  nameController1: nameController,
                                  height: 45.0,
                                )
                              : SizedBox(
                                  height: 0.001,
                                ),
                          cubit.roomTypeSelected == 'Double'
                              ? doubleWidget(
                                  nameController1: nameController,
                                  nameController2: nameController2,
                                  height: 45.0,
                                )
                              : SizedBox(
                                  height: 0.001,
                                ),
                          cubit.roomTypeSelected == 'Suit'
                              ? suitWidget(
                                  nameController1: nameController,
                                  nameController2: nameController2,
                                  nameController3: nameController3,
                                  height: 45.0,
                                )
                              : SizedBox(
                                  height: 0.001,
                                ),
                        ],
                      ),
                      fallback: (context) => Center(
                        child: Text(
                          'No available rooms in ${cubit.roomTypeSelected!}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        children: [
                          defaultButton(
                              onPressed: () {
                                if (bookFormKey.currentState!.validate()) {
                                  for (var room in availableRooms) {
                                    if (room.dbId == chooseRoomDbId) {
                                      setState(() {
                                        currentRoom = room;
                                      });
                                    }
                                  }
                                  if (currentRoom != null) {
                                    List<String> currentGuests = [];
                                    if (nameController.text.isNotEmpty)
                                      currentGuests.add(nameController.text);
                                    if (nameController2.text.isNotEmpty)
                                      currentGuests.add(nameController2.text);
                                    if (nameController3.text.isNotEmpty)
                                      currentGuests.add(nameController3.text);
                                    cubit.updateBookedList(BookedRoomData(
                                      guests: currentGuests,
                                      databaseId: chooseRoomDbId,
                                      cost: cubit.haveSale
                                          ? currentRoom!.cost * 0.95
                                          : currentRoom!.cost,
                                      roomType: cubit.roomTypeSelected!,
                                      room: currentRoom!,
                                    ));
                                    setState(() {
                                      if (availableRooms.length == 1)
                                        availableRooms = [];
                                      else
                                        availableRooms.remove(currentRoom);
                                      updateCurrentId();
                                      nameController.text = "";
                                      nameController2.text = "";
                                      nameController3.text = "";
                                    });
                                  }
                                }
                              },
                              text: 'Add',
                              height: size.height * 0.07),
                          Spacer(),
                          defaultButton(
                              onPressed: () {
                                if (cubit.bookedRooms.length > 0) {
                                  cubit.sumAllCost();
                                  alertMessage(
                                      context,
                                      "booking summary",
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Hotel branch: ${cubit.branchSelected}",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          BookedListView(),
                                          Text(
                                            "Check cost: ${cubit.allCost}",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ), () {
                                    // update room in data base
                                    cubit.updateRoom(cubit.branchSelected!);
                                    //save this guest who booked in database (for sale)
                                    cubit.saveNewGuestDatabase();
                                    //this guest have a sale
                                    cubit.guestHaveSale();
                                    //filter available rooms again
                                    filterAvailableRooms(
                                        cubit.roomTypeSelected!);
                                    //clear booking list
                                    cubit.clearBookedList();
                                    //update current page data
                                    cubit.getBranchRooms(cubit.branchSelected!);
                                    filterAvailableRooms(
                                        cubit.roomTypeSelected!);
                                    Navigator.of(context).pop();
                                  });
                                } else
                                  toast(
                                      message: 'Please add at least 1 room',
                                      data: ToastStates.warning);
                              },
                              text: 'Book',
                              height: size.height * 0.07),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  filterAvailableRooms(String filterType) {
    setState(() {
      availableRooms = [];
      for (var item in HotelCubit.getCubit(context).branchRooms) {
        if (item.type == filterType && item.booked == false) {
          availableRooms.add(item);
          chooseRoomDbId = item.dbId;
        }
      }
    });
  }

  updateCurrentId() {
    for (var item in availableRooms) {
      setState(() {
        chooseRoomDbId = item.dbId;
      });
    }
  }
}
