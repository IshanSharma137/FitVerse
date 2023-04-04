class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? DateTime;
  String? dayno;
  String? CurlDay1;
  String? CurlDay2;
  String? CurlDay3;
  String? CurlDay4;
  String? CurlDay5;
  String? CurlDay6;
  String? CurlDay7;
  String? CrunchDay1;
  String? CrunchDay2;
  String? CrunchDay3;
  String? CrunchDay4;
  String? CrunchDay5;
  String? CrunchDay6;
  String? CrunchDay7;
  String? SquatDay1;
  String? SquatDay2;
  String? SquatDay3;
  String? SquatDay4;
  String? SquatDay5;
  String? SquatDay6;
  String? SquatDay7;

   


  

  UserModel({this.uid, this.email, this.firstName, this.lastName, this.DateTime, this.dayno, this.CurlDay1, this.CurlDay2,
            this.CurlDay3, this.CurlDay4, this.CurlDay5, this.CurlDay6, this.CurlDay7, this.CrunchDay1, this.CrunchDay2,
            this.CrunchDay3, this.CrunchDay4, this.CrunchDay5, this.CrunchDay6, this.CrunchDay7,this.SquatDay1, this.SquatDay2,
            this.SquatDay3, this.SquatDay4, this.SquatDay5, this.SquatDay6, this.SquatDay7});

  //data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      DateTime: map['DateTime'],
      dayno: map['dayno'],
      CurlDay1: map['CurlDay1'],
      CurlDay2: map['CurlDay2'],
      CurlDay3: map['CurlDay3'],
      CurlDay4: map['CurlDay4'],
      CurlDay5: map['CurlDay5'],
      CurlDay6: map['CurlDay6'],
      CurlDay7: map['CurlDay7'],
      CrunchDay1: map['CrunchDay1'],
      CrunchDay2: map['CrunchDay2'],
      CrunchDay3: map['CrunchDay3'],
      CrunchDay4: map['CrunchDay4'],
      CrunchDay5: map['CrunchDay5'],
      CrunchDay6: map['CrunchDay6'],
      CrunchDay7: map['CrunchDay7'],
      SquatDay1: map['SquatDay1'],
      SquatDay2: map['SquatDay2'],
      SquatDay3: map['SquatDay3'],
      SquatDay4: map['SquatDay4'],
      SquatDay5: map['SquatDay5'],
      SquatDay6: map['SquatDay6'],
      SquatDay7: map['SquatDay7'],
    );
  }

  

  Map<String, dynamic> toMap() {
    return { 
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'DateTime': DateTime,
      'dayno': dayno,
      'CurlDay1': CurlDay1,
      'CurlDay2': CurlDay2,
      'CurlDay3': CurlDay3,
      'CurlDay4': CurlDay4,
      'CurlDay5': CurlDay5,
      'CurlDay6': CurlDay6,
      'CurlDay7': CurlDay7,
      'CrunchDay1': CrunchDay1,
      'CrunchDay2': CrunchDay2,
      'CrunchDay3': CrunchDay3,
      'CrunchDay4': CrunchDay4,
      'CrunchDay5': CrunchDay5,
      'CrunchDay6': CrunchDay6,
      'CrunchDay7': CrunchDay7,
      'SquatDay1': SquatDay1,
      'SquatDay2': SquatDay2,
      'SquatDay3': SquatDay3,
      'SquatDay4': SquatDay4,
      'SquatDay5': SquatDay5,
      'SquatDay6': SquatDay6,
      'SquatDay7': SquatDay7,

    };
  }
}