import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    print(
        '[Provider Updated] provider : $provider / pv: $previousValue / nv : $newValue');
    // 사실상 아무기능이 없음 지워도 무방
    // super.didUpdateProvider(provider, previousValue, newValue, container);
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    print('[Provider Added] provider : $provider / value: $value');
    // super.didAddProvider(provider, value, container);
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    print('[Provider Disposed] provider : $provider');
    // super.didDisposeProvider(provider, container);
  }
}
