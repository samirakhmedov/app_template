# Implementation Plan: Shimmer Shader Integration

## Overview
Integrate hardware-accelerated shimmer shader from ShaderBloc into existing shimmer components using the established architecture pattern: BlocListener in component's `listeners()` method and BlocBuilder in layout, exposing ShaderBloc as StateStreamable<ShaderState>.

## Shader Parameters Analysis
From `assets/shaders/shimmer.frag`:
- `uColorFrom` (vec4): Starting shimmer color
- `uColorTo` (vec4): Ending shimmer color  
- `uProgress` (float): Animation progress (0.0 to 1.0)
- `uTexture` (sampler2D): Background texture
- `uDirection` (vec2): Shimmer direction vector
- `uWidth` (float): Shimmer band width

## Implementation Tasks

### 1. Add ShaderBloc to ShimmerLoadingComponent
- Add `ShaderBloc get _shaderBloc => context.read<IAppScope>().shaderBloc;` getter
- Add BlocListener to `listeners()` method following theme component pattern
- Trigger shader preloading on component initialization
- Handle shader loading success/failure states

### 2. Update ShimmerLoadingViewModel interface
- Add `StateStreamable<ShaderState> get shaderBloc` getter
- Keep existing `buildShader()` method - no separate fragment shader methods
- Maintain backward compatibility with existing interface
- Handle shader availability within existing buildShader implementation

### 3. Implement BlocListener in ShimmerLoadingComponent
- Override `listeners()` method to return BlocListener<ShaderBloc, ShaderState>
- Listen for shader loading completion and errors
- Dispatch `ShaderLoadShader(ShaderType.shimmer)` on component init
- Handle shader state changes without breaking existing functionality

### 4. Update ShimmerLoadingLayout with BlocBuilder
- Add BlocBuilder<ShaderBloc, ShaderState> wrapper around existing AnimatedBuilder
- Use `vm.shaderBloc` as StateStreamable<ShaderState>
- Keep existing shimmer rendering logic intact
- Pass shader state to buildShader method

### 5. Enhance buildShader method in ShimmerLoadingComponent
- Accept shader state as parameter or read from context
- Check shader availability: `state.shaders[ShaderType.shimmer]`
- Configure fragment shader uniforms when available
- Fallback to existing gradient shader when unavailable
- Maintain single buildShader interface

### 6. Add shader parameter configuration in buildShader
- Map animation controller value to `uProgress` uniform
- Configure `uColorFrom`/`uColorTo` from theme skeleton colors
- Set `uDirection` based on shimmer movement direction
- Configure `uWidth` for shimmer band thickness
- Handle `uTexture` for background sampling

### 7. Add component lifecycle integration
- Trigger shader preloading in `initState()` if needed
- Handle shader disposal in `dispose()` if needed
- Ensure shader state synchronization with animation
- Maintain existing component lifecycle

### 8. Add shader availability state tracking
- Track shader loading state in component if needed
- Handle shader loading errors gracefully
- Provide fallback behavior when shader unavailable
- Log shader status for debugging

### 9. Update layout to use BlocBuilder
- Wrap existing shimmer rendering with BlocBuilder
- Pass shader state to buildShader through existing interface
- Maintain animation timing and visual consistency
- Keep existing ShaderMask and AnimatedBuilder structure

### 10. Optimize shader parameter updates
- Configure shader uniforms efficiently during animation
- Cache shader parameters when possible
- Minimize shader recompilation
- Monitor performance impact

## Technical Implementation Details

### Component Implementation Pattern
```dart
class _ShimmerLoadingComponentState
    extends ComponentState<ShimmerLoadingComponent, ShimmerLoadingViewModel, ShimmerLoadingLayout>
    implements ShimmerLoadingViewModel {
  
  ShaderBloc get _shaderBloc => context.read<IAppScope>().shaderBloc;
  
  @override
  void initState() {
    super.initState();
    // Trigger shader preloading
    _shaderBloc.add(const ShaderLoadShader(ShaderType.shimmer));
  }
  
  @override
  List<BlocListenerType> listeners() {
    return [
      BlocListener<ShaderBloc, ShaderState>(
        listener: (context, state) {
          // Handle shader loading success/failure
          final shader = state.shaders[ShaderType.shimmer];
          if (shader != null) {
            // Shader loaded successfully
          } else {
            // Shader loading failed or not available
          }
        },
        bloc: _shaderBloc,
      ),
    ];
  }
  
  @override
  StateStreamable<ShaderState> get shaderBloc => _shaderBloc;
  
  @override
  Shader buildShader(Offset offsetWithinShimmer, Size shimmerSize) {
    // Access current shader state
    final shaderState = _shaderBloc.state;
    final shader = shaderState.shaders[ShaderType.shimmer];
    
    if (shader != null) {
      // Configure fragment shader uniforms
      final progress = shimmerProvider.shimmerChanges.value;
      final theme = context.appColorScheme;
      
      shader.setFloat(0, progress);                           // uProgress
      shader.setFloat(1, theme.skeletonSecondary.red);        // uColorFrom.r
      shader.setFloat(2, theme.skeletonSecondary.green);      // uColorFrom.g
      shader.setFloat(3, theme.skeletonSecondary.blue);       // uColorFrom.b
      shader.setFloat(4, theme.skeletonSecondary.alpha);      // uColorFrom.a
      shader.setFloat(5, theme.skeletonTertiary.red);         // uColorTo.r
      shader.setFloat(6, theme.skeletonTertiary.green);       // uColorTo.g
      shader.setFloat(7, theme.skeletonTertiary.blue);        // uColorTo.b
      shader.setFloat(8, theme.skeletonTertiary.alpha);       // uColorTo.a
      shader.setFloat(9, 1.0);                               // uDirection.x
      shader.setFloat(10, 0.3);                              // uDirection.y
      shader.setFloat(11, 0.2);                              // uWidth
      
      return shader;
    } else {
      // Fallback to existing gradient shader
      return shimmerGradient.createShader(
        Rect.fromLTWH(
          -offsetWithinShimmer.dx,
          -offsetWithinShimmer.dy,
          shimmerSize.width,
          shimmerSize.height,
        ),
      );
    }
  }
}
```

### Layout Implementation Pattern
```dart
class ShimmerLoadingLayout extends Layout<ShimmerLoadingViewModel> {
  @override
  Widget layout(ShimmerLoadingViewModel vm) {
    if (!vm.isLoading) {
      return vm.child;
    }

    return BlocBuilder<ShaderBloc, ShaderState>(
      bloc: vm.shaderBloc,
      builder: (context, shaderState) {
        final shimmerChanges = vm.shimmerChanges;

        return AnimatedBuilder(
          animation: shimmerChanges,
          builder: (ctx, chld) {
            if (!vm.isSized) {
              return const SizedBox();
            }

            final shimmerSize = vm.size;
            if (shimmerSize == null) {
              return const SizedBox();
            }

            final descendant = ctx.findRenderObject() as RenderBox?;
            if (descendant == null) {
              return const SizedBox();
            }

            final offsetWithinShimmer = vm.getDescendantOffset(
              descendant: descendant,
            );

            return ShaderMask(
              shaderCallback: (_) => vm.buildShader(offsetWithinShimmer, shimmerSize),
              blendMode: BlendMode.srcATop,
              child: chld,
            );
          },
          child: vm.child,
        );
      },
    );
  }
}
```

### ViewModel Interface Update
```dart
abstract interface class ShimmerLoadingViewModel implements ViewModel {
  bool get isLoading;
  Widget get child;
  Animation<double> get shimmerChanges;
  bool get isSized;
  Size? get size;
  
  // Add shader bloc access
  StateStreamable<ShaderState> get shaderBloc;
  
  // Keep existing single shader building method
  Shader buildShader(Offset offsetWithinShimmer, Size shimmerSize);
  
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  });
}
```

## File Modifications

### shimmer_loading_component.dart
- Add `ShaderBloc get _shaderBloc => context.read<IAppScope>().shaderBloc;`
- Override `listeners()` method with BlocListener<ShaderBloc, ShaderState>
- Add `StateStreamable<ShaderState> get shaderBloc => _shaderBloc;` to view model
- Update `buildShader()` to handle fragment shader + fallback in single method
- Trigger shader preloading in initState()

### shimmer_loading_layout.dart
- Wrap existing AnimatedBuilder with BlocBuilder<ShaderBloc, ShaderState>
- Use `vm.shaderBloc` as bloc parameter
- Keep existing shimmer rendering logic intact
- Pass shader state context to buildShader method

## Testing Strategy

### Unit Tests
- Test shader parameter configuration in buildShader
- Test fallback behavior when shader unavailable
- Test BlocListener state handling
- Test BlocBuilder rendering with shader state changes

### Integration Tests
- Test shader loading lifecycle with component
- Test animation synchronization with fragment shader
- Test theme color integration with shader uniforms
- Test visual consistency between shader and gradient modes

### Performance Tests
- Compare fragment shader vs gradient performance
- Test shader parameter update efficiency
- Monitor memory usage with shader integration
- Test across different device capabilities

## Compatibility Notes
- Maintain full backward compatibility with existing shimmer API
- Keep existing shimmer component interfaces unchanged
- Add shader enhancement transparently using established patterns
- Preserve animation timing and visual behavior
- Follow existing BlocListener/BlocBuilder architecture patterns