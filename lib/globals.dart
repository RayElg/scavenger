import 'package:scavenger/dTypes.dart';

Function gamePageSetState;
Function mainSetState;
User currentUser;
MainMem memory = new MainMem();

setGamePageSetState(func) {
  gamePageSetState = func;
}

setMainSetState(func) {
  mainSetState = func;
}

setUser(user) {
  currentUser = user;
}
