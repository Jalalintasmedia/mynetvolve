class CustomerSummary {
  String accountNo;
  String accountName;
  String accountEmail;
  String accountHp;
  String accountAddress1;
  String accountAddress2;
  String emailVerified;
  String mobilePhoneVerified;
  String accountStatus;
  String accountBlockDate;
  String tIspId;
  String invoiceNo;
  String currentBalance;
  String description;
  String dueDate;
  String periodStartDate;
  String periodEndDate;
  String statementDate;
  String profileFileId;
  String pictExt;
  String pictType;
  String pictContent;
  bool activateFingerprint;

  CustomerSummary({
    required this.accountNo,
    required this.accountName,
    required this.accountEmail,
    required this.accountHp,
    required this.accountAddress1,
    required this.accountAddress2,
    required this.emailVerified,
    required this.mobilePhoneVerified,
    required this.accountStatus,
    required this.accountBlockDate,
    required this.tIspId,
    required this.invoiceNo,
    required this.currentBalance,
    required this.description,
    required this.dueDate,
    required this.periodEndDate,
    required this.periodStartDate,
    required this.statementDate,
    required this.profileFileId,
    required this.pictExt,
    required this.pictType,
    required this.pictContent,
    required this.activateFingerprint,
  });

  CustomerSummary.fromJson(Map<String?, dynamic> json, this.activateFingerprint)
      : accountNo = json['account_no'] ?? '',
        accountName = json['account_name'] ?? '',
        accountEmail = json['account_email'] ?? '',
        accountHp = json['account_hp'] ?? '',
        accountAddress1 = json['account_address_1'] ?? '',
        accountAddress2 = json['account_address_2'] ?? '',
        emailVerified = json['email_verified'] ?? '',
        mobilePhoneVerified = json['mobile_phone_verified'] ?? '',
        accountStatus = json['account_status'] ?? '',
        accountBlockDate = json['account_block_date'] ?? '',
        tIspId = json['t_isp_id'] ?? '',
        invoiceNo = json['invoice_no'] ?? '',
        currentBalance = json['current_balance'] ?? '',
        description = json['description'] ?? '',
        dueDate = json['due_date'] ?? '',
        periodEndDate = json['period_end_date'] ?? '',
        periodStartDate = json['period_start_date'] ?? '',
        statementDate = json['statement_date'] ?? '',
        profileFileId = json['profile_file_id'] ?? '',
        pictExt = json['pict_ext'] ?? '',
        pictType = json['pict_type'] ?? '',
        pictContent = json['pict_content'] ?? '';

  Map<String?, dynamic> toJson() => {
        'account_no': accountNo,
        'account_name': accountName,
        'account_email': accountEmail,
        'account_hp': accountHp,
        'account_address_1': accountAddress1,
        'account_address_2': accountAddress2,
        'email_verified': emailVerified,
        'mobile_phone_verified': mobilePhoneVerified,
        'invoice_no': invoiceNo,
        'current_balance': currentBalance,
        'description': description,
        'due_date': dueDate,
        'period_end_date': periodEndDate,
        'period_start_date': periodStartDate,
        'statement_date': statementDate,
        'profile_file_id': profileFileId,
        'pict_ext': pictExt,
        'pict_type': pictType,
        'pict_content': pictContent,
      };
}
