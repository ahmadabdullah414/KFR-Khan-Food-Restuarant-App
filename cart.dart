import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kfr/menu.dart';
import 'package:kfr/cart_provider.dart'; // Make sure you have the CartProvider class here

class Addtocart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the CartProvider instance from the context
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black54,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 25, color: Colors.amber),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black54,
      body: cartProvider.cartItems.isEmpty
          ? const Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w900),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                CartItem item = cartProvider.cartItems[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(item.image, width: 50, height: 50, fit: BoxFit.cover), // Add the image here
                    title: Text(
                      item.name,
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    subtitle: Text(
                      'Price: \$${item.price}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Decrease quantity
                            if (item.quantity > 1) {
                              cartProvider.cartItems[index].quantity -= 1;
                            } else {
                              cartProvider.removeItem(item);
                            }
                            cartProvider.notifyListeners();
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          onPressed: () {
                            // Increase quantity
                            cartProvider.cartItems[index].quantity += 1;
                            cartProvider.notifyListeners();
                          },
                          icon: const Icon(Icons.add),
                        ),
                        IconButton(
                          onPressed: () {
                            // Remove the item from the cart
                            cartProvider.removeItem(item);
                            cartProvider.notifyListeners();
                          },
                          icon: const Icon(Icons.delete, color: Colors.red), // Add a delete icon here
                        ),
                      ],
                    ),
                  ),
                );


              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Proceed to checkout or order functionality
            },
            child: const Text('Checkout',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
          )
        ],
      ),
    );
  }
}
