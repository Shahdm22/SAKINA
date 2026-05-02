import 'package:flutter/material.dart';
import 'package:sakina/core/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String university;
  final String bio;
  final String imageUrl;
  final VoidCallback onEditPhoto;
  final VoidCallback onEditBio;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.university,
    required this.bio,
    required this.imageUrl,
    required this.onEditPhoto,
    required this.onEditBio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Profile picture ──────────────────────────────────────────────
        Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: onEditPhoto,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEAE8E5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _defaultAvatar(),
                        )
                      : _defaultAvatar(),
                ),
              ),
            ),
            // Camera button
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEditPhoto,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.fontColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Name ─────────────────────────────────────────────────────────
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFF120A00),
            fontSize: 24,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),

        // ── University ───────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school_outlined,
                color: Color(0xFF4C463C), size: 16),
            const SizedBox(width: 6),
            Text(
              university,
              style: const TextStyle(
                color: Color(0xFF4C463C),
                fontSize: 14,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Bio ──────────────────────────────────────────────────────────
        GestureDetector(
          onTap: onEditBio,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3F0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE0D8CC),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    bio.isNotEmpty ? bio : 'Tap to add your bio…',
                    style: TextStyle(
                      color: bio.isNotEmpty
                          ? const Color(0xFF4C463C)
                          : const Color(0xFF9A9088),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.edit_outlined,
                    size: 16, color: Color(0xFF9A8762)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _defaultAvatar() {
    return Container(
      color: const Color(0xFFDDD5C8),
      child: const Icon(
        Icons.person,
        size: 64,
        color: Color(0xFF9A9088),
      ),
    );
  }
}