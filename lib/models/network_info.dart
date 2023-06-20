class NetworkInfo{
  final String accountStatus;
  final String deviceState;

  NetworkInfo({
    required this.accountStatus,
    required this.deviceState,
  });

  NetworkInfo.fromJson(Map<String?, dynamic> json)
      : accountStatus = json['account_status'],
        deviceState = json['device_state'];

  Map<String?, dynamic> toJson() => {
    'account_status': accountStatus,
    'device_state': deviceState,
  };
}