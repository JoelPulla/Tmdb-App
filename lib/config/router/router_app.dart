import 'package:go_router/go_router.dart';
import 'package:tmdb_app_dio/presentation/screens/screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeView.name,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: 'ConfigProfile',
      name: ConfigScreen.name,
      builder: (context, satete) => const ConfigScreen(),
    ),

    // GoRoute(
    // path:'Detail',
    // name: MovieDetailScreen.name,
    // builder: (context, state) => const MovieDetailScreen(movieId: id) ,
    // ),
  ],
);
