import 'package:flutter/material.dart';
import 'package:kfr/about.dart';
import 'package:kfr/home.dart';
import 'package:kfr/login.dart';
import 'package:kfr/menu.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final String phoneNumber = "+923115548035"; // Replace with your WhatsApp number
  final String email = "ahmadtkd009@gmail.com"; // Replace with your email address
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0; // Star rating (0 to 5)
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

  // List to store reviews
  final List<Map<String, dynamic>> _reviews = [];

  // Function to launch WhatsApp
  void _launchWhatsApp(BuildContext context) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      _showErrorSnackBar(context, 'Could not open WhatsApp');
    }
  }

  // Function to launch email
  void _launchEmail(BuildContext context) async {
    final emailUrl = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Contact from KFR App&body=Hello, I would like to...',
    ).toString();

    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      _showErrorSnackBar(context, 'Could not open email app');
    }
  }

  // Function to show error
  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to handle submitting the review
  void _submitReview() {
    final comment = _commentController.text;
    if (comment.isEmpty || _rating == 0) {
      _showErrorSnackBar(context, 'Please enter a comment and give a rating');
      return;
    }

    // Add the review to the list
    setState(() {
      _reviews.add({'comment': comment, 'rating': _rating});
    });

    // Reset the form after submission
    _commentController.clear();
    setState(() {
      _rating = 0;
    });

    // Show a confirmation message
    const snackBar = SnackBar(content: Text('Review submitted successfully!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to build star rating widget
  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1; // Rating is 1-based, so add 1
            });
          },
        );
      }),
    );
  }

  // Function to display reviews
  Widget _buildReviewList() {
    return _reviews.isEmpty
        ? const Center(child: Text('No reviews yet', style: TextStyle(color: Colors.white)))
        : ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        final review = _reviews[index];
        return Card(
          color: Colors.black54,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Row(
              children: List.generate(
                5,
                    (starIndex) => Icon(
                  starIndex < review['rating'] ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(review['comment'], style: const TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
  }

  // Function to go to the cart page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30, top: 90),
        child: Align(
          alignment: Alignment.topLeft,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
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
              position: PopupMenuPosition.under,
              offset: const Offset(0, 0),
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
                  child: Text('Contact', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.amber)),
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
                } else if (value == 'log out') {
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
            )
          ],
        ),

        automaticallyImplyLeading: false,
      ),
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _opacity,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Contact Us via',
                  style: TextStyle(fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // WhatsApp Button
                ElevatedButton.icon(
                  onPressed: () => _launchWhatsApp(context),
                  icon: const Icon(Icons.chat_sharp, color: Colors.green, size: 30),
                  label: const Text('WhatsApp', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                ),
                const SizedBox(height: 20),

                // Email Button
                ElevatedButton.icon(
                  onPressed: () => _launchEmail(context),
                  icon: const Icon(Icons.email, color: Colors.blue, size: 30),
                  label: const Text('Email', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                ),
                const SizedBox(height: 40),

                // Comment Section
                const Text(
                  'Leave a Review',
                  style: TextStyle(fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Star Rating
                _buildStarRating(),

                // Comment Input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _commentController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write your review here...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                  child: const Text('Submit Review'),
                ),
                const SizedBox(height: 40),

                // Reviews List
                _buildReviewList(), // Display the review list
              ],
            ),
          ),
        ),
      ),
    );
  }
}
