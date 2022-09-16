import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required Icon prefix,
  required validate,
  required TextInputType type,
  suffix,
  pressedShow,
  onTap,
  onSubmit,
  onChange,
  bool isPassword = false,
}) =>
    Container(
      height: 40,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        onTap: onTap,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefix,
          suffixIcon: suffix != null
              ? IconButton(
            icon: suffix,
            onPressed: pressedShow,
          )
              : null,
          border: const OutlineInputBorder(),
        ),
        validator: validate,
        keyboardType: type,
      ),
    );

Widget defaultButton({
  required onPressed,
  required String text,
  width,
  bool toUpperCase = false,
}) =>
    Container(
      height: 45,
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.all(Radius.circular(5)),
        color: Colors.blue,
      ),
      child: MaterialButton(
        onPressed: onPressed,
       
        child: Text(
          toUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );

Future navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

Future navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) => false);

Future<bool?> toast({
  required String message,
  required ToastStates data,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeToastColor(data),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  success,
  error,
  warning,
}

Color changeToastColor(ToastStates data) {
  Color color;
  switch (data) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget singleWidget({
  required nameController1 ,
}) =>Padding(
  padding: const EdgeInsets.all(15),
  child:   Column(
    children: [
      Row(
        children: [
          Text('Guest name : ',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      SizedBox(height: 10,),
      defaultFormField(
          controller: nameController1,
          label: 'Name',
          prefix: Icon(Icons.person),
          validate: (value){
            if(value!.isEmpty) {
              return 'name can\'t be empty' ;
            }
            return null;
          },
          type: TextInputType.name),
    ],
  ),
);



Widget doubleWidget({
  required nameController1 ,
  required nameController2 ,
}) =>Padding(
  padding: const EdgeInsets.all(15),
  child:   Column(
    children: [
      Row(
        children: [
          Text('Guest name : ',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      SizedBox(height: 10,),
      defaultFormField(
          controller: nameController1,
          label: 'Name',
          prefix: Icon(Icons.person),
          validate: (value){
            if(value!.isEmpty) {
              return 'name can\'t be empty' ;
            }
            return null;
          },
          type: TextInputType.name),
      SizedBox(height: 10,),
      defaultFormField(
          controller: nameController2,
          label: 'Name',
          prefix: Icon(Icons.person),
          validate: (value){
            if(value!.isEmpty) {
              return 'name can\'t be empty' ;
            }
            return null;
          },
          type: TextInputType.name),
    ],
  ),
);


Widget suitWidget({
  required nameController1 ,
  required nameController2 ,
  required nameController3 ,
}) =>Padding(
  padding: const EdgeInsets.all(15),
  child:   Column(
    children: [
      Row(
        children: [
          Text('Guest name : ',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      SizedBox(height: 10,),
      defaultFormField(
          controller: nameController1,
          label: 'Name',
          prefix: Icon(Icons.person),
          validate: (value){
            if(value!.isEmpty) {
              return 'name can\'t be empty' ;
            }
            return null;
          },
          type: TextInputType.name),
      SizedBox(height: 10,),
      defaultFormField(
          controller: nameController2,
          label: 'Name',
          prefix: Icon(Icons.person),
          validate: (value){
            if(value!.isEmpty) {
              return 'name can\'t be empty' ;
            }
            return null;
          },
          type: TextInputType.name),
      SizedBox(height: 10,),
      defaultFormField(
          controller: nameController3,
          label: 'Name',
          prefix: Icon(Icons.person),
          validate: (value){
            if(value!.isEmpty) {
              return 'name can\'t be empty' ;
            }
            return null;
          },
          type: TextInputType.name),
    ],
  ),
);


