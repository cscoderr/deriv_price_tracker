import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:price_tracker/domain/models/models.dart';
import 'package:price_tracker/domain/repository/tracker_repository.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceBloc({required TrackerRepository trackerRepository})
      : _trackerRepository = trackerRepository,
        super(const PriceInitial()) {
    on<PriceChangedEvent>(_onPriceChanged);
    on<GetPriceEvent>(_onGetPriceChanged);
  }

  final TrackerRepository _trackerRepository;

  Future<void> _onPriceChanged(
    PriceChangedEvent event,
    Emitter<PriceState> emit,
  ) async {}

  Future<void> _onGetPriceChanged(
    GetPriceEvent event,
    Emitter<PriceState> emit,
  ) async {
    emit(const PriceLoading());
    await emit.forEach(
      _trackerRepository.tick(event.symbol),
      onData: PriceSuccess.new,
      onError: (error, _) => PriceFailure(
        error.toString(),
      ),
    );
  }
}
