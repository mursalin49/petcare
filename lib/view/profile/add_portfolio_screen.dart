// Add Portfolio Screen
import 'package:flutter/material.dart' show BuildContext, Widget, StatelessWidget;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'add_edit_portfolio_base.dart';

class AddPortfolioScreen extends StatelessWidget {
  const AddPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioBaseScreen(
      title: 'Add Portfolio',
      buttonText: 'Publish',
      onAction: () {
        // Implement publish logic, then pop
        Get.back();
      },
    );
  }
}