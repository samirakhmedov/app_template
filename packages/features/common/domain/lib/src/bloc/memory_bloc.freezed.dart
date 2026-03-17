// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemoryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemoryEvent()';
}


}

/// @nodoc
class $MemoryEventCopyWith<$Res>  {
$MemoryEventCopyWith(MemoryEvent _, $Res Function(MemoryEvent) __);
}


/// @nodoc


class MemoryInitialize implements MemoryEvent {
  const MemoryInitialize();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryInitialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemoryEvent.initialize()';
}


}




/// @nodoc


class MemoryHandleMemoryPressure implements MemoryEvent {
  const MemoryHandleMemoryPressure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryHandleMemoryPressure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemoryEvent.handleMemoryPressure()';
}


}




/// @nodoc


class MemoryRevive implements MemoryEvent {
  const MemoryRevive();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryRevive);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemoryEvent.revive()';
}


}




/// @nodoc
mixin _$MemoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemoryState()';
}


}

/// @nodoc
class $MemoryStateCopyWith<$Res>  {
$MemoryStateCopyWith(MemoryState _, $Res Function(MemoryState) __);
}


/// @nodoc


class MemoryStateInitial implements MemoryState {
  const MemoryStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemoryState.initial()';
}


}




/// @nodoc


class MemoryStateHandlingPressure implements MemoryState {
  const MemoryStateHandlingPressure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryStateHandlingPressure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemoryState.handlingPressure()';
}


}




/// @nodoc


class MemoryStateRevived implements MemoryState {
  const MemoryStateRevived();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryStateRevived);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemoryState.revived()';
}


}




// dart format on
