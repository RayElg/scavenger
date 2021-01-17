import 'package:scavenger/dTypes.dart';

Function gamePageSetState;
Function mainSetState;
Function mainEmptySetState;
User currentUser;
MainMem memory = new MainMem();
User u = new User("GUEST");

setGamePageSetState(func) {
  gamePageSetState = func;
}

setMainSetState(func) {
  mainSetState = func;
}

setUser(user) {
  currentUser = user;
}
