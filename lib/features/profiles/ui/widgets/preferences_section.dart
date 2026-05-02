import 'package:flutter/material.dart';
import 'package:sakina/features/profiles/ui/widgets/preference_card.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Preferences',
                style: TextStyle(
                  color: Color(0xFF120A00),
                  fontSize: 18,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Edit All',
                  style: TextStyle(
                    color: Color(0xFF9A8762),
                    fontSize: 13,
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: PreferenceCard(
                  icon: Icons.nightlight_outlined,
                  label: 'Schedule',
                  value: 'Night Owl',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: PreferenceCard(
                  icon: Icons.volume_off_outlined,
                  label: 'Noise Level',
                  value: 'Quiet',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}