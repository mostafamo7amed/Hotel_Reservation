import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hotel/layout/home_screen.dart';
import 'package:hotel/shared/components/components.dart';

class LoginScreen extends StatelessWidget{
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 10,),
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
                      label: 'Name',
                      prefix: const Icon(Icons.account_circle_outlined),
                      controller: nameController,
                      validate: (value){
                        if(value!.isEmpty) {
                          return 'email can\'t be empty' ;
                        }
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      label: 'Phone',
                      prefix: const Icon(Icons.phone),
                      controller: phoneController,
                      validate: (value){
                        if(value!.isEmpty) {
                          return 'email can\'t be empty' ;
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
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(5)),
                        color: Colors.blue,
                      ),
                      child: MaterialButton(
                        child: ConditionalBuilder(
                          condition: true,
                          builder: (context) =>  const Text(
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
                          if(formKey.currentState!.validate()){
                            //logic
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
  }
}
