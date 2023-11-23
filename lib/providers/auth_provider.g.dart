// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginActionHash() => r'fa31cab9be46bc46cb3227f25d0fc4743f193736';

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

/// See also [loginAction].
@ProviderFor(loginAction)
const loginActionProvider = LoginActionFamily();

/// See also [loginAction].
class LoginActionFamily extends Family<AsyncValue<AuthResult>> {
  /// See also [loginAction].
  const LoginActionFamily();

  /// See also [loginAction].
  LoginActionProvider call(
    Login login,
  ) {
    return LoginActionProvider(
      login,
    );
  }

  @override
  LoginActionProvider getProviderOverride(
    covariant LoginActionProvider provider,
  ) {
    return call(
      provider.login,
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
  String? get name => r'loginActionProvider';
}

/// See also [loginAction].
class LoginActionProvider extends AutoDisposeFutureProvider<AuthResult> {
  /// See also [loginAction].
  LoginActionProvider(
    Login login,
  ) : this._internal(
          (ref) => loginAction(
            ref as LoginActionRef,
            login,
          ),
          from: loginActionProvider,
          name: r'loginActionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loginActionHash,
          dependencies: LoginActionFamily._dependencies,
          allTransitiveDependencies:
              LoginActionFamily._allTransitiveDependencies,
          login: login,
        );

  LoginActionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.login,
  }) : super.internal();

  final Login login;

  @override
  Override overrideWith(
    FutureOr<AuthResult> Function(LoginActionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoginActionProvider._internal(
        (ref) => create(ref as LoginActionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        login: login,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AuthResult> createElement() {
    return _LoginActionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoginActionProvider && other.login == login;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, login.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LoginActionRef on AutoDisposeFutureProviderRef<AuthResult> {
  /// The parameter `login` of this provider.
  Login get login;
}

class _LoginActionProviderElement
    extends AutoDisposeFutureProviderElement<AuthResult> with LoginActionRef {
  _LoginActionProviderElement(super.provider);

  @override
  Login get login => (origin as LoginActionProvider).login;
}

String _$registerActionHash() => r'600a52111587df8c842acb15100db0c7e1564813';

/// See also [registerAction].
@ProviderFor(registerAction)
const registerActionProvider = RegisterActionFamily();

/// See also [registerAction].
class RegisterActionFamily extends Family<AsyncValue<AuthResult>> {
  /// See also [registerAction].
  const RegisterActionFamily();

  /// See also [registerAction].
  RegisterActionProvider call(
    Register login,
  ) {
    return RegisterActionProvider(
      login,
    );
  }

  @override
  RegisterActionProvider getProviderOverride(
    covariant RegisterActionProvider provider,
  ) {
    return call(
      provider.login,
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
  String? get name => r'registerActionProvider';
}

/// See also [registerAction].
class RegisterActionProvider extends AutoDisposeFutureProvider<AuthResult> {
  /// See also [registerAction].
  RegisterActionProvider(
    Register login,
  ) : this._internal(
          (ref) => registerAction(
            ref as RegisterActionRef,
            login,
          ),
          from: registerActionProvider,
          name: r'registerActionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registerActionHash,
          dependencies: RegisterActionFamily._dependencies,
          allTransitiveDependencies:
              RegisterActionFamily._allTransitiveDependencies,
          login: login,
        );

  RegisterActionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.login,
  }) : super.internal();

  final Register login;

  @override
  Override overrideWith(
    FutureOr<AuthResult> Function(RegisterActionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterActionProvider._internal(
        (ref) => create(ref as RegisterActionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        login: login,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AuthResult> createElement() {
    return _RegisterActionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterActionProvider && other.login == login;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, login.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RegisterActionRef on AutoDisposeFutureProviderRef<AuthResult> {
  /// The parameter `login` of this provider.
  Register get login;
}

class _RegisterActionProviderElement
    extends AutoDisposeFutureProviderElement<AuthResult>
    with RegisterActionRef {
  _RegisterActionProviderElement(super.provider);

  @override
  Register get login => (origin as RegisterActionProvider).login;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
