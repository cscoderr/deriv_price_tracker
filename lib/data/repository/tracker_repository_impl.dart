import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:price_tracker/data/api/tracker_api.dart';
import 'package:price_tracker/data/cache/cache.dart';
import 'package:price_tracker/domain/models/models.dart';
import 'package:price_tracker/domain/repository/tracker_repository.dart';

class TrackerRepositoryImpl extends TrackerRepository {
  TrackerRepositoryImpl({
    TrackerApi? trackerApi,
    Cache<String, List<SymbolModel>>? cache,
    Cache<String, PriceModel>? priceCache,
  })  : _trackerApi = trackerApi ?? TrackerApi(),
        _priceCache = priceCache ?? InAppMemory<String, PriceModel>(),
        _cache = cache ?? InAppMemory<String, List<SymbolModel>>();

  final TrackerApi _trackerApi;
  final Cache<String, List<SymbolModel>> _cache;
  final Cache<String, PriceModel> _priceCache;

  @visibleForTesting
  final String symbolKey = '__symbol_key__';
  final String priceKey = '__price_key__';

  final _priceStreamController = StreamController<PriceModel>.broadcast();
  final _symbolStreamController =
      StreamController<List<SymbolModel>>.broadcast();

  @override
  Stream<List<SymbolModel>> marketSymbol(String market) async* {
    // final _streamController = StreamController<List<SymbolModel>>.broadcast();
    if (_cache.contains(symbolKey)) {
      final symbols = _cache.get(symbolKey)!;
      yield symbols;
    }
    final symbols = symbolsWithMarket(market);
    yield* symbols;
  }

  List<SymbolModel> _getMarketSymbols(List<SymbolModel> data, String market) {
    final response = data.where((element) => element.market == market).toList();
    return response;
  }

  Stream<List<SymbolModel>> symbolsWithMarket(String market) async* {
    _trackerApi.getSymbols().listen(
      (dynamic data) {
        final resData = jsonDecode(data as String) as Map<String, dynamic>;
        if (resData['error'] != null) {
          throw Exception('Market close');
        }
        final response = resData['active_symbols'] as List;
        final symbols = response
            .map((dynamic e) => SymbolModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final marketSymbols = _getMarketSymbols(symbols, market);
        _symbolStreamController.add(marketSymbols);
      },
      onError: (dynamic error) {
        print(error);
        throw Exception(error);
      },
    );
    yield* _symbolStreamController.stream;
  }

  @override
  Stream<List<SymbolModel>> symbols() async* {
    final _streamController = StreamController<List<SymbolModel>>.broadcast();
    _trackerApi.getSymbols().listen(
      (dynamic data) {
        final resData = jsonDecode(data as String) as Map<String, dynamic>;
        if (resData['error'] != null) {
          throw Exception('Market close');
        }
        final response = resData['active_symbols'] as List;
        final symbols = response
            .map((dynamic e) => SymbolModel.fromJson(e as Map<String, dynamic>))
            .toList();
        _streamController.add(symbols);
        _cache.set(symbolKey, symbols);
      },
      onError: (dynamic error) {
        throw Exception(error);
      },
    );
    yield* _streamController.stream;
  }

  @override
  Stream<PriceModel> tick(String symbol) async* {
    _trackerApi.getPriceTicks(symbol).listen(
      (dynamic data) {
        final response = jsonDecode(data as String) as Map<String, dynamic>;
        if (response['error'] != null) {
          _priceStreamController
              .addError(response['error']['message'].toString());
        }
        final price = PriceModel.fromJson(response);
        _priceStreamController.add(price);
        _priceCache.set(priceKey, price);
      },
      onError: (dynamic error) {
        _priceStreamController.addError(error.toString());
      },
    );
    yield* _priceStreamController.stream;
  }

  @override
  void close() {
    _priceStreamController.close();
    _symbolStreamController.close();
    _trackerApi.close();
  }

  @override
  void forget(String id) {
    // TODO: implement forget
  }
}
