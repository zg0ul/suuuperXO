// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cell_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CellState _$CellStateFromJson(Map<String, dynamic> json) {
  return _CellState.fromJson(json);
}

/// @nodoc
mixin _$CellState {
  Player? get owner => throw _privateConstructorUsedError;

  /// Serializes this CellState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CellState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CellStateCopyWith<CellState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CellStateCopyWith<$Res> {
  factory $CellStateCopyWith(CellState value, $Res Function(CellState) then) =
      _$CellStateCopyWithImpl<$Res, CellState>;
  @useResult
  $Res call({Player? owner});
}

/// @nodoc
class _$CellStateCopyWithImpl<$Res, $Val extends CellState>
    implements $CellStateCopyWith<$Res> {
  _$CellStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CellState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? owner = freezed}) {
    return _then(
      _value.copyWith(
            owner: freezed == owner
                ? _value.owner
                : owner // ignore: cast_nullable_to_non_nullable
                      as Player?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CellStateImplCopyWith<$Res>
    implements $CellStateCopyWith<$Res> {
  factory _$$CellStateImplCopyWith(
    _$CellStateImpl value,
    $Res Function(_$CellStateImpl) then,
  ) = __$$CellStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Player? owner});
}

/// @nodoc
class __$$CellStateImplCopyWithImpl<$Res>
    extends _$CellStateCopyWithImpl<$Res, _$CellStateImpl>
    implements _$$CellStateImplCopyWith<$Res> {
  __$$CellStateImplCopyWithImpl(
    _$CellStateImpl _value,
    $Res Function(_$CellStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CellState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? owner = freezed}) {
    return _then(
      _$CellStateImpl(
        owner: freezed == owner
            ? _value.owner
            : owner // ignore: cast_nullable_to_non_nullable
                  as Player?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CellStateImpl implements _CellState {
  const _$CellStateImpl({required this.owner});

  factory _$CellStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CellStateImplFromJson(json);

  @override
  final Player? owner;

  @override
  String toString() {
    return 'CellState(owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CellStateImpl &&
            (identical(other.owner, owner) || other.owner == owner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, owner);

  /// Create a copy of CellState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CellStateImplCopyWith<_$CellStateImpl> get copyWith =>
      __$$CellStateImplCopyWithImpl<_$CellStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CellStateImplToJson(this);
  }
}

abstract class _CellState implements CellState {
  const factory _CellState({required final Player? owner}) = _$CellStateImpl;

  factory _CellState.fromJson(Map<String, dynamic> json) =
      _$CellStateImpl.fromJson;

  @override
  Player? get owner;

  /// Create a copy of CellState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CellStateImplCopyWith<_$CellStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
