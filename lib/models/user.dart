class User {
  String? accountNo;
  String? tAccountId;
  String? name;
  String? address;
  String? email;
  String? mobilePhone;
  String? locationName;
  String? isValid;
  String? blockDate;
  String? closeDate;
  String? registrationDate;
  String? status;

  User({
    required this.accountNo,
    required this.tAccountId,
    required this.name,
    required this.address,
    required this.email,
    required this.mobilePhone,
    required this.locationName,
    required this.isValid,
    required this.blockDate,
    required this.closeDate,
    required this.registrationDate,
    required this.status,
  });

  // User.fromJson(Map<String?, dynamic> json)
  //     : accountNo = json['account_no'] ?? '',
  //       password = json['password'] ?? '';

  // Map<String?, dynamic> toJson() => {
  //       'account_no': accountNo,
  //       'password': password,
  //     };
}

// class UserData with ChangeNotifier {
//   User _user = User(accountNo: null, tAccountId: null, name: null, address: null, email: null, mobilePhone: null, locationName: null, isValid: null, blockDate: null, closeDate: null, registrationDate: null, status: null);

//   User get user {
//     return _user;
//   }

//   void getUserData() {
    
//   }
// }