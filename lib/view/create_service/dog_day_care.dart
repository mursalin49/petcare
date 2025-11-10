import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class DogDayCareSetupScreen extends StatelessWidget {
  const DogDayCareSetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dog Day Care Setup', style: GoogleFonts.montserrat(color: Colors.white)), backgroundColor: AppColors.mainAppColor),
      body: Center(child: Text('Dog Day Care Page', style: GoogleFonts.montserrat())),
    );
  }
}