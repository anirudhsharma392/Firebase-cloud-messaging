
import 'package:mobx/mobx.dart';
part 'central_state.g.dart';

class CentralState = CentralStateBase with _$CentralState;

abstract class CentralStateBase with Store {
  ///All the central variables
  int gamesPlayed = 0;
  var uid;
  var user;
  String reason;
  String name;




  ///Reactive states only below

  @observable
  String date="";



}

final centralstate = CentralState();

