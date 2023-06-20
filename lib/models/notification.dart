class CustNotification {
  final String tAccountId;
  final String requestDate;
  final String emailTo;
  final String subject;
  final String content;
  final String deviceToken;

  CustNotification({
    required this.tAccountId,
    required this.requestDate,
    required this.emailTo,
    required this.subject,
    required this.content,
    required this.deviceToken,
  });

  CustNotification.fromJson(Map<String?, dynamic> json)
      : tAccountId = json['t_sendmail_id'] ?? '',
        requestDate = json['request_date'] ?? '',
        emailTo = json['email_to'] ?? '',
        subject = json['subject'] ?? '',
        content = json['content'] ?? '',
        deviceToken = json['device_token'] ?? '';
  
  Map<String?, dynamic> toJson() => {
    't_sendmail_id': tAccountId,
    'request_date': requestDate,
    'subject': subject,
    'content': content,
    'device_token': deviceToken,
  };
}
