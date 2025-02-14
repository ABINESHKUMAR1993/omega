import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/models/cart_model.dart';

class CartController extends GetxController {
  CartModel? cart;

  // Fetch Cart from API
  Future<void> fetchCart(context) async {
    cart = await NetworkHelper().getCart(context: context);
    update();
  }

  //Delete Cart
  Future<void> delCart(context, int cartId) async {
    await NetworkHelper().delCartApi(context: context, cartId: cartId);
    cart!.data.removeWhere((cart) => cart.id == cartId);
    fetchCart(context);
    update();
  }

  //Update cart
  Future<void> updateCart(context, int cartId, int qty) async {
    await NetworkHelper().updateCart(context: context, cartId: cartId, quantity: qty);
    // Update the local cart object after API call
    final cartItem = cart!.data.firstWhere((cart) => cart.id == cartId);
    cartItem.quantity = qty;
    fetchCart(context);
    update();
  }
}
