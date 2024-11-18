class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  String? lessorName;

  CartItemModel(
      {required this.productId,
      this.image,
      this.price = 0.0,
      this.title = '',
      this.lessorName});

  //empty cart
  static CartItemModel empty() => CartItemModel(productId: '');
}
