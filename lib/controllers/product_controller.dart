import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../../models/product.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.put(ProductController());

  final Rx<List<Product>> _products = Rx<List<Product>>([]);
  List<Product> get products => _products.value.obs;
  final Rx<List<Product>> cartProducts = Rx<List<Product>>([]);
  var total = 0.0.obs;
  var isLoading = true.obs;
  final nameController = TextEditingController();

  void removeProduct(int index) {
    cartProducts.value.removeAt(index);
    Get.snackbar("Product Deleted", "Product Deleted Successfully");
    updateTotal();
    Get.reload();
  }

  void increaseQuantity(int index) {
    cartProducts.value[index].quantity += 1;
    updateTotal();
  }

  void decreaseQuantity(int index) {
    cartProducts.value[index].quantity -= 1;
    if (cartProducts.value[index].quantity == 0) {
      removeProduct(index);
    }
    updateTotal();
  }

  void updateTotal() {
    total.value = cartProducts.value
        .fold(0.0, (sum, product) => sum + product.price * product.quantity);
  }

  void addProductToCart(Product product) {
    _products.value.add(product);
    updateTotal();
  }

  String getProducts() {
    String products = "";
    for (int i = 0; i < cartProducts.value.length; i++) {
      products += "Product ${i + 1}:\n\n";
      products +=
          "Name : ${cartProducts.value[i].name}\tQuantity : ${cartProducts.value[i].quantity}\t Price : ${cartProducts.value[i].price}\n\n\n";
    }
    products += "Total Amount: ${total.value}\n";
    return products;
  }

  Future<bool> checkExisting(String barcode) async {
    var box = Hive.box<Product>('products');
    if (box.containsKey(barcode)) {
      Get.snackbar(
        'Product Exists',
        'The product with this barcode already exists.',
        backgroundColor: Colors.red, // You can customize this
        colorText: Colors.white, // You can customize this
      );
      return false;
    }
    return true;
  }

  Future<void> addProductToDB(Product product) async {
    var box = Hive.box<Product>('products');
    String customKey = product.barcode;

    await box.put(customKey, product);
  }

  Future<void> getProductByBarcode(String barcode) async {
    var box = Hive.box<Product>('products');

    Product? product = box.get(barcode);
    if (product != null) {
      int index = cartProducts.value.indexWhere((p) => p.barcode == barcode);
      if (index != -1) {
        increaseQuantity(index);
      } else {
        // Product not in cart, add with quantity 1
        product.quantity = 1;
        cartProducts.value.add(product);
      }
      updateTotal();
      cartProducts.update(update);
      update(); // Replaces Get.reload() for more targeted UI update
    }
  }
}

class ProductsException implements Exception {
  final String message;

  ProductsException(this.message);
}
