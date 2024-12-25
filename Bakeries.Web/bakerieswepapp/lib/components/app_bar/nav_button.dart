import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String title;
  final Widget route;
  final bool isSelected;

  const NavButton({
    Key? key,
    required this.title,
    required this.route,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => route,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child;
            },
            transitionDuration: Duration.zero,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.brown[200] : Colors.brown[400],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}