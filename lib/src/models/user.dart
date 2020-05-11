class User {
  String state;

  User();

  User.fromJson(Map<String,dynamic> jsonMap ){
   state = jsonMap['state'];
  }
}