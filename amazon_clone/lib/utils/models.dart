class ProductModels {
  final String url;
  final String productname;
  final String uid;
  final String sellername;
  final String selleruid;
  final double cost;

  ProductModels(
      {required this.cost,
      required this.productname,
      required this.sellername,
      required this.selleruid,
      required this.uid,
      required this.url});
}
