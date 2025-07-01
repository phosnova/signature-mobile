// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'data/datasources/signature_local_data_source.dart' as _i521;
import 'data/repositories_impl/signature_repository_impl.dart' as _i349;
import 'domain/entities/repositories/signature_repository.dart' as _i1010;
import 'presentation/bloc/sign/sign_bloc.dart' as _i206;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i206.SignBloc>(() => _i206.SignBloc());
  gh.lazySingleton<_i521.SignatureLocalDataSource>(
    () => _i521.SignatureLocalDataSourceImpl(),
  );
  gh.lazySingleton<_i1010.SignatureRepository>(
    () => _i349.SignatureRepositoryImpl(
      signatureLocalDataSource: gh<_i521.SignatureLocalDataSource>(),
    ),
  );
  return getIt;
}
