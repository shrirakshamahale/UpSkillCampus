import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'location_list_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.ytimg.com/vi/tx61kRUNfCE/maxresdefault.jpg',
            ), // Add your background image URL here
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Email input field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.black45,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 15),

                // Password input field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.black45,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),

                // Login button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Change to your preferred color
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationListPage(),
                      ),
                    );
                  },
                  child: Text('Login', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 15),

                // Sign up button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
