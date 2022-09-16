import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/shared/components/components.dart';
import 'package:hotel/shared/cubits/bluc.dart';
import 'package:hotel/shared/cubits/states.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var nameController2 = TextEditingController();
  var nameController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HotelCubit,HotelStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        HotelCubit cubit = HotelCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Booking',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Welcome to branch ${cubit.branchSelected}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10,),
                Text('You have a sale up to 95%',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Room type : ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 200,
                        child: Center(
                          child: Container(
                            height: 45,
                            width: 200,
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1.0, style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: cubit.roomTypeSelected,
                                items: cubit.roomType.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),),
                                ),
                                ).toList(),
                                onChanged:(item) {
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
                cubit.roomTypeSelected=='Single'?singleWidget(
                    nameController1: nameController,
                ): SizedBox(height: 0.001,),
                cubit.roomTypeSelected=='Double'?doubleWidget(
                    nameController1: nameController,
                    nameController2: nameController2
                ): SizedBox(height: 0.001,),
                cubit.roomTypeSelected=='Suit'?suitWidget(
                    nameController1: nameController,
                    nameController2: nameController2,
                    nameController3: nameController3,
                ): SizedBox(height: 0.001,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      defaultButton(onPressed: (){
                        //
                      }, text: 'Add'),
                      Spacer(),
                      defaultButton(onPressed: (){
                       //
                      }, text: 'Book'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}
