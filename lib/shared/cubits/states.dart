abstract class HotelStates {}

class HotelInitState extends HotelStates {}

class HotelBranchSelectedState extends HotelStates {}

class HotelRoomTypeSelectedState extends HotelStates{}

class HotelLoadingDatabaseState extends HotelStates{}

class HotelGetRoomsSuccessState extends HotelStates{}

class HotelGetRoomsErrorState extends HotelStates{
}

class HotelGetGustsSuccessState extends HotelStates{}
class HotelGetGustsErrorState extends HotelStates{}


class HotelAddGustsSuccessState extends HotelStates{}
class HotelAddGustsErrorState extends HotelStates{}

class HotelIsLoggedChangedState extends HotelStates{}

class HotelChangeGuestState extends HotelStates{}
class HotelGetBranchRoomsState extends HotelStates{}

class HotelUpdateRoomsSuccessState extends HotelStates{}
class HotelUpdateRoomsErrorState extends HotelStates{}

class HotelHaveSaleState extends HotelStates{}

class HotelUpdateBookedListState extends HotelStates{}
class HotelClearBookedListState extends HotelStates{}

class HotelUpdateAllCostState extends HotelStates{}

class HotelBranchImageSelectedState extends HotelStates{}