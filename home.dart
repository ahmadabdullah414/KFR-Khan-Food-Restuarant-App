import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kfr/about.dart';
import 'package:kfr/burger.dart';
import 'package:kfr/cart.dart';
import 'package:kfr/contact.dart';
import 'package:kfr/donut.dart';
import 'package:kfr/fries.dart';
import 'package:kfr/login.dart';
import 'package:kfr/menu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final Completer<GoogleMapController> _mapController = Completer();

  final LatLng _restaurantLocation = const LatLng(37.7749, -122.4194); // Replace with your restaurant's coordinates
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // Replace with your restaurant's coordinates
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to animate the map
  Future<void> _animateToRestaurant() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: _restaurantLocation, zoom: 15.0),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                  child: Text('Home', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.amber)),
                ),
                const PopupMenuItem<String>(
                  value: 'menu',
                  child: Text('Menu', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                ),
                const PopupMenuItem<String>(
                  value: 'contact',
                  child: Text('Contact', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                ),
                const PopupMenuItem<String>(
                  value: 'about',
                  child: Text('About', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                ),
                const PopupMenuItem<String>(
                  value: 'log out',
                  child: Text('Log Out', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                ),
              ],
              onSelected: (value) {
                if (value == 'home') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                } else if (value == 'menu') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MenuPage()));
                } else if (value == 'contact') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ContactPage()));
                } else if (value == 'about') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AboutPage()));
                }
                else if (value == 'log out') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                }
              },
            ),
            Flexible(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                },
                child: const Text(
                  'KFR',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.amber),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, size: 30, color: Colors.amber),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Addtocart()));
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Background image or overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/Q.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Welcome To ',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                              Text(
                                'Khan Food Restaurant ',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Experience the best cuisine in town !',
                          style: TextStyle(fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Colors.white70,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Order your favorite meals in just a few taps, and enjoy the ultimate convenience of delicious food delivered straight to you!',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Featured Menu Section
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(
                        'Our Featured Items',
                        style: TextStyle(fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
    SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
    children: [
    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Burger()),
    );
    },
    child: _buildFeaturedItem('assets/burger5.png', 'Special Burger'),
    ),
    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Donut()),
    );
    },
    child: _buildFeaturedItem('assets/donut5.png', 'Delicious Donuts'),
    ),
    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Fries()),
    );
    },
    child: _buildFeaturedItem('assets/fries5.png', 'French Fries'),
    ),
    ]      ),
    ),
                const SizedBox(height: 30),
Center(
  child: TextButton(onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MenuPage()),
    );
  },
   child: const Column(
     children: [
       Text('Visit Menu',style: TextStyle(color:Colors.amber,fontWeight: FontWeight.bold,fontSize: 22,),),
     Icon(Icons.arrow_forward,color: Colors.amber,)
     ],
   ) ),
),
                // Map Section
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'Find Us Here',
                      style: TextStyle(fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 250,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                      initialCameraPosition: _initialPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId('restaurantLocation'),
                          position: _restaurantLocation,
                          infoWindow: const InfoWindow(title: 'KFR Restaurant'),
                        ),
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build featured items
  Widget _buildFeaturedItem(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
              image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
