// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameScore {
  Level get level;
  Map<Obstacle, ObstacleScore> get obstacleScore;

  /// Create a copy of GameScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GameScoreCopyWith<GameScore> get copyWith =>
      _$GameScoreCopyWithImpl<GameScore>(this as GameScore, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GameScore &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality()
                .equals(other.obstacleScore, obstacleScore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, level, const DeepCollectionEquality().hash(obstacleScore));
}

/// @nodoc
abstract mixin class $GameScoreCopyWith<$Res> {
  factory $GameScoreCopyWith(GameScore value, $Res Function(GameScore) _then) =
      _$GameScoreCopyWithImpl;
  @useResult
  $Res call({Level level, Map<Obstacle, ObstacleScore> obstacleScore});
}

/// @nodoc
class _$GameScoreCopyWithImpl<$Res> implements $GameScoreCopyWith<$Res> {
  _$GameScoreCopyWithImpl(this._self, this._then);

  final GameScore _self;
  final $Res Function(GameScore) _then;

  /// Create a copy of GameScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? obstacleScore = null,
  }) {
    return _then(_self.copyWith(
      level: null == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as Level,
      obstacleScore: null == obstacleScore
          ? _self.obstacleScore
          : obstacleScore // ignore: cast_nullable_to_non_nullable
              as Map<Obstacle, ObstacleScore>,
    ));
  }
}

/// @nodoc

class _GameScore extends GameScore {
  const _GameScore(
      {required this.level,
      required final Map<Obstacle, ObstacleScore> obstacleScore})
      : _obstacleScore = obstacleScore,
        super._();

  @override
  final Level level;
  final Map<Obstacle, ObstacleScore> _obstacleScore;
  @override
  Map<Obstacle, ObstacleScore> get obstacleScore {
    if (_obstacleScore is EqualUnmodifiableMapView) return _obstacleScore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_obstacleScore);
  }

  /// Create a copy of GameScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GameScoreCopyWith<_GameScore> get copyWith =>
      __$GameScoreCopyWithImpl<_GameScore>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameScore &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality()
                .equals(other._obstacleScore, _obstacleScore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, level, const DeepCollectionEquality().hash(_obstacleScore));
}

/// @nodoc
abstract mixin class _$GameScoreCopyWith<$Res>
    implements $GameScoreCopyWith<$Res> {
  factory _$GameScoreCopyWith(
          _GameScore value, $Res Function(_GameScore) _then) =
      __$GameScoreCopyWithImpl;
  @override
  @useResult
  $Res call({Level level, Map<Obstacle, ObstacleScore> obstacleScore});
}

/// @nodoc
class __$GameScoreCopyWithImpl<$Res> implements _$GameScoreCopyWith<$Res> {
  __$GameScoreCopyWithImpl(this._self, this._then);

  final _GameScore _self;
  final $Res Function(_GameScore) _then;

  /// Create a copy of GameScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? level = null,
    Object? obstacleScore = null,
  }) {
    return _then(_GameScore(
      level: null == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as Level,
      obstacleScore: null == obstacleScore
          ? _self._obstacleScore
          : obstacleScore // ignore: cast_nullable_to_non_nullable
              as Map<Obstacle, ObstacleScore>,
    ));
  }
}

// dart format on
