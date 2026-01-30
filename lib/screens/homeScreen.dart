import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Map<String, dynamic>> gods = [
    {"name": "Ganesh", "image": "assets/images/Ganesh.png"},
    {"name": "Shiva", "image": "assets/images/Shiva.png"},
    {"name": "Krishna", "image": "assets/images/Krishna.png"},
    {"name": "Durga", "image": "assets/images/Durga.png"},
    {"name": "Hanuman", "image": "assets/images/Hanuman.png"},
    {"name": "Lakshmi", "image": "assets/images/Lakshmi.png"},
    {"name": "Saraswati", "image": "assets/images/Saraswati.png"},
    {"name": "Vishnu", "image": "assets/images/Vishnu.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB74D),

      drawer: Drawer(
        backgroundColor: const Color(0xFF090908),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFF3E0), Color(0xFFFFB74D)],
                ),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xFFB8860B),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Devotee",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),
            const Divider(color: Colors.white30),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Arthigranth v1.0",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: const Color(0xFF6D4C41),
        title: const Text(
          "Arthigranth",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemCount: gods.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          return LuxuryCard(
            name: gods[index]["name"],
            imagePath: gods[index]["image"],
          );
        },
      ),
    );
  }
}

class LuxuryCard extends StatefulWidget {
  final String name;
  final String imagePath;

  const LuxuryCard({super.key, required this.name, required this.imagePath});

  @override
  State<LuxuryCard> createState() => _LuxuryCardState();
}

class _LuxuryCardState extends State<LuxuryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 4, end: 15).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _pressed ? 0.95 : 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFFFFD700), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withOpacity(0.6),
                    blurRadius: _glowAnimation.value,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                    ),

                    // ✨ SHIMMER SWEEP
                    Positioned.fill(
                      child: Shimmer.fromColors(
                        baseColor: Colors.transparent,
                        highlightColor: const Color(
                          0xFFFFD700,
                        ).withOpacity(0.35),
                        direction: ShimmerDirection.ltr,
                        period: const Duration(seconds: 5),
                        child: Container(color: Colors.white),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 70,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black87],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
