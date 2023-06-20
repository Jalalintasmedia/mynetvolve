class Customersmry {
  String accountNo;
  String accountName;
  String accountEmail;
  String accountHp;
  String accountAddress1;
  String accountAddress2;
  String emailVerified;
  String invoiceNo;
  String currentBalance;
  String description;
  String dueDate;
  String periodStartDate;
  String periodEndDate;
  String statementDate;
  bool activateFingerprint;

  Customersmry({
    required this.accountNo,
    required this.accountName,
    required this.accountEmail,
    required this.accountHp,
    required this.accountAddress1,
    required this.accountAddress2,
    required this.emailVerified,
    required this.invoiceNo,
    required this.currentBalance,
    required this.description,
    required this.dueDate,
    required this.periodEndDate,
    required this.periodStartDate,
    required this.statementDate,
    required this.activateFingerprint,
  });

  Customersmry.fromJson(Map<String?, dynamic> json, this.activateFingerprint)
      : accountNo = json['account_no'] ?? '',
        accountName = json['account_name'] ?? '',
        accountEmail = json['account_email'] ?? '',
        accountHp = json['account_hp'] ?? '',
        accountAddress1 = json['account_address_1'] ?? '',
        accountAddress2 = json['account_address_2'] ?? '',
        emailVerified = json['email_verified'] ?? '',
        invoiceNo = json['invoice_no'] ?? '',
        currentBalance = json['current_balance'] ?? '',
        description = json['description'] ?? '',
        dueDate = json['due_date'] ?? '',
        periodEndDate = json['period_end_date'] ?? '',
        periodStartDate = json['period_start_date'] ?? '',
        statementDate = json['statement_date'] ?? '';
  
  Map<String?, dynamic> toJson() => {
    'account_no': accountNo,
    'account_name': accountName,
    'account_email': accountEmail,
    'account_hp': accountHp,
    'account_address_1': accountAddress1,
    'account_address_2': accountAddress2,
    'email_verified': emailVerified,
    'invoice_no': invoiceNo,
    'current_balance': currentBalance,
    'description': description,
    'due_date': dueDate,
    'period_end_date': periodEndDate,
    'period_start_date': periodStartDate,
    'statement_date': statementDate,
  };
}
