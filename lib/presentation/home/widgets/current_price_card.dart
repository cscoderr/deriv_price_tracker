import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    this.ask = '0',
    this.bid = '0',
    this.position = CurrentPosition.neutral,
  }) : super(key: key);

  final String? price;
  final bool isLoading;
  final CurrentPosition position;
  final String ask;
  final String bid;
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
          ? Center(
              child: Platform.isAndroid
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Color(0xFFFA2E3E),
                        strokeWidth: 2,
                      ),
                    )
                  : const CupertinoActivityIndicator(),
            )
          : Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Price',
                          style: GoogleFonts.ubuntu(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              price ?? '',
                              style: GoogleFonts.ubuntu(
                                fontSize: 30,
                                color: position.color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (position == CurrentPosition.neutral)
                              Container()
                            else if (position == CurrentPosition.high)
                              Icon(
                                Icons.arrow_upward,
                                color: position.color,
                              )
                            else
                              Icon(
                                Icons.arrow_downward,
                                color: position.color,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ask',
                          style: GoogleFonts.ubuntu(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ask,
                          style: GoogleFonts.ubuntu(
                            fontSize: 16,
                            color: const Color(0xFF219653),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        Text(
                          'Bid',
                          style: GoogleFonts.ubuntu(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          bid,
                          style: GoogleFonts.ubuntu(
                            fontSize: 14,
                            color: const Color(0xFFFA2E3E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
