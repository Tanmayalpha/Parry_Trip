class FareRule {
  CANCELLATION? cANCELLATION;
  CANCELLATION? dATECHANGE;
  CANCELLATION? seatCharge;
  CANCELLATION? noShow;
  FareRule({this.cANCELLATION, this.dATECHANGE, this.noShow, this.seatCharge});

  FareRule.fromJson(Map<String, dynamic> json) {
    cANCELLATION = json['CANCELLATION'] != null
        ? new CANCELLATION.fromJson(json['CANCELLATION'])
        : null;
    dATECHANGE = json['DATECHANGE'] != null
        ? new CANCELLATION.fromJson(json['DATECHANGE'])
        : null;
    noShow = json['NO_SHOW'] != null
        ? new CANCELLATION.fromJson(json['NO_SHOW'])
        : null;
    seatCharge = json['SEAT_CHARGEABLE'] != null
        ? new CANCELLATION.fromJson(json['SEAT_CHARGEABLE'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cANCELLATION != null) {
      data['CANCELLATION'] = this.cANCELLATION!.toJson();
    }
    if (this.dATECHANGE != null) {
      data['DATECHANGE'] = this.dATECHANGE!.toJson();
    }
    return data;
  }
}

class CANCELLATION {
  DEFAULT? dEFAULT;

  CANCELLATION({this.dEFAULT});

  CANCELLATION.fromJson(Map<String, dynamic> json) {
    dEFAULT =
        json['DEFAULT'] != null ? new DEFAULT.fromJson(json['DEFAULT']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dEFAULT != null) {
      data['DEFAULT'] = this.dEFAULT!.toJson();
    }
    return data;
  }
}

class DEFAULT {
  double? amount;
  double? additionalFee;
  String? policyInfo;
  Fcs? fcs;

  DEFAULT({this.amount, this.additionalFee, this.policyInfo, this.fcs});

  DEFAULT.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    additionalFee = json['additionalFee'];
    if (json['policyInfo'].toString().contains("__nls__")) {
      List<String> value = json['policyInfo'].toString().split("__nls__");
      if (value.length > 0) {
        value[0] = "₹${json['amount']}+₹${json['additionalFee']}${value[0]}";
      }
      if (value.length > 1) {
        value[1] = "\n${value[1]}";
      }
      if (value.length > 2) {
        value[2] = "\n${value[2]}";
      }
      policyInfo = value.join(" ");
    } else {
      policyInfo = json['policyInfo'];
    }

    fcs = json['fcs'] != null ? new Fcs.fromJson(json['fcs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['additionalFee'] = this.additionalFee;
    data['policyInfo'] = this.policyInfo;
    if (this.fcs != null) {
      data['fcs'] = this.fcs!.toJson();
    }
    return data;
  }
}

class Fcs {
  double? aCFT;
  double? cCF;
  double? aCF;
  double? cCFT;

  Fcs({this.aCFT, this.cCF, this.aCF, this.cCFT});

  Fcs.fromJson(Map<String, dynamic> json) {
    aCFT = json['ACFT'];
    cCF = json['CCF'];
    aCF = json['ACF'];
    cCFT = json['CCFT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ACFT'] = this.aCFT;
    data['CCF'] = this.cCF;
    data['ACF'] = this.aCF;
    data['CCFT'] = this.cCFT;
    return data;
  }
}

class DFcs {
  double? cRFT;
  double? cRF;
  double? aRFT;
  double? aRF;

  DFcs({this.cRFT, this.cRF, this.aRFT, this.aRF});

  DFcs.fromJson(Map<String, dynamic> json) {
    cRFT = json['CRFT'];
    cRF = json['CRF'];
    aRFT = json['ARFT'];
    aRF = json['ARF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CRFT'] = this.cRFT;
    data['CRF'] = this.cRF;
    data['ARFT'] = this.aRFT;
    data['ARF'] = this.aRF;
    return data;
  }
}
