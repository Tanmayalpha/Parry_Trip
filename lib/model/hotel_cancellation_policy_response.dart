class HotelCancellationPolicyResponse {
  String? id;
  CancellationPolicy? cancellationPolicy;
  Status? status;

  HotelCancellationPolicyResponse(
      {this.id, this.cancellationPolicy, this.status});

  HotelCancellationPolicyResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cancellationPolicy = json['cancellationPolicy'] != null
        ? new CancellationPolicy.fromJson(json['cancellationPolicy'])
        : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cancellationPolicy != null) {
      data['cancellationPolicy'] = this.cancellationPolicy!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class CancellationPolicy {
  String? id;
  bool? ifra;
  List<Pd>? pd;

  CancellationPolicy({this.id, this.ifra, this.pd});

  CancellationPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ifra = json['ifra'];
    if (json['pd'] != null) {
      pd = <Pd>[];
      json['pd'].forEach((v) {
        pd!.add(new Pd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ifra'] = this.ifra;
    if (this.pd != null) {
      data['pd'] = this.pd!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pd {
  String? fdt;
  String? tdt;
  double? am;

  Pd({this.fdt, this.tdt, this.am});

  Pd.fromJson(Map<String, dynamic> json) {
    fdt = json['fdt'];
    tdt = json['tdt'];
    am = json['am'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fdt'] = this.fdt;
    data['tdt'] = this.tdt;
    data['am'] = this.am;
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
