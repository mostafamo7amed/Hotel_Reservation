import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/layout/home_screen.dart';
import 'package:hotel/shared/components/components.dart';
import 'package:hotel/shared/cubits/bluc.dart';

import '../shared/cubits/states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<HotelCubit, HotelStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HotelCubit cubit = HotelCubit.getCubit(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30.6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'To get our great services',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          height: 45.0,
                          label: 'Name',
                          prefix: const Icon(Icons.account_circle_outlined),
                          controller: nameController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'email can\'t be empty';
                            }
                            return null;
                          },
                          type: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          height: 45.0,
                          label: 'Phone',
                          prefix: const Icon(Icons.phone),
                          controller: phoneController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'email can\'t be empty';
                            }
                            return null;
                          },
                          type: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 45,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadiusDirectional.all(Radius.circular(5)),
                            color: Colors.blue,
                          ),
                          child: MaterialButton(
                            child: ConditionalBuilder(
                              condition: true,
                              builder: (context) => const Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              fallback: (context) => const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print(nameController.text.toString());
                                cubit.setCurrentGuest(nameController.text.toString());
                                //change logged in bool
                                cubit.changeLoggedIn();
                                //navigate to question screen
                                navigateAndFinish(context, HomeScreen());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
