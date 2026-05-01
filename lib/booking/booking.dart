import 'package:flutter/material.dart';
import 'package:sakina/core/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roommate Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: const Color(0xFFF5EFE6),
      ),
      home: const SecureBookingScreen(),
    );
  }
}

class SecureBookingScreen extends StatefulWidget {
  const SecureBookingScreen({super.key});

  @override
  State<SecureBookingScreen> createState() => _SecureBookingScreenState();
}

class _SecureBookingScreenState extends State<SecureBookingScreen> {
  int _selectedPaymentMethod = 0;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'title': 'Credit or Debit Card',
      'icon': Icons.credit_card_outlined,
    },
    {
      'title': 'Fawry Pay',
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'title': 'Vodafone Cash',
      'icon': Icons.phone_android_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildCheckoutFlowLabel(),
                    const SizedBox(height: 16),
                    _buildTitle(),
                    const SizedBox(height: 20),
                    _buildRoomCard(),
                    const SizedBox(height: 20),
                    _buildPaymentMethodSection(),
                    const SizedBox(height: 16),
                    _buildSakinaProtection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF2C2416),
              size: 22,
            ),
          ),
          const Spacer(),
          const Text(
            'Roommate Chat',
            style: TextStyle(
              color: Color(0xFF2C2416),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 22), // Balancing the back button width
        ],
      ),
    );
  }

  Widget _buildCheckoutFlowLabel() {
    return Row(
      children: [
        Expanded(
          child: Container(height: 0.5, color: const Color(0xFF8B7355)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'CHECKOUT FLOW',
            style: TextStyle(
              color: const Color(0xFF8B7355),
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Container(height: 0.5, color: const Color(0xFF8B7355)),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Secure Booking',
      style: TextStyle(
        color: Color(0xFF2C2416),
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.1,
      ),
    );
  }

  Widget _buildRoomCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBeig,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room image + info
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  'https://images.weserv.nl/?url=www.thepinnaclelist.com/wp-content/uploads/2021/11/The-Perfect-Students-Room-Design.jpg',
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 130,
                    width: double.infinity,
                    color: const Color(0xFFD4C4A8),
                    child: const Icon(
                      Icons.apartment_outlined,
                      size: 60,
                      color: Color(0xFF8B7355),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SELECTED ROOM',
                  style: TextStyle(
                    color: const Color(0xFF8B7355),
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'The Nile Vista Suite',
                  style: TextStyle(
                    color: Color(0xFF2C2416),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Zamalek District, Cairo',
                  style: TextStyle(
                    color: Color(0xFF6B5A42),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 14),
                // Roommate match card
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFFD4C4A8),
                        backgroundImage: const NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1689565611422-b2156cc65e47?fm=jpg&q=60&w=3000&auto=format&fit=crop',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ROOMMATE MATCH',
                            style: TextStyle(
                              color: const Color(0xFF8B7355),
                              fontSize: 9,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Ahmed Mansour',
                            style: TextStyle(
                              color: Color(0xFF2C2416),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Icons.verified,
                                color: Color(0xFF4CAF50),
                                size: 13,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '98% Lifestyle Match',
                                style: TextStyle(
                                  color: const Color(0xFF4CAF50),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Monthly total
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly Total',
                          style: TextStyle(
                            color: const Color(0xFF8B7355),
                            fontSize: 11,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              '4,500',
                              style: TextStyle(
                                color: Color(0xFF2C2416),
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'EGP',
                              style: TextStyle(
                                color: const Color(0xFF6B5A42),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7E0B6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'PACKAGE: PREMIUM ELITE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PAYMENT METHOD',
          style: TextStyle(
            color: const Color(0xFF4C463C),
            fontSize: 14,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
            height: 1.43,
            letterSpacing: 1.40,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(_paymentMethods.length, (index) {
          final method = _paymentMethods[index];
          final isSelected = _selectedPaymentMethod == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedPaymentMethod = index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFF7E0B6)
                    : const Color(0xFFEAE8E5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isSelected ? const Color(0xFF8B7355) : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    method['icon'] as IconData,
                    color: const Color(0xFF1B1C1A),
                    size: 20,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    method['title'] as String,
                    style: const TextStyle(
                      color:Color(0xFF1B1C1A),
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2C2416)
                            : const Color(0xFFAA9880),
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF2C2416),
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSakinaProtection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE5D8),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: const Color(0xFF431102),
            width: 3,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_outlined,
            color: Color(0xFF431102),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SAKINA PROTECTION',
                  style: TextStyle(
                    color:  Color(0xFF431102),
                    fontSize: 14,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                    letterSpacing: -0.35,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your payment is held in escrow until 24 hours after move-in. Includes 24/7 security support and roommate mediation coverage.',
                  style: TextStyle(
                    color: const Color(0xFF733521),
                    fontSize: 14,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    height: 1.63,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: const BoxDecoration(
        color: Color(0xFFF5EFE6),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C2416),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Confirm and Pay',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 11,
                color: const Color(0xFF8B7355),
              ),
              const SizedBox(width: 4),
              Text(
                'ENCRYPTED WITH 256-BIT SSL SECURITY',
                style: TextStyle(
                  color: const Color(0xFF8B7355),
                  fontSize: 9,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
