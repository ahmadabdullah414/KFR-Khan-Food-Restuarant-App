import 'package:flutter/material.dart';
import 'package:kfr/cart.dart';
import 'package:kfr/contact.dart';
import 'package:kfr/home.dart';
import 'package:kfr/login.dart';
import 'package:kfr/menu.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  double _opacity = 0.0; // Opacity for the animation

  @override
  void initState() {
    super.initState();
    // Start the animation after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0; // Fade in
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: Padding(
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
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Row(
          children: [
            PopupMenuButton<String>(
              color: Colors.black45,
              icon: const Icon(Icons.menu, size: 30, color: Colors.amber),
              itemBuilder: (context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'home',
                  child: Text('Home', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white70)),
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
                  child: Text('About', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.amber)),
                ),
                const PopupMenuItem<String>(
                  value: 'log out',
                  child: Text('Log Out', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                ),
              ],
              onSelected: (value) {
                if (value == 'home') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                } else if (value == 'menu') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuPage()),
                  );
                } else if (value == 'contact') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactPage()),
                  );
                } else if (value == 'about') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                } else if (value == 'log out') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                }
              },
            ),
            Flexible(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  Addtocart()),
                );
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Text(
              'About Us',
              style: TextStyle(
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                'Welcome to KFR! we opened our doors to provide wholesome and delicious meals. Our commitment to using fresh ingredients and maintaining high hygiene standards has earned us a reputation for serving exceptional food. Join us for an unforgettable dining experience!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.white70,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            _buildImageCarousel(),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                'Our Story',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                'Founded in 2023, KFR has grown from a small local diner to one of the most beloved restaurants in the city. Our commitment to quality and innovation has made us a favorite among burger lovers.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.white70,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                'Find Us',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                'Located conveniently in front of Pak-Austria University, KFR was established to cater to the needs of students and the surrounding community.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.white70,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    final List<String> imageList = [
      'assets/R1.jpg',
      'assets/R2.jpg',
      'assets/R3.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
      ),
      items: imageList.map((item) => _buildCarouselItem(item)).toList(),
    );
  }

  Widget _buildCarouselItem(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
