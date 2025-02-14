import 'package:get/get.dart';
import 'package:omiga_ipl/constants/api.dart';
import 'package:omiga_ipl/models/fav_model.dart';

class FavoriteController extends GetxController {
  FavoritesModel? favorites;

  // Fetch favorites from API
  Future<void> fetchFavorites(context) async {
    favorites = await NetworkHelper().getFavorites(context: context);
    update(); // Update the UI when favorites list changes
  }

  // Toggle favorite and remove product if unfavorited
  Future<void> toggleFavorite(context, int productId) async {
    // Update wishlist status in the backend
    await NetworkHelper()
        .updateWishlistApi(context: context, productId: productId);

    // Remove the product from the list
    favorites!.data.removeWhere((product) => product.product.id == productId);

    update(); // Notify the UI of changes
  }
}
