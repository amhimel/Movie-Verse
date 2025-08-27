import 'package:get_it/get_it.dart';
import 'package:movie_verse/services/navigation_service.dart';
import '../repositories/movies_repo.dart';
import 'api_service.dart';

GetIt getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<MoviesRepo>(() => MoviesRepo(getIt<ApiService>()));
}
