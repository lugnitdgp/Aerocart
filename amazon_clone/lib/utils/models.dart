class ProductModels {
  final String url;
  final String productname;
  final String uid;
  final String sellername;
  final String selleruid;
  final double cost;
  final String description;

  ProductModels(
      {required this.cost,
      required this.productname,
      required this.sellername,
      required this.selleruid,
      required this.uid,
      required this.url,
      required this.description});
  Map<String, dynamic> getJson() {
    return {
      'url': url,
      'productName': productname,
      'cost': cost,
      'uid': uid,
      'sellerName': sellername,
      'sellerUid': selleruid,
      'description': description,
    };
  }

  factory ProductModels.getModelFromJson({required Map<String?, dynamic> json}) {
    return ProductModels(
        cost: json["cost"],
        productname: json["productName"],
        sellername: json["sellerName"],
        selleruid: json["sellerUid"],
        uid: json["uid"],
        url: json["url"],
        description: json["description"]);
  }
}
