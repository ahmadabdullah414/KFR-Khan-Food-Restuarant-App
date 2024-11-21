import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kfr/about.dart';
import 'package:kfr/burger.dart';
import 'package:kfr/cart.dart';
import 'package:kfr/coffee.dart';
import 'package:kfr/coke.dart';
import 'package:kfr/contact.dart';
import 'package:kfr/donut.dart';
import 'package:kfr/fries.dart';
import 'package:kfr/home.dart';
import 'package:kfr/juice.dart';
import 'package:kfr/login.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';




class CartItem {
  final String name;
  final double price;
  final String image; // Add the image property
  int quantity; // Quantity for the cart item

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1, // Default quantity set to 1
  });
}




class CartIconButton extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final String itemImage;
  final Function addToCart; // Function to handle adding to cart

  const CartIconButton({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.itemImage,
    required this.addToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add_shopping_cart, color: Colors.amber),
      onPressed: () {
        addToCart(itemName, itemPrice, itemImage); // Call the addToCart function
      },
      tooltip: 'Add to cart',
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});


  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  List imageList = [
    {"id": 1, "image_path": 'assets/bur.png', 'page': const Burger()},
    {"id": 2, "image_path": 'assets/fry.png', 'page': const Fries()},
    {"id": 3, "image_path": 'assets/don.png', 'page': const Donut()},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  List<Map<String, dynamic>> cartItems = [];

  // Add item to cart function
  void addToCart(String itemName, double price) {
    setState(() {
      cartItems.add({
        'name': itemName,
        'price': price,
        'quantity': 1,
      });
    });

    // Optional Snackbar for feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$itemName added to cart!')),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 90),
              child: Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const MyHomePage()));
                  },
                  backgroundColor: Colors.transparent,
                  child: const Icon(Icons.arrow_back, color: Colors.amber),
                ),

              ),

            ),

          ],
        ),


        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Row(
            children: [
              PopupMenuButton<String>(
                color: Colors.black45,
                icon: const Icon(Icons.menu, size: 30, color: Colors.amber),
                position: PopupMenuPosition.under,
                offset: const Offset(0, 0),
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'home',
                    child: Text('Home',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white70)),
                  ),
                  const PopupMenuItem<String>(
                    value: 'menu',
                    child: Text('Menu',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.amber)),
                  ),
                  const PopupMenuItem<String>(
                    value: 'contact',
                    child: Text('Contact',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white)),
                  ),
                  const PopupMenuItem<String>(
                    value: 'about',
                    child: Text('About',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white)),
                  ),
                  const PopupMenuItem<String>(
                    value: 'log out',
                    child: Text('Log Out', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'home') {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                  } else if (value == 'menu') {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const MenuPage()));
                  } else if (value == 'contact') {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const ContactPage()));
                  } else if (value == 'about') {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const AboutPage()));
                  }
                  else if (value == 'log out') {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                  }
                },
              ),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                  },
                  child: const Text(
                    'KFR',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.amber),
                  ),
                ),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart, size: 30, color: Colors.amber),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Addtocart()));
                },
              ),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Ink(
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/back.png'),
                            fit: BoxFit.fitWidth),
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              final targetPage = imageList[currentIndex]['page'];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => targetPage));
                            },
                            child: CarouselSlider(
                              items: imageList
                                  .map(
                                    (item) => Image.asset(
                                  item['image_path'],
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                ),
                              )
                                  .toList(),
                              carouselController: carouselController,
                              options: CarouselOptions(
                                autoPlayAnimationDuration:
                                const Duration(milliseconds: 700),
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: true,
                                aspectRatio: 1,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imageList.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () {
                                    carouselController.animateToPage(entry.key);
                                  },
                                  child: Container(
                                    width: currentIndex == entry.key ? 17 : 7,
                                    height: 7.0,
                                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: currentIndex == entry.key
                                            ? Colors.amber
                                            : Colors.black45),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 40,),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(

                        children: [
                          Ink(

                            width:100,
                            height: 100,
                            decoration: BoxDecoration(


                              image: const DecorationImage(
                                image: AssetImage('assets/Fries2.png'), // Replace with your image path
                                fit: BoxFit.fitWidth, // Adjust the fit as needed
                              ),

                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  // Adjust the offset as needed
                                ),
                              ],
                            ),
                            child:   InkWell(
                              onTap: (){

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Fries()));

                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Fries()));


                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                  [
                                    Text('Fries',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.white)),

                              IconButton(
                                onPressed: () {
                                  // Add the selected item (Juice) with an image to the cart
                                  CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                                  cartProvider.addItem(CartItem(
                                    name: 'Fries',
                                    price: 1.99,
                                    image: 'assets/Fries2.png', // Add the image path here
                                  ));

                                  // Navigate to the Cart page after adding the item
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Addtocart()),
                                  );
                                },
                                icon: Icon(Icons.add_shopping_cart, color: Colors.amber),
                              )

                              ],
                                )),
                          ),

                        ],
                      ),
                      Column(
                        children: [
                          Ink(
                            width:100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/donut3.png',),
                                // Replace with your image path
                                fit: BoxFit.fitWidth, // Adjust the fit as needed
                              ),
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  // Adjust the offset as needed
                                ),
                              ],
                            ),
                            child:   InkWell(
                              onTap: (){

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Donut()));

                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Donut()));


                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                  [
                                    Text('Donut',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.white)),

                                    IconButton(
                                      onPressed: () {
                                        // Add the selected burger item to the cart
                                        CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                                        cartProvider.addItem(CartItem(name: 'Donut', price: 10.99, image: 'assets/donut3.png'));

                                        // Navigate to the Cart page after adding the item
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  Addtocart()),
                                        );
                                      },
                                      icon: Icon(Icons.add_shopping_cart, color: Colors.amber),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Ink(
                            width:100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/burger3.png'), // Replace with your image path
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),

                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  // Adjust the offset as needed
                                ),
                              ],
                            ),
                            child:   InkWell(
                              onTap: (){

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Burger()));

                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Burger()));


                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                  [
                                    Text('Burger',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.white)),

                                    IconButton(
                                      onPressed: () {
                                        // Add the selected burger item to the cart
                                        CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                                        cartProvider.addItem(CartItem(name: 'Burger', price: 5.99, image: 'assets/burger3.png'));

                                        // Navigate to the Cart page after adding the item
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  Addtocart()),
                                        );
                                      },
                                      icon: Icon(Icons.add_shopping_cart, color: Colors.amber),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 0,),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(

                        children: [
                          Ink(

                            width:100,
                            height: 100,
                            decoration: BoxDecoration(


                              image: const DecorationImage(
                                image: AssetImage('assets/coke.png'), // Replace with your image path
                                fit: BoxFit.fitWidth, // Adjust the fit as needed
                              ),

                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  // Adjust the offset as needed
                                ),
                              ],
                            ),
                            child:   InkWell(
                              onTap: (){

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Coke()));

                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Coke()));


                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                  [
                                    Text('Coke',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.white)),

                                    IconButton(
                                      onPressed: () {
                                        // Add the selected burger item to the cart
                                        CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                                          cartProvider.addItem(CartItem(name: 'Coke', price: 0.99, image: 'assets/coke.png'));

                                        // Navigate to the Cart page after adding the item
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  Addtocart()),
                                        );
                                      },
                                      icon: Icon(Icons.add_shopping_cart, color: Colors.amber),
                                    )
                                  ],
                                )),
                          ),

                        ],
                      ),
                      Column(
                        children: [
                          Ink(
                            width:100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/cofee.png',),
                                // Replace with your image path
                                fit: BoxFit.fitWidth, // Adjust the fit as needed
                              ),
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  // Adjust the offset as needed
                                ),
                              ],
                            ),
                            child:   InkWell(
                              onTap: (){

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Coffee()));

                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Coffee()));


                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                  [
                                    Text('Coffee',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.white)),

                                    IconButton(
                                      onPressed: () {
                                        // Add the selected burger item to the cart
                                        CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                                        cartProvider.addItem(CartItem(name: 'Coffee', price: 2.59, image: 'assets/cofee.png'));

                                        // Navigate to the Cart page after adding the item
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  Addtocart()),
                                        );
                                      },
                                      icon: Icon(Icons.add_shopping_cart, color: Colors.amber),
                                    )
                                  ],
                                )),
                          ), ],
                      ),
                      Column(
                        children: [
                          Ink(
                            width:100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/juice.png'), // Replace with your image path
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),

                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  // Adjust the offset as needed
                                ),
                              ],
                            ),
                            child:   InkWell(
                              onTap: (){

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Juice()));

                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Juice()));


                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                  [
                                    Text('Juice',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.white)),
                                    IconButton(
                                      onPressed: () {
                                        // Add the selected burger item to the cart
                                        CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                                        cartProvider.addItem(CartItem(name: 'Juice', price: 1.99, image: 'assets/juice.png',));

                                        // Navigate to the Cart page after adding the item
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) =>  Addtocart()),
                                        );
                                      },
                                      icon: Icon(Icons.add_shopping_cart, color: Colors.amber),
                                    )
                                  ],
                                )),
                          ),],
                      )
                    ],
                  ),
                ),

              ],
              ),
            ),
          ),
        )
    );
  }
}
