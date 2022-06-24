import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:price_tracker/presentation/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(ConnectedEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return StreamBuilder<dynamic>(
                    stream: state.channel?.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        final data = jsonDecode(snapshot.data as String)
                            as Map<String, dynamic>;

                        print(data);
                        return const CurrentPriceCard(
                          price: '10000',
                        );
                      }
                      return const CurrentPriceCard(
                        isLoading: true,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
