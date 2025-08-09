import 'dart:ui';
import 'package:flutter/material.dart';

// Define reusable colors for a cleaner codebase
const Color _darkPurpleBlue = Color(0xFF26147A);
const Color _lightPurplePink = Color(0xFF8C057C);
const Color _whiteWithOpacity = Color.fromRGBO(255, 255, 255, 0.7);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// A reusable widget to create the frosted glass effect
class FrostedGlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  FrostedGlassCard({required this.child, this.borderRadius = 20.0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// A reusable widget for the daily weather forecast cards
class WeatherCard extends StatelessWidget {
  final String day;
  final String temperature;
  final IconData icon;
  final bool showSun;

  WeatherCard({
    required this.day,
    required this.temperature,
    required this.icon,
    this.showSun = false,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedGlassCard(
      borderRadius: 25,
      child: Container(
        width: 70,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              temperature,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            // Use a Stack to layer the icons if a sun is needed
            Stack(
              alignment: Alignment.center,
              children: [
                if (showSun) // Conditionally show the sun icon
                  Positioned(
                    bottom: 8,
                    left: 2,
                    child: Icon(Icons.wb_sunny, color: Color(0xFFFDD835), size: 18),
                  ),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              day,
              style: TextStyle(
                color: _whiteWithOpacity,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A reusable widget for the detailed weather info cards
class WeatherInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;

  WeatherInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedGlassCard(
      borderRadius: 20,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: _whiteWithOpacity,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: _whiteWithOpacity,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _darkPurpleBlue,
              _lightPurplePink,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox to maintain spacing at the top
                SizedBox(height: 50),

                // Location and temperature
                Center(
                  child: Column(
                    children: [
                      Text(
                        'North America',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Max: 24°   Min:18°',
                        style: TextStyle(
                          color: _whiteWithOpacity,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                // 7-Days Forecasts
                Text(
                  '7-Days Forecasts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 20),

                // Weather forecast cards with navigation arrows
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.chevron_left, color: _whiteWithOpacity, size: 30),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherCard(day: 'Mon', temperature: '19°C', icon: Icons.cloudy_snowing),
                          WeatherCard(day: 'Tue', temperature: '18°C', icon: Icons.wb_cloudy_outlined, showSun: true),
                          WeatherCard(day: 'Wed', temperature: '18°C', icon: Icons.thunderstorm_outlined),
                          WeatherCard(day: 'Thu', temperature: '19°C', icon: Icons.sunny, showSun: true),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: _whiteWithOpacity, size: 30),
                  ],
                ),

                SizedBox(height: 30),

                // Air Quality section
                FrostedGlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.my_location, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'AIR QUALITY',
                              style: TextStyle(
                                color: _whiteWithOpacity,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          '3-Low Health Risk',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'See more',
                              style: TextStyle(
                                color: _whiteWithOpacity,
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: _whiteWithOpacity, size: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Sunrise and UV Index
                Row(
                  children: [
                    Expanded(
                      child: WeatherInfoCard(
                        icon: Icons.wb_sunny_sharp,
                        title: 'SUNRISE',
                        value: '5:28 AM',
                        subtitle: 'Sunset: 7:25PM',
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: WeatherInfoCard(
                        icon: Icons.wb_sunny_outlined,
                        title: 'UV INDEX',
                        value: '4',
                        subtitle: 'Moderate',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
