import 'package:flutter/material.dart';

import '../resources/resource.dart';

class BBSBaseUnderline extends StatelessWidget {
  final double width;

  const BBSBaseUnderline({super.key, required this.width});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      color: AppColors.grey,
      height: 1,
      width: width,
    ),
  );
}
