import 'package:linum/objectbox.g.dart';
import 'package:linum/utilities/backend/exchange_rate_repository.dart';

class ObjectBoxRepositories {
  final Store _store;
  final ExchangeRateRepository exchangeRates;

  static Future<ObjectBoxRepositories> create() async =>
      ObjectBoxRepositories._(await openStore());
  ObjectBoxRepositories._(this._store)
      : exchangeRates = ExchangeRateRepository(_store);
}