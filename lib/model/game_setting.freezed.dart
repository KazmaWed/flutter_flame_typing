// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameSetting {
  KeyboardLayout get phisicalLayout;
  KeyboardLayout? get logicalLayout;
  int get gameMode;
  bool? get se;

  /// Create a copy of GameSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GameSettingCopyWith<GameSetting> get copyWith =>
      _$GameSettingCopyWithImpl<GameSetting>(this as GameSetting, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GameSetting &&
            (identical(other.phisicalLayout, phisicalLayout) ||
                other.phisicalLayout == phisicalLayout) &&
            (identical(other.logicalLayout, logicalLayout) ||
                other.logicalLayout == logicalLayout) &&
            (identical(other.gameMode, gameMode) ||
                other.gameMode == gameMode) &&
            (identical(other.se, se) || other.se == se));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phisicalLayout, logicalLayout, gameMode, se);

  @override
  String toString() {
    return 'GameSetting(phisicalLayout: $phisicalLayout, logicalLayout: $logicalLayout, gameMode: $gameMode, se: $se)';
  }
}

/// @nodoc
abstract mixin class $GameSettingCopyWith<$Res> {
  factory $GameSettingCopyWith(
          GameSetting value, $Res Function(GameSetting) _then) =
      _$GameSettingCopyWithImpl;
  @useResult
  $Res call(
      {KeyboardLayout phisicalLayout,
      KeyboardLayout? logicalLayout,
      int gameMode,
      bool? se});
}

/// @nodoc
class _$GameSettingCopyWithImpl<$Res> implements $GameSettingCopyWith<$Res> {
  _$GameSettingCopyWithImpl(this._self, this._then);

  final GameSetting _self;
  final $Res Function(GameSetting) _then;

  /// Create a copy of GameSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phisicalLayout = null,
    Object? logicalLayout = freezed,
    Object? gameMode = null,
    Object? se = freezed,
  }) {
    return _then(_self.copyWith(
      phisicalLayout: null == phisicalLayout
          ? _self.phisicalLayout
          : phisicalLayout // ignore: cast_nullable_to_non_nullable
              as KeyboardLayout,
      logicalLayout: freezed == logicalLayout
          ? _self.logicalLayout
          : logicalLayout // ignore: cast_nullable_to_non_nullable
              as KeyboardLayout?,
      gameMode: null == gameMode
          ? _self.gameMode
          : gameMode // ignore: cast_nullable_to_non_nullable
              as int,
      se: freezed == se
          ? _self.se
          : se // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _GameSetting extends GameSetting {
  const _GameSetting(
      {this.phisicalLayout = KeyboardLayout.qwerty,
      this.logicalLayout,
      this.gameMode = 0,
      this.se})
      : super._();

  @override
  @JsonKey()
  final KeyboardLayout phisicalLayout;
  @override
  final KeyboardLayout? logicalLayout;
  @override
  @JsonKey()
  final int gameMode;
  @override
  final bool? se;

  /// Create a copy of GameSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GameSettingCopyWith<_GameSetting> get copyWith =>
      __$GameSettingCopyWithImpl<_GameSetting>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameSetting &&
            (identical(other.phisicalLayout, phisicalLayout) ||
                other.phisicalLayout == phisicalLayout) &&
            (identical(other.logicalLayout, logicalLayout) ||
                other.logicalLayout == logicalLayout) &&
            (identical(other.gameMode, gameMode) ||
                other.gameMode == gameMode) &&
            (identical(other.se, se) || other.se == se));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phisicalLayout, logicalLayout, gameMode, se);

  @override
  String toString() {
    return 'GameSetting(phisicalLayout: $phisicalLayout, logicalLayout: $logicalLayout, gameMode: $gameMode, se: $se)';
  }
}

/// @nodoc
abstract mixin class _$GameSettingCopyWith<$Res>
    implements $GameSettingCopyWith<$Res> {
  factory _$GameSettingCopyWith(
          _GameSetting value, $Res Function(_GameSetting) _then) =
      __$GameSettingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {KeyboardLayout phisicalLayout,
      KeyboardLayout? logicalLayout,
      int gameMode,
      bool? se});
}

/// @nodoc
class __$GameSettingCopyWithImpl<$Res> implements _$GameSettingCopyWith<$Res> {
  __$GameSettingCopyWithImpl(this._self, this._then);

  final _GameSetting _self;
  final $Res Function(_GameSetting) _then;

  /// Create a copy of GameSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phisicalLayout = null,
    Object? logicalLayout = freezed,
    Object? gameMode = null,
    Object? se = freezed,
  }) {
    return _then(_GameSetting(
      phisicalLayout: null == phisicalLayout
          ? _self.phisicalLayout
          : phisicalLayout // ignore: cast_nullable_to_non_nullable
              as KeyboardLayout,
      logicalLayout: freezed == logicalLayout
          ? _self.logicalLayout
          : logicalLayout // ignore: cast_nullable_to_non_nullable
              as KeyboardLayout?,
      gameMode: null == gameMode
          ? _self.gameMode
          : gameMode // ignore: cast_nullable_to_non_nullable
              as int,
      se: freezed == se
          ? _self.se
          : se // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
