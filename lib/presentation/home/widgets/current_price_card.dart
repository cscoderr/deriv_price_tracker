import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum CurrentPosition {
  low(Color(0xFFFA2E3E)),
  high(Color(0xFF219653)),
  neutral(Colors.grey);

  const CurrentPosition(this.color);

  final Color color;
}

class CurrentPriceCard extends StatelessWidget {
  const CurrentPriceCard({
    Key? key,
    this.price,
    this.isLoading = false,
    this.percentage = '0',
    this.position = CurrentPosition.neutral,
  }) : super(key: key);

  final String? price;
  final bool isLoading;
  final CurrentPosition position;
  final String percentage;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: isLoading
          ? const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Color(0xFFFA2E3E),
                  strokeWidth: 2,
                ),
              ),
            )
          : Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current Price'),
                    Text(
                      price ?? '',
                      style: GoogleFonts.ubuntu(
                        fontSize: 30,
                        color: position.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: position.color,
                    ),
                    Text(
                      '$percentage%',
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: position.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
