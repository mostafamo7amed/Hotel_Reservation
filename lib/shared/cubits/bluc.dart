import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/shared/cubits/states.dart';

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


  List<Widget> widgets =[

  ];
}