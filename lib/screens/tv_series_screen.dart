import 'package:flutter/material.dart';
import 'package:movie_verse/provider/tv_shows_provider.dart';
import 'package:movie_verse/widgets/fav_movie_widgets.dart';
import 'package:movie_verse/widgets/tv_show_widgets.dart';
import 'package:provider/provider.dart';
import '../provider/favorite_provider.dart';
import '../services/init_getIt.dart';
import '../services/navigation_service.dart';

class TvSeriesScreen extends StatelessWidget {
  const TvSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tvShowsProvider = Provider.of<TvShowsProvider>(context);
    return Scaffold(
      body: tvShowsProvider.tvShowList.isEmpty
          ? Center(
        child: Text(
          'No favorite movies found',
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.grey[550]),
        ),
      )
          : ListView.builder(
        itemCount: tvShowsProvider.tvShowList.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: tvShowsProvider.tvShowList.reversed
                .toList()[index],
            child: TvShowWidgets(),
          );
        },
      ),

    );
  }
}