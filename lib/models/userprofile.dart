class User_profile {

  String user_name;
  String user_email;
  String user_phone;
  String user_add;
  String user_aadhar;


  User_profile(
      this.user_name,
      this.user_phone,
      this.user_email,
      this.user_aadhar,
      this.user_add
      );

  Map<String, dynamic> toJson() => {
    'Name': user_name,
    'Phone No.': user_phone,
    'Email': user_email,
    'DOB': user_aadhar,
    'Address': user_add,

  };
}
