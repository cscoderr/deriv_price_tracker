import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:price_tracker/presentation/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Price',
                    style: GoogleFonts.ubuntu(
                      fontSize: 30,
                      color: const Color(0xFFFA2E3E),
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: 'Tracker',
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Available Market',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const DerivDropdownBox(),
              const SizedBox(height: 40),
              Text(
                'Symbols',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const DerivDropdownBox(),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 24,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Text('Current Price'),
                        Text(
                          '10000',
                          style: GoogleFonts.ubuntu(
                            fontSize: 30,
                            color: const Color(0xFFFA2E3E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_upward,
                      color: Color(0xFFFA2E3E),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
