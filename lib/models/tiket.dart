class Tiket {
  final String tTicketId;
  final String ticketNo;
  final String requestTypeDesc;
  final String statusDesc;
  final String startDate;
  final String startTime;
  final String closeDate;

  Tiket({
    required this.tTicketId,
    required this.ticketNo,
    required this.requestTypeDesc,
    required this.statusDesc,
    required this.startDate,
    required this.startTime,
    required this.closeDate,
  });

  Tiket.fromJson(Map<String?, dynamic> json)
      : tTicketId = json['t_ticket_id'] ?? '',
        ticketNo = json['ticket_no'] ?? '',
        requestTypeDesc = json['request_type_desc'] ?? '',
        statusDesc = json['status_desc'] ?? '',
        startDate = json['start_date'] ?? '',
        startTime = json['start_time'] ?? '',
        closeDate = json['close_date'] ?? '';
  
  Map<String?, dynamic> toJson() => {
    't_ticket_id': tTicketId,
    'ticket_no': ticketNo,
    'request_type_desc': requestTypeDesc,
    'status_desc': statusDesc,
    'start_date': startDate,
    'start_time': startTime,
    'close_date': closeDate,
  };
}