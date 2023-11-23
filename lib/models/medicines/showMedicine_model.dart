class showMedicine_model {
  List<Medicines>? medicines;

  showMedicine_model({this.medicines});

  showMedicine_model.fromJson(Map<String, dynamic> json) {
    if (json['medicines'] != null) {
      medicines = <Medicines>[];
      json['medicines'].forEach((v) {
        medicines!.add(new Medicines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicines != null) {
      data['medicines'] = this.medicines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicines {
  int? id;
  String? name;
  String? dose;
  String? frequency;
  String? type;
  int? petId;

  Medicines(
      {this.id, this.name, this.dose, this.frequency, this.type, this.petId});

  Medicines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dose = json['dose'];
    frequency = json['frequency'];
    type = json['type'];
    petId = json['pet_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dose'] = this.dose;
    data['frequency'] = this.frequency;
    data['type'] = this.type;
    data['pet_id'] = this.petId;
    return data;
  }
}
