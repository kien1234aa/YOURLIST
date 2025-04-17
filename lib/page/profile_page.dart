// import 'package:audioplayers/audioplayers.dart';
// import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';
// import 'package:yourlist1/model/user.dart';
// import 'package:yourlist1/util/color.dart';

// class ProfilePage extends StatefulWidget {
//   final User user;
//   const ProfilePage({super.key, required this.user});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final AudioPlayer _player = AudioPlayer();
//   int count = 0;
//   late ConfettiController _confettiController;

//   @override
//   void initState() {
//     super.initState();
//     _confettiController = ConfettiController(
//       duration: const Duration(seconds: 1),
//     );
//   }

//   @override
//   void dispose() {
//     _confettiController.dispose();
//     super.dispose();
//   }

//   void playSound() {
//     _player.play(AssetSource("sounds/sound1.mp3"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFDFFBE8),
//       body: Center(
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Container(
//               height: GetSize().getHeight(context) * 0.45,
//               width: GetSize().getWidth(context) * 0.8,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildMenuItem(Icons.access_time, widget.user.email),
//                     const SizedBox(height: 25),
//                     _buildMenuItem(Icons.lock_outline, "Change Password"),
//                     const SizedBox(height: 25),
//                     _buildMenuItem(Icons.logout, "Log out"),
//                     const SizedBox(height: 25),
//                     SizedBox(
//                       width: GetSize().getWidth(context) * 0.5,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           playSound();
//                           _confettiController.play();
//                           setState(() {
//                             count = count + 1;
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF2E7D32),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                         ),
//                         child: const Text(
//                           'Antendence',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: ConfettiWidget(
//                         confettiController: _confettiController,
//                         blastDirectionality: BlastDirectionality.explosive,
//                         shouldLoop: false,
//                         colors: const [
//                           Colors.green,
//                           Colors.blue,
//                           Colors.pink,
//                           Colors.orange,
//                           Colors.purple,
//                         ],
//                         numberOfParticles: 30,
//                         emissionFrequency: 0.05,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               top: -50,
//               left: GetSize().getWidth(context) * 0.8 / 3,
//               child: Row(
//                 children: [
//                   Image.asset(
//                     "assets/images/avatar.png",
//                     height: 100,
//                     width: 100,
//                   ),
//                   const SizedBox(width: 50),
//                   Column(
//                     children: [
//                       const Text("🔥", style: TextStyle(fontSize: 30)),
//                       Text(
//                         count.toString(),
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _buildMenuItem(IconData icon, String text) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//     decoration: BoxDecoration(
//       color: const Color(0xFFE1FBE4),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Row(
//       children: [
//         Icon(icon, color: Colors.black),
//         const SizedBox(width: 12),
//         Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
//         const Icon(Icons.arrow_forward_ios, size: 16),
//       ],
//     ),
//   );
// }
