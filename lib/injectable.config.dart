// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'services/ApiService.dart';
import 'services/AuthService.dart';
import 'services/FirebaseFirestoreService.dart';
import 'services/StorageService.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<ApiService>(() => ApiService());
  gh.lazySingleton<AuthService>(() => AuthService());
  gh.lazySingleton<FirebaseFirestoreService>(() => FirebaseFirestoreService());
  gh.lazySingleton<StorageService>(() => StorageService());
  return get;
}
