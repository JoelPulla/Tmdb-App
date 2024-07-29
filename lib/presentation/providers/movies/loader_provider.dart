import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/presentation/providers/providers.dart';

final initialLouderProvider = StateProvider<bool>((ref) {

  final step1 = ref.watch(moviesSliderShowProvider).isEmpty;
  final step2 = ref.watch(popularMoviesPrivider).isEmpty;
  final step3 = ref.watch(upCominMoviesProvider).isEmpty;
  final step4 = ref.watch(topRatedProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  return false;
});
