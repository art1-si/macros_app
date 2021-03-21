import 'dart:async';
import 'package:mcr/db/user_db_provider.dart';
import 'package:mcr/models/user_model.dart';

class UserBloc  {
  UserDatabase db = UserDatabase();


  final _user = StreamController<List<UserModel>>.broadcast();



  Stream<List<UserModel>> get userList => _user.stream;
  StreamSink<List<UserModel>> get toUserList => _user.sink;


  UserBloc(){

    _addUserToStream();
  }



  

  void _addUserToStream()async{
    List<UserModel> s = <UserModel>[];
    List products = await db.getTotalsFromDb();
    products.forEach((product){
      s.add(UserModel.map(product));
    });
    toUserList.add(s);
    print(" user stream has!!!!! $s");
  }
  

  void dispose(){
    _user.close();
  }
}