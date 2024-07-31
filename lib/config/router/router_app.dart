import 'package:go_router/go_router.dart';
import 'package:tmdb_app_dio/presentation/screens/screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        // child Routes
        GoRoute(
          path: 'config',
          name: ConfigScreen.name,
          builder: (context, satete) => const ConfigScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/movie/:id',
      name: MovieDetailScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';
        return MovieDetailScreen(movieId: movieId);
      },
    ),
  ],
);
