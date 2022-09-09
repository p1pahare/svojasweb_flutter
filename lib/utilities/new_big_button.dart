import 'package:flutter/material.dart';

class BigButtonNew extends StatelessWidget {
  const BigButtonNew({Key? key, required this.ttitle, required this.onTap})
      : super(key: key);
  final String ttitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      height: 60,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 64, 128, 188),
          borderRadius: BorderRadius.circular(14)),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                ttitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
