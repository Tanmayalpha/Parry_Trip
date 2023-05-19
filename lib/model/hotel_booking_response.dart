class HotelBookingResponse {
  String? bookingId;
  Status? status;

  HotelBookingResponse({this.bookingId, this.status});

  HotelBookingResponse.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class Status {
  bool? success;
  int? httpStatus;

  Status({this.success, this.httpStatus});

  Status.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    httpStatus = json['httpStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['httpStatus'] = this.httpStatus;
    return data;
  }
}
