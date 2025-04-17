import 'package:flutter/material.dart';

class CardTodo extends StatelessWidget {
  final int index;
  final String titleCard;
  final String time;
  final VoidCallback onTapRemove;
  final VoidCallback onTapDone;
  CardTodo({
    super.key,
    required this.index,
    required this.titleCard,
    required this.time,
    required this.onTapRemove,
    required this.onTapDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFFE3FBE8),
            child: Center(
              child: Text(
                time,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              titleCard,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: onTapDone,
                  child: Image.asset(
                    "assets/icons/checked.png",
                    height: 30,
                    width: 30,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onTapRemove,
                  child: Image.asset(
                    "assets/icons/remove.png",
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
