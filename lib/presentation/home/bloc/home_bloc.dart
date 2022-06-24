import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:price_tracker/domain/models/models.dart';
import 'package:price_tracker/domain/repository/tracker_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required TrackerRepository trackerRepository})
      : _trackerRepository = trackerRepository,
        super(const HomeState()) {
    on<HomeInitialEvent>(_initial);
    on<SymbolsEvent>(_onGetSymbols);
    on<MarketChangeEvent>(_onMarketChanged);
    on<MarketSymbolEvent>(_onSymbolChanged);
    on<SymbolPriceEvent>(_onSymbolPriceChanged);
  }

  final TrackerRepository _trackerRepository;

  Future<void> _initial(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    _trackerRepository.symbols();
  }

  Future<void> _onSymbolChanged(
    MarketSymbolEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        symbol: event.symbol,
        status: HomeStatus.initial,
      ),
    );
    add(SymbolPriceEvent(event.symbol));
  }

  Future<void> _onSymbolPriceChanged(
    SymbolPriceEvent event,
    Emitter<HomeState> emit,
  ) async {}

  Future<void> _onMarketChanged(
    MarketChangeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        market: event.value,
        symbol: '',
        status: HomeStatus.initial,
      ),
    );
    add(SymbolsEvent(event.value));
  }

  Future<void> _onGetSymbols(
    SymbolsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await emit.forEach(
      _trackerRepository.marketSymbol(event.market),
      onData: (List<SymbolModel> data) => state.copyWith(
        symbols: data,
        status: HomeStatus.success,
      ),
      onError: (error, _) => state.copyWith(
        status: HomeStatus.failure,
      ),
    );
  }

  @override
  Future<void> close() {
    _trackerRepository.close();
    return super.close();
  }
}
