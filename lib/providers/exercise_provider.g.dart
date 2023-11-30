// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$exercisesHash() => r'875aafe7d1ef79cdb982f22e46db4e8169a0f123';

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

abstract class _$Exercises
    extends BuildlessAutoDisposeAsyncNotifier<List<Exercise>> {
  late final String sectionId;
  late final String userId;

  FutureOr<List<Exercise>> build(
    String sectionId,
    String userId,
  );
}

/// See also [Exercises].
@ProviderFor(Exercises)
const exercisesProvider = ExercisesFamily();

/// See also [Exercises].
class ExercisesFamily extends Family<AsyncValue<List<Exercise>>> {
  /// See also [Exercises].
  const ExercisesFamily();

  /// See also [Exercises].
  ExercisesProvider call(
    String sectionId,
    String userId,
  ) {
    return ExercisesProvider(
      sectionId,
      userId,
    );
  }

  @override
  ExercisesProvider getProviderOverride(
    covariant ExercisesProvider provider,
  ) {
    return call(
      provider.sectionId,
      provider.userId,
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
  String? get name => r'exercisesProvider';
}

/// See also [Exercises].
class ExercisesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Exercises, List<Exercise>> {
  /// See also [Exercises].
  ExercisesProvider(
    String sectionId,
    String userId,
  ) : this._internal(
          () => Exercises()
            ..sectionId = sectionId
            ..userId = userId,
          from: exercisesProvider,
          name: r'exercisesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$exercisesHash,
          dependencies: ExercisesFamily._dependencies,
          allTransitiveDependencies: ExercisesFamily._allTransitiveDependencies,
          sectionId: sectionId,
          userId: userId,
        );

  ExercisesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sectionId,
    required this.userId,
  }) : super.internal();

  final String sectionId;
  final String userId;

  @override
  FutureOr<List<Exercise>> runNotifierBuild(
    covariant Exercises notifier,
  ) {
    return notifier.build(
      sectionId,
      userId,
    );
  }

  @override
  Override overrideWith(Exercises Function() create) {
    return ProviderOverride(
      origin: this,
      override: ExercisesProvider._internal(
        () => create()
          ..sectionId = sectionId
          ..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sectionId: sectionId,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Exercises, List<Exercise>>
      createElement() {
    return _ExercisesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExercisesProvider &&
        other.sectionId == sectionId &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectionId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExercisesRef on AutoDisposeAsyncNotifierProviderRef<List<Exercise>> {
  /// The parameter `sectionId` of this provider.
  String get sectionId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _ExercisesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Exercises, List<Exercise>>
    with ExercisesRef {
  _ExercisesProviderElement(super.provider);

  @override
  String get sectionId => (origin as ExercisesProvider).sectionId;
  @override
  String get userId => (origin as ExercisesProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
