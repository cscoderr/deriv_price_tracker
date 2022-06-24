import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:price_tracker/domain/repository/tracker_repository.dart';
import 'package:price_tracker/presentation/home/bloc/price_bloc.dart';
import 'package:price_tracker/presentation/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomeBloc(trackerRepository: context.read<TrackerRepository>())
                ..add(HomeInitialEvent()),
        ),
        BlocProvider(
          create: (context) => PriceBloc(
            trackerRepository: context.read<TrackerRepository>(),
          ),
        ),
      ],
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  double prevPrice = 0;

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
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return DerivDropdownBox(
                    value: state.market,
                    onChanged: (dynamic value) => context
                        .read<HomeBloc>()
                        .add(MarketChangeEvent(value.toString())),
                    items: [
                      const DropdownMenuItem<dynamic>(
                        value: '',
                        child: Text('Select Market'),
                      ),
                      ...state.markets
                          .map(
                            (e) => DropdownMenuItem<dynamic>(
                              value: e.key,
                              child: Text(e.title!),
                            ),
                          )
                          .toList()
                    ],
                  );
                },
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
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  if (state.status == HomeStatus.loading) {
                    return const DerivDropdownBox(
                      value: '',
                      items: [
                        DropdownMenuItem<dynamic>(
                          value: '',
                          child: Text('Loading...'),
                        ),
                      ],
                    );
                  } else if (state.status == HomeStatus.failure) {
                    return DerivDropdownBox(
                      value: '',
                      items: [
                        DropdownMenuItem<dynamic>(
                          value: '',
                          child: Text(
                            'An error occur',
                            style: GoogleFonts.ubuntu(
                              color: const Color(0xFFFA2E3E),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return DerivDropdownBox(
                    value: state.symbol,
                    isEnabled: state.symbols.isNotEmpty,
                    onChanged: (dynamic value) {
                      context
                          .read<HomeBloc>()
                          .add(MarketSymbolEvent(value.toString()));
                      context
                          .read<PriceBloc>()
                          .add(GetPriceEvent(value.toString()));
                    },
                    items: [
                      const DropdownMenuItem<dynamic>(
                        value: '',
                        child: Text('Select Symbols'),
                      ),
                      ...state.symbols
                          .map(
                            (e) => DropdownMenuItem<dynamic>(
                              value: e.symbol,
                              child: Text(e.displayName!),
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
              ),
              const Spacer(),
              BlocBuilder<PriceBloc, PriceState>(
                builder: (context, state) {
                  if (state is PriceSuccess) {
                    final price = state.price.tick?.quote ?? 0.0;
                    final isNeutral = prevPrice == price;
                    final hasDecrease = prevPrice > price;
                    prevPrice = state.price.tick?.quote ?? 0.0;
                    return CurrentPriceCard(
                      price: _formattedPrice(state.price.tick?.quote ?? 0.0),
                      position: isNeutral
                          ? CurrentPosition.neutral
                          : hasDecrease
                              ? CurrentPosition.low
                              : CurrentPosition.high,
                      ask: _formattedPrice(state.price.tick?.ask ?? 0),
                      bid: _formattedPrice(state.price.tick?.bid ?? 0),
                    );
                  } else if (state is PriceFailure) {
                    return Center(
                      child: Text(
                        state.error,
                        style: GoogleFonts.ubuntu(
                          color: const Color(0xFFFA2E3E),
                          fontSize: 20,
                        ),
                      ),
                    );
                  } else if (state is PriceInitial) {
                    return Container();
                  }
                  return const CurrentPriceCard(
                    isLoading: true,
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

  String _formattedPrice(double price) =>
      NumberFormat.simpleCurrency(name: '').format(price);

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
