import 'package:go_router/go_router.dart';
import 'package:tmdb_app_dio/presentation/screens/screens.dart';
import 'package:tmdb_app_dio/presentation/views/views.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        // child Routes
        GoRoute(
          path: 'movie/:id',
          name: MovieDetailScreen.name,
          builder: (context, satete) {
            final movieId = satete.pathParameters['id'] ?? 'no_id';

            return MovieDetailScreen(movieId: movieId);
          },
        ),
        GoRoute(
          path: 'Tv',
          name: ChanelsView.name,
          builder: (context, state) => const ChanelsView(),
        ),

        GoRoute(
          path: 'Favorites',
          name: FavoritesView.name,
          builder: (context, satete) => const FavoritesView(),
        ),

        GoRoute(
          path: 'config',
          name: SettingsView.name,
          builder: (context, satete) => const SettingsView(),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    )
  ],
);
