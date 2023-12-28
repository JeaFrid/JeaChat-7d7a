import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/color.dart';

class LogoChat extends StatelessWidget {
  const LogoChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        "JeaChat",
        style: GoogleFonts.rubik(
          color: JeaColor.textColor,
          fontSize: 30,
        ),
      ),
    );
  }
}
