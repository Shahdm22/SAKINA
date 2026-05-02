import 'package:flutter/material.dart';
import 'package:sakina/core/theme/app_colors.dart';

class PrivacySection extends StatelessWidget {
  final bool showProfileToPublic;
  final ValueChanged<bool> onToggle;

  const PrivacySection({
    super.key,
    required this.showProfileToPublic,
    required this.onToggle,
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
            'Privacy',
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
                'Show Profile to Public',
                style: TextStyle(
                  color: Color(0xFF1B1C1A),
                  fontSize: 14,
                  fontFamily: 'Manrope',
                ),
              ),
              Switch(
                value: showProfileToPublic,
                onChanged: onToggle,
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