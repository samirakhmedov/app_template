part of '{{name.snakeCase()}}_bloc.dart';

@freezed
abstract class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const factory {{name.pascalCase()}}State.initial() = {{name.pascalCase()}}StateInitial;
  const factory {{name.pascalCase()}}State.loading() = {{name.pascalCase()}}StateLoading;
  const factory {{name.pascalCase()}}State.loaded() = {{name.pascalCase()}}StateLoaded;
}
