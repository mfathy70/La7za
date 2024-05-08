import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/models/Cart.dart';
import 'package:shop_app/core/provider/cart_provider.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartProvider cartProvider = CartProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cartProvider.getCart(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.prograssiveDots(
                  color: kPrimaryColor, size: 100),
            ),
          );
        } else if (snapshot.hasData) {
          Cart cart = snapshot.data!;
          List<CartItem> cartItems = snapshot.data!.cartItems!;
          return Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  const Text(
                    "Your Cart",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "${cartItems.length} items",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(cartItems[index].id!),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      setState(() {
                        cartProvider.removeCartItem(cartItems[index].id!);
                        cartItems.removeAt(index);
                      });
                      Cart newCart = await cartProvider.getCart();
                      setState(() {
                        cart = newCart;
                      });
                    },
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(
                      cartItem: cartItems[index],
                      add: () async {
                        setState(() {
                          cartProvider.updateItemQuantity(cartItems[index].id!,
                              cartItems[index].quantity! + 1);
                        });
                        Cart newCart = await cartProvider.getCart();
                        setState(() {
                          cart = newCart;
                        });
                      },
                      remove: () async {
                        if (cartItems[index].quantity == 1) {
                          Fluttertoast.showToast(
                              msg: "Swipe left to remove product.");
                        } else {
                          setState(() {
                            cartProvider.updateItemQuantity(
                                cartItems[index].id!,
                                cartItems[index].quantity! - 1);
                          });
                          Cart newCart = await cartProvider.getCart();
                          setState(() {
                            cart = newCart;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CheckoutCard(
              cart: cart,
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Error !!!"),
            ),
          );
        }
      },
    );
  }
}
