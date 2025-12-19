import 'package:flutter/material.dart';
import 'upload_car_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Listings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadCarScreen())),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('https://i.ibb.co/Nj1CzMJ/car.jpg', fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Honda Civic 2024", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("PKR 5,500,000", style: TextStyle(color: Colors.deepPurple)),
                      Text("Automatic | Petrol | Lahore", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
