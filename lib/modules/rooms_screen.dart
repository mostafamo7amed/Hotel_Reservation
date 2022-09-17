import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/shared/cubits/bluc.dart';
import 'package:hotel/shared/cubits/states.dart';

import '../shared/components/components.dart';
import 'booking_screen.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HotelCubit,HotelStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        HotelCubit cubit = HotelCubit.getCubit(context);
        cubit.getBranchRooms(cubit.branchSelected!);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.branchSelected!,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
             ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ListView.builder(
                    itemCount: cubit.branchRooms.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Text(cubit.branchRooms[index].roomNumber.toString(),style: TextStyle(fontSize: 18),),
                          title: Text(
                              cubit.branchRooms[index].booked ? "Booked" : "Available",style: TextStyle(fontSize: 18),),
                          subtitle: Text(cubit.branchRooms[index].type.toString(),style: TextStyle(fontSize: 18),),
                          trailing: Text(cubit.branchRooms[index].booked
                              ? "15/3/2022 ${cubit.branchRooms[index].bookTo}"
                              : "${cubit.branchRooms[index].cost}LE",style: TextStyle(fontSize: 18),),
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
