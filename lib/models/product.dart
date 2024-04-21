import 'package:hive/hive.dart';
part 'product.g.dart'; // Hive will generate this file

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  late int id = 0;

  @HiveField(1)
  final String barcode;

  @HiveField(2)
  final String name;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  final double price;

  Product(this.barcode, this.name, this.quantity, this.price);

  // Constructor to create a Product from a map (used for deserialization)
  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        barcode = map['barcode'],
        name = map['name'],
        quantity = map['quantity'],
        price = map['price'];

  // Method to convert Product to a map (used for serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
