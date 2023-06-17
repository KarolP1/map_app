import 'package:flutter/material.dart';
import 'package:map_app/components/appbar.dart';
import 'package:map_app/pages/home_page.dart';
import 'package:map_app/themes/color_theme.dart';
import 'package:map_app/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String? token;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    // Retrieve token from shared preferences or any other storage method
    // and update the `token` variable using `setState`
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(
      'token',
    );

    // Once the token is retrieved, call `checkTokenValidity`
    if (token != null) {
      // ignore: use_build_context_synchronously
      checkTokenValidity(context, token!);
    }
  }

  Future<void> checkTokenValidity(BuildContext context, String token) async {
    final url =
        Uri.parse('https://traveltracker-fd76983cfda0.herokuapp.com/check');
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await http.post(url, headers: headers);
      print(response.statusCode);

      if (response.statusCode == 201) {
        // Token is valid
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Token is invalid
      }
    } catch (error) {
      print('Failed to check token validity: $error');
      // Error occurred during the request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const MyAppBar(),
        backgroundColor: ColorTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: ColorTheme.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Travel Tracker!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: ColorTheme.textColor,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Explore the World and Track Your Journeys',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: ColorTheme.textColor,
                ),
              ),
              const SizedBox(height: 32.0),
              Image.asset(
                'assets/images/map_image.png',
                height: 200.0,
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Travel Tracker is your ultimate travel companion. Whether you\'re an avid globetrotter or an occasional explorer, this app is designed to help you keep track of the places you\'ve been and create your own personalized map.',
                style: TextStyle(
                  fontSize: 18.0,
                  color: ColorTheme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Key Features:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: ColorTheme.textColor,
                ),
              ),
              const SizedBox(height: 16.0),
              // Feature 1
              _buildFeatureWidget(
                icon: Icons.pin_drop,
                title: 'Add Points to Your Map',
                description:
                    'Easily add points to your map by tapping on any location you\'ve visited. Mark your favorite spots and memorable experiences.',
              ),
              const SizedBox(height: 16.0),
              // Feature 2
              _buildFeatureWidget(
                icon: Icons.collections,
                title: 'Create Personalized Annotations',
                description:
                    'Customize your points with personalized annotations. Add titles, descriptions, and attach photos to create a rich visual diary of your adventures.',
              ),
              const SizedBox(height: 16.0),
              // Feature 3
              _buildFeatureWidget(
                icon: Icons.sync,
                title: 'Sync Across Devices',
                description:
                    'Your map data is securely backed up and synchronized across multiple devices, ensuring you can access your journey history wherever you go.',
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48.0,
                      vertical: 16.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    backgroundColor: ColorTheme.primaryColor),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.buttonTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureWidget({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 48.0,
          color: ColorTheme.primaryColor,
        ),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ColorTheme.textColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16.0,
            color: ColorTheme.textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
