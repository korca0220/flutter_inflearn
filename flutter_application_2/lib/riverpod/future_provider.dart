import 'package:flutter_riverpod/flutter_riverpod.dart';

final multipleFutureProvider = FutureProvider((ref) async {
  await Future.delayed(Duration(seconds: 2));
  // throw Exception('Error');
  return [1, 2, 3, 4, 5];
});
