import 'package:flutter/material.dart';
import 'package:movie_verse/widgets/fav_movie_widgets.dart';
import 'package:provider/provider.dart';
import '../provider/favorite_provider.dart';
import '../services/init_getIt.dart';
import '../services/navigation_service.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      body: favoriteProvider.favoriteMoviesList.isEmpty
          ? Center(
        child: Text(
          'No favorite movies found',
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.grey[550]),
        ),
      )
          : ListView.builder(
        itemCount: favoriteProvider.favoriteMoviesList.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: favoriteProvider.favoriteMoviesList.reversed
                .toList()[index],
            child: FavMovieWidgets(),
          );
        },
      ),
      floatingActionButton: favoriteProvider.favoriteMoviesList.isEmpty ? null : FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: (){
          favoriteProvider.clearFavorites();
          getIt<NavigationService>().showSnackBar(
            Text('Favorites cleared'),
          );
        },
        child: const Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}