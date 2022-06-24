import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:price_tracker/domain/models/models.dart';
import 'package:price_tracker/domain/repository/tracker_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required TrackerRepository trackerRepository})
      : _trackerRepository = trackerRepository,
        super(const HomeState()) {
    on<HomeInitialEvent>(_initial);
    on<SymbolsEvent>(_symbols);
    on<MarketChangeEvent>(_onMarketChanged);
  }

  WebSocketChannel? _channel;
  final TrackerRepository _trackerRepository;

  Future<void> _initial(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    _trackerRepository.symbols();
  }

  Future<void> _onMarketChanged(
    MarketChangeEvent event,
    Emitter<HomeState> emit,
  ) async {
    add(SymbolsEvent(event.value));
  }

  Future<void> _symbols(
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
    _channel?.sink.close();
    return super.close();
  }
}
