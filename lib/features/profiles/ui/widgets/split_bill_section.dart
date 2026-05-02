import 'package:flutter/material.dart';
import 'package:sakina/core/theme/app_colors.dart';

class SplitBillSection extends StatelessWidget {
  final bool electricitySplit;
  final bool waterSplit;
  final ValueChanged<bool> onElectricityToggle;
  final ValueChanged<bool> onWaterToggle;

  const SplitBillSection({
    super.key,
    required this.electricitySplit,
    required this.waterSplit,
    required this.onElectricityToggle,
    required this.onWaterToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Split Bill',
            style: TextStyle(
              color: Color(0xFF120A00),
              fontSize: 18,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Electricity',
                style: TextStyle(
                  color: Color(0xFF1B1C1A),
                  fontSize: 14,
                  fontFamily: 'Manrope',
                ),
              ),
              Switch(
                value: electricitySplit,
                onChanged: onElectricityToggle,
                activeTrackColor: AppColors.fontColor,
                inactiveTrackColor: const Color(0xFFE4E2DF),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Water',
                style: TextStyle(
                  color: Color(0xFF1B1C1A),
                  fontSize: 14,
                  fontFamily: 'Manrope',
                ),
              ),
              Switch(
                value: waterSplit,
                onChanged: onWaterToggle,
                activeTrackColor: AppColors.fontColor,
                inactiveTrackColor: const Color(0xFFE4E2DF),
              ),
            ],
          ),
        ],
      ),
    );
  }
}