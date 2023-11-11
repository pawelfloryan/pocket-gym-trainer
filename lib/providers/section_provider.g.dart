// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSectionListHash() => r'2f7ee33e0b7de7ea001c303d009015799ef59422';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getSectionList].
@ProviderFor(getSectionList)
const getSectionListProvider = GetSectionListFamily();

/// See also [getSectionList].
class GetSectionListFamily extends Family<AsyncValue<List<Section>>> {
  /// See also [getSectionList].
  const GetSectionListFamily();

  /// See also [getSectionList].
  GetSectionListProvider call(
    String result,
  ) {
    return GetSectionListProvider(
      result,
    );
  }

  @override
  GetSectionListProvider getProviderOverride(
    covariant GetSectionListProvider provider,
  ) {
    return call(
      provider.result,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getSectionListProvider';
}

/// See also [getSectionList].
class GetSectionListProvider extends AutoDisposeFutureProvider<List<Section>> {
  /// See also [getSectionList].
  GetSectionListProvider(
    String result,
  ) : this._internal(
          (ref) => getSectionList(
            ref as GetSectionListRef,
            result,
          ),
          from: getSectionListProvider,
          name: r'getSectionListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSectionListHash,
          dependencies: GetSectionListFamily._dependencies,
          allTransitiveDependencies:
              GetSectionListFamily._allTransitiveDependencies,
          result: result,
        );

  GetSectionListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.result,
  }) : super.internal();

  final String result;

  @override
  Override overrideWith(
    FutureOr<List<Section>> Function(GetSectionListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSectionListProvider._internal(
        (ref) => create(ref as GetSectionListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        result: result,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Section>> createElement() {
    return _GetSectionListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSectionListProvider && other.result == result;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, result.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSectionListRef on AutoDisposeFutureProviderRef<List<Section>> {
  /// The parameter `result` of this provider.
  String get result;
}

class _GetSectionListProviderElement
    extends AutoDisposeFutureProviderElement<List<Section>>
    with GetSectionListRef {
  _GetSectionListProviderElement(super.provider);

  @override
  String get result => (origin as GetSectionListProvider).result;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
