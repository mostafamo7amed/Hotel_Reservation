import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/modules/booking_screen.dart';
import 'package:hotel/modules/login_screen.dart';
import 'package:hotel/modules/rooms_screen.dart';
import 'package:hotel/shared/components/components.dart';
import 'package:hotel/shared/cubits/bluc.dart';
import 'package:hotel/shared/cubits/states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<HotelCubit, HotelStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HotelCubit cubit = HotelCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Hotel',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  if (cubit.isLoggedIn) {
                    cubit.changeLoggedIn();
                  } else {
                    navigateTo(context, LoginScreen());
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    cubit.isLoggedIn
                        ? cubit.logout.toString()
                        : cubit.login.toString(),
                    style: TextStyle(
                      fontFamily: 'Janna',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                ListView.builder(
                    itemCount: cubit.branchesData.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          if (cubit.isLoggedIn) {
                            navigateTo(context, BookingScreen());
                            cubit.selectedBranch(cubit.branchesData[i]['branch'].toString());
                            cubit.selectedImageBranch(cubit.branchesData[i]['image'].toString());
                          } else {
                            toast(
                                message: 'You can\'t book a room until login',
                                data: ToastStates.warning);
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/${cubit.branchesData[i]['image']}.jpg',
                              width: 100,
                              height: 120,
                              fit: BoxFit.fill,
                            ),
                            title: Text(
                              "${cubit.branchesData[i]['branch']}",
                              style: const TextStyle(
                                  color: Colors.cyan, fontSize: 20),
                            ),
                            subtitle: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${cubit.branchesData[i]['rate']}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                const Icon(Icons.star, color: Colors.amber),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  /*Widget oldDesign() => Column(
    children: [
      Image.asset(
        'assets/images/hotel.jpg',
        width: double.infinity,
        height: 240,
        fit: BoxFit.cover,
      ),
      const SizedBox(
        height: 30,
      ),
      SizedBox(
        width: 250,
        child: Center(
          child: Container(
            height: 45,
            width: 250,
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
                value: cubit.branchSelected,
                items: cubit.branch.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item,
                    style: const TextStyle(
                      fontSize: 18,
                    ),),
                ),
                ).toList(),
                onChanged:(item) {
                  cubit.selectedBranch(item!);
                },
              ),
            ),
          ),
        ),
      ),
      if (cubit.haveSale)
        Text("You have a sale up to 95%",
          style: TextStyle(
            fontSize: 16,
          ) ,
        ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultButton(onPressed: (){
              if(cubit.isLoggedIn){
                navigateTo(context, RoomScreen());
              }else{
                toast(message: 'You can\'t view rooms until login', data: ToastStates.warning);
              }
            }, text: 'Rooms status', height: size.height*0.07),
            const SizedBox(width: 10,),
            defaultButton(onPressed: (){
              if(cubit.isLoggedIn){
                navigateTo(context, BookingScreen());
              }else{
                toast(message: 'You can\'t book a room until login', data: ToastStates.warning);
              }
            }, text: 'Book a room', height: size.height*0.07),
          ],
        ),
      ),
    ],
  );*/
}
