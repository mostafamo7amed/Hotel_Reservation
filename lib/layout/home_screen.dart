import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel/modules/login_screen.dart';
import 'package:hotel/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<String> branch = ['cairo' , 'minya' , 'sohag' , 'alix'];
  String? branchSelected = 'cairo';

  @override
  Widget build(BuildContext context) {
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
            onTap: (){
             navigateTo(context, LoginScreen());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Login',
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
      body: Column(
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
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: branchSelected,
                items: branch.map((item) => DropdownMenuItem<String>(
                    value: item,
                      child: Text(item,
                      style: const TextStyle(
                        fontSize: 18,
                      ),),
                  ),
                  ).toList(),
                  onChanged:(value) => branchSelected,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultButton(onPressed: (){}, text: 'Rooms status'),
                const SizedBox(width: 10,),
                defaultButton(onPressed: (){}, text: 'Book a room'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
