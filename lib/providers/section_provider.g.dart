// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sectionsHash() => r'62db97165cb40a6f69bd9a16888a59cb21e63711';

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

abstract class _$Sections
    extends BuildlessAutoDisposeAsyncNotifier<List<Section>> {
  late final String result;

  FutureOr<List<Section>> build(
    String result,
  );
}

/// See also [Sections].
@ProviderFor(Sections)
const sectionsProvider = SectionsFamily();

/// See also [Sections].
class SectionsFamily extends Family<AsyncValue<List<Section>>> {
  /// See also [Sections].
  const SectionsFamily();

  /// See also [Sections].
  SectionsProvider call(
    String result,
  ) {
    return SectionsProvider(
      result,
    );
  }

  @override
  SectionsProvider getProviderOverride(
    covariant SectionsProvider provider,
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
  String? get name => r'sectionsProvider';
}

/// See also [Sections].
class SectionsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Sections, List<Section>> {
  /// See also [Sections].
  SectionsProvider(
    String result,
  ) : this._internal(
          () => Sections()..result = result,
          from: sectionsProvider,
          name: r'sectionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sectionsHash,
          dependencies: SectionsFamily._dependencies,
          allTransitiveDependencies: SectionsFamily._allTransitiveDependencies,
          result: result,
        );

  SectionsProvider._internal(
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
  FutureOr<List<Section>> runNotifierBuild(
    covariant Sections notifier,
  ) {
    return notifier.build(
      result,
    );
  }

  @override
  Override overrideWith(Sections Function() create) {
    return ProviderOverride(
      origin: this,
      override: SectionsProvider._internal(
        () => create()..result = result,
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
  AutoDisposeAsyncNotifierProviderElement<Sections, List<Section>>
      createElement() {
    return _SectionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SectionsProvider && other.result == result;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, result.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SectionsRef on AutoDisposeAsyncNotifierProviderRef<List<Section>> {
  /// The parameter `result` of this provider.
  String get result;
}

class _SectionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Sections, List<Section>>
    with SectionsRef {
  _SectionsProviderElement(super.provider);

  @override
  String get result => (origin as SectionsProvider).result;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
