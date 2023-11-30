// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepared_exercise_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPreparedExerciseListHash() =>
    r'78b6e4099c8c079b872e851378662f2833af358d';

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

/// See also [getPreparedExerciseList].
@ProviderFor(getPreparedExerciseList)
const getPreparedExerciseListProvider = GetPreparedExerciseListFamily();

/// See also [getPreparedExerciseList].
class GetPreparedExerciseListFamily
    extends Family<AsyncValue<List<PreparedExercise>>> {
  /// See also [getPreparedExerciseList].
  const GetPreparedExerciseListFamily();

  /// See also [getPreparedExerciseList].
  GetPreparedExerciseListProvider call(
    int position,
  ) {
    return GetPreparedExerciseListProvider(
      position,
    );
  }

  @override
  GetPreparedExerciseListProvider getProviderOverride(
    covariant GetPreparedExerciseListProvider provider,
  ) {
    return call(
      provider.position,
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
  String? get name => r'getPreparedExerciseListProvider';
}

/// See also [getPreparedExerciseList].
class GetPreparedExerciseListProvider
    extends AutoDisposeFutureProvider<List<PreparedExercise>> {
  /// See also [getPreparedExerciseList].
  GetPreparedExerciseListProvider(
    int position,
  ) : this._internal(
          (ref) => getPreparedExerciseList(
            ref as GetPreparedExerciseListRef,
            position,
          ),
          from: getPreparedExerciseListProvider,
          name: r'getPreparedExerciseListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPreparedExerciseListHash,
          dependencies: GetPreparedExerciseListFamily._dependencies,
          allTransitiveDependencies:
              GetPreparedExerciseListFamily._allTransitiveDependencies,
          position: position,
        );

  GetPreparedExerciseListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.position,
  }) : super.internal();

  final int position;

  @override
  Override overrideWith(
    FutureOr<List<PreparedExercise>> Function(
            GetPreparedExerciseListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPreparedExerciseListProvider._internal(
        (ref) => create(ref as GetPreparedExerciseListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        position: position,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PreparedExercise>> createElement() {
    return _GetPreparedExerciseListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPreparedExerciseListProvider &&
        other.position == position;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, position.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPreparedExerciseListRef
    on AutoDisposeFutureProviderRef<List<PreparedExercise>> {
  /// The parameter `position` of this provider.
  int get position;
}

class _GetPreparedExerciseListProviderElement
    extends AutoDisposeFutureProviderElement<List<PreparedExercise>>
    with GetPreparedExerciseListRef {
  _GetPreparedExerciseListProviderElement(super.provider);

  @override
  int get position => (origin as GetPreparedExerciseListProvider).position;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
