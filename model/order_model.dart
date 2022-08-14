class OrdersModel {
  OrdersModel({
    bool? success,
    String? message,
    List<Data>? data,}){
    _success = success;
    _message = message;
    _data = data;
  }

  OrdersModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Data>? _data;

  bool? get success => _success;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Data {
  Data({
    String? id,
    String? total,
    String? created_at,
    String? currency,
    String? image,
    Address? address,
    List<Items>? items,
   })
  {
    _id = id;
    _total = total;
    _created_at = created_at;
    _currency = currency;
    _image = image;
    _address = address;
    _items = items;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _total = json['total'];
    _created_at = json['created_at'];
    _currency = json['currency'];
    _image = json['image'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }
  String? _id;
  String? _total;
  String? _created_at;
  String? _currency;
  Address? _address;
  String? _image;
  List<Items>? _items;

  String? get id => _id;
  String? get total => _total;
  String? get created_at => _created_at;
  String? get image => _image;
  String? get currency => _currency;
  Address? get address => _address;
  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['total'] = _total;
    map['created_at'] = _created_at;
    map['currency'] = _currency;
    map['image'] = _image;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



class Items {
  Items({
    String? id,
    String? name,
    String? price,}){
    _id = id;
    _name = name;
    _price = price;
  }

  Items.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _price = json['price'];
  }
  String? _id;
  String? _name;
  String? _price;

  String? get id => _id;
  String? get name => _name;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    return map;
  }

}

class Address {
  Address({
    String? lat,
    String? lng,
  }){
    _lat = lat;
    _lng = lng;
  }

  Address.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }
  String? _lat;
  String? _lng;


  String? get lat => _lat;
  String? get lng => _lng;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }

}