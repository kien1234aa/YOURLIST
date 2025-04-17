import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourlist1/page/home_page.dart';
import 'package:yourlist1/util/color.dart';
import 'package:audioplayers/audioplayers.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void playSound() {
    _audioPlayer.play(AssetSource("sounds/sound1.mp3")); // phát âm thanh
  }

  @override
  void completeStartScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    // chuyển sang HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GetColor().backgrouColor,
      body: Stack(
        alignment: Alignment.topCenter, // để pháo hoa ở giữa màn hình
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: GetSize().getWidth(context) * 1,
                  height: GetSize().getHeight(context) * 0.5,
                  child: Image.asset(
                    "assets/images/chatimage.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const Text(
                  "Prioritize\n your life",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    playSound();
                    completeStartScreen();
                  },
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: GetColor().buttonColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Icon(Icons.navigate_next_sharp, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 🎉 Phần pháo hoa được thêm vào đây
        ],
      ),
    );
  }
}
