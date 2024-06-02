class Search_model {
  List<Result>? result;

  Search_model({this.result});

  Search_model.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? sId;
  String? productName;
  List<String>? productDescription;
  String? productImage;
  int? productPrice;
  String? categoryId;

  Result(
      {this.sId,
        this.productName,
        this.productDescription,
        this.productImage,
        this.productPrice,
        this.categoryId});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productDescription = json['productDescription'].cast<String>();
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['productImage'] = this.productImage;
    data['productPrice'] = this.productPrice;
    data['categoryId'] = this.categoryId;
    return data;
  }
}
