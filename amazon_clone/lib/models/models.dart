

class ProductModels {
  final List<String> url;
  final String productname;
  final String uid;
  final String sellername;
  final String selleruid;
  final double? cost;
  final String description;
  final int? rating;
  final String? category;
  final int? quantity;
  final String? email;

  ProductModels(
      {required this.cost,
      required this.productname,
      required this.sellername,
      required this.selleruid,
      required this.uid,
      required this.url,
      required this.description,
      required this.rating,
      required this.category,
      required this.quantity,
      required this.email,
      });
  Map<String, dynamic> getJson() {
    return {
      'url': url,
      'productName': productname,
      'cost': cost,
      'uid': uid,
      'sellerName': sellername,
      'sellerUid': selleruid,
      'description': description,
      'rating': rating,
      'category': category,
      'quantity':quantity,
      'email':email,
    };
  }

  factory ProductModels.getModelFromJson({required Map<String?, dynamic> json}) {
  var urlList = json['url'];
  List<String> urls = urlList is List ? List<String>.from(urlList) : [];
    return ProductModels(
        cost: json["cost"],
        productname: json["productName"],
        sellername: json["sellerName"],
        selleruid: json["sellerUid"],
        uid: json["uid"],
        url: urls,
        description: json["description"],
        rating: json["rating"],
        category: json["category"],
        quantity: json["quantity"],
        email: json["email"]);
  }
}
