import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:price_tracker/domain/repository/tracker_repository.dart';
import 'package:price_tracker/presentation/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(trackerRepository: context.read<TrackerRepository>())
            ..add(HomeInitialEvent()),
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
              _title(),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: SvgPicture.asset('assets/image.svg'),
              ),
              const SizedBox(height: 20),
              Text(
                'Available Market',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const DerivDropdownBox(
                value: '',
                onChanged: print,
                items: [
                  DropdownMenuItem<dynamic>(
                    value: '',
                    child: Text('Select Market'),
                  ),
                  DropdownMenuItem<dynamic>(
                    value: 'forex',
                    child: Text('Forex'),
                  ),
                  DropdownMenuItem<dynamic>(
                    value: 'synthetic_index',
                    child: Text('Synthetic Indicies'),
                  ),
                  DropdownMenuItem<dynamic>(
                    value: 'indices',
                    child: Text('Stock & Indicies'),
                  ),
                  DropdownMenuItem<dynamic>(
                    value: 'cryptocurrency',
                    child: Text('Cryptocurrencies'),
                  ),
                  DropdownMenuItem<dynamic>(
                    value: 'basket_index',
                    child: Text('Basket Indicies'),
                  ),
                  DropdownMenuItem<dynamic>(
                    value: 'commodities',
                    child: Text('Commodities'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Symbols',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const DerivDropdownBox(
                value: '',
                items: [
                  DropdownMenuItem<dynamic>(
                    value: '',
                    child: Text('Select Symbols'),
                  ),
                ],
              ),
              const Spacer(),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return const CurrentPriceCard(
                    price: '1000',
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() => Center(
        child: RichText(
          text: TextSpan(
            text: 'Deriv',
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
      );
}
