// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../data/api_manager.dart' as _i704;
import '../data/data_module.dart' as _i319;
import '../data/hive_manager.dart' as _i508;
import '../data/repositories/news_repository/data_sources/news_offline_data_source.dart'
    as _i1072;
import '../data/repositories/news_repository/data_sources/news_offline_data_source_impl.dart'
    as _i746;
import '../data/repositories/news_repository/data_sources/news_online_data_source.dart'
    as _i719;
import '../data/repositories/news_repository/data_sources/news_online_data_source_impl.dart'
    as _i158;
import '../data/repositories/news_repository/news_repository.dart' as _i502;
import '../data/repositories/news_repository/news_repository_impl.dart'
    as _i746;
import 'screens/home/tabs/tabs_list_tab/articles_view_model.dart' as _i994;
import 'screens/home/tabs/tabs_list_tab/tabs_view_model.dart' as _i127;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dataModule = _$DataModule();
    gh.factory<_i704.ApiManager>(() => _i704.ApiManager());
    gh.factory<_i508.HiveManager>(() => _i508.HiveManager());
    gh.singleton<_i161.InternetConnection>(
        () => dataModule.getInternetConnection());
    gh.factory<_i1072.NewsOfflineDataSource>(
        () => _i746.NewsOfflineDataSourceImpl(gh<_i508.HiveManager>()));
    gh.factory<_i719.NewsRemoteDataSource>(
        () => _i158.NewsOnlineDataSourceImpl(gh<_i704.ApiManager>()));
    gh.factory<_i502.NewsRepository>(() => _i746.NewsRepositoryImpl(
          gh<_i1072.NewsOfflineDataSource>(),
          gh<_i719.NewsRemoteDataSource>(),
          gh<_i161.InternetConnection>(),
        ));
    gh.factory<_i994.ArticlesViewModel>(
        () => _i994.ArticlesViewModel(gh<_i502.NewsRepository>()));
    gh.factory<_i127.TabsViewModel>(
        () => _i127.TabsViewModel(gh<_i502.NewsRepository>()));
    return this;
  }
}

class _$DataModule extends _i319.DataModule {}
