import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/shared/cubits/bluc.dart';
import 'package:hotel/shared/cubits/states.dart';


class BookedListView extends StatelessWidget {
  const BookedListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<HotelCubit, HotelStates>(
        builder: (context, state) {
          final bookedRooms = HotelCubit.getCubit(context).bookedRooms;
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: bookedRooms.length,
              itemBuilder: (context, index) => Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Room type: ${bookedRooms[index].roomType}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                    ),
                    Text("Room Cost: ${bookedRooms[index].cost}",
                      style: TextStyle(
                        fontSize: 18,
                      ),),
                    Text("Guest:", style: TextStyle(
                      fontSize: 18,
                    ),),
                    Container(
                      width:  MediaQuery.of(context).size.width * 0.2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: bookedRooms[index].guests.length,
                        itemBuilder: (context, inx) => Text(
                            bookedRooms[index].guests[inx],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ), //
                      ),
                    ),
                    Text("Date:", style: TextStyle(
                      fontSize: 18,
                    ),),
                    Text("from: ${bookedRooms[index].from}", style: TextStyle(
                      fontSize: 18,
                    ),),
                    Text("to: ${bookedRooms[index].to}", style: TextStyle(
                      fontSize: 18,
                    ),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
