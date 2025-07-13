/// A collection of pragma annotation presets for communicating with the Dart VM
/// and other tools.
///
/// Pragmas are special annotations that provide hints or directives to Dart
/// tools, most notably the JIT (Just-in-Time) and AOT (Ahead-of-Time)
/// compilers. They can be used to influence optimization decisions, control
/// debugging behavior, and ensure correctness in specific scenarios like
/// native interop.
///
/// USAGE:
/// 1. Add this file to your project (e.g., under `lib/src/`).
/// 2. Import it into the file where you need to use a pragma:
///    `import 'path/to/pragma_presets.dart';`
/// 3. Apply the desired pragma annotation to your class, method, or function:
///    `@preferInline`
///    `void myFastFunction() {... }`
///
/// This file categorizes pragmas into "General Use", "Unsafe", and "Flutter-Specific"
/// to clarify their intended use and associated risks.
///
/// NOTE: Pragmas for internal SDK or testing use (e.g., `vm:exact-result-type`,
/// `vm:testing.*`) are intentionally omitted as they are not safe or enabled
/// for general application development and can cause undefined behavior or crashes.

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~                           GENERAL USE PRAGMAS                           ~~
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// These pragmas are part of the stable VM API and are safe for general use.

// ignore_for_file: dangling_library_doc_comments

/// **`@pragma('vm:entry-point')`**
///
/// Ensures that a class, method, or function is not removed by the AOT
/// compiler's tree-shaking process, even if it appears to be unused in
/// Dart code.
///
/// ### Use Cases:
/// - **Native Interop**: Essential for Dart functions called from native code
///   (C, C++, Swift, Kotlin) via `dart:ffi` or platform channels. The AOT
///   compiler cannot see these native calls and would otherwise discard the
///   Dart function as dead code.
/// - **Isolate Entry Points**: Top-level or static functions used as entry
///   points for new isolates (e.g., with `Isolate.spawn` or Flutter's
///   `compute` function) must be marked to ensure they are available at
///   runtime.
///
/// ### Impact:
/// - **Positive (Correctness)**: Prevents runtime errors in AOT-compiled apps
///   where native code needs to call back into Dart.
/// - **Negative (Code Size)**: Can increase binary size by preventing code
///   and its dependencies from being tree-shaken. Use it only when necessary.
const entryPoint = pragma('vm:entry-point');

/// **`@pragma('vm:prefer-inline')`**
///
/// A strong suggestion to the compiler to inline the annotated function.
/// Inlining replaces a function call with the function's body at the call site,
/// which can improve performance by eliminating call overhead.
///
/// ### Use Cases:
/// - Small, performance-critical functions that are called frequently,
///   especially inside tight loops.
///
/// ### Impact:
/// - **Positive (Performance)**: Can increase speed by removing function call
///   overhead and enabling further optimizations on the larger block of code.
/// - **Negative (Code Size)**: Aggressive inlining can lead to code bloat,
///   which may paradoxically decrease performance due to instruction
///   cache misses.
/// - **Limitation**: The compiler cannot currently inline methods that contain
///   `try-catch` blocks or are marked `async`, `async*`, or `sync*`.
///   Applying the pragma in these cases has no effect.
const preferInline = pragma('vm:prefer-inline');

/// **`@pragma('vm:never-inline')`**
///
/// A strict directive that forbids the compiler from inlining the annotated
/// function. This is always respected by the compiler.
///
/// ### Use Cases:
/// - **Profiling**: Ensuring a function appears as a distinct frame in a CPU
///   profile, making it easier to analyze its performance contribution.
/// - **Code Size**: Preventing a large function from being inlined at multiple
///   call sites to avoid code bloat.
/// - **Debugging**: Keeping function calls separate can sometimes lead to
///   clearer stack traces.
const neverInline = pragma('vm:never-inline');

/// **`@pragma('vm:notify-debugger-on-exception')`**
///
/// Marks a function containing a `try-catch` block. It instructs the VM to
/// notify an attached debugger of any caught exception as if it were uncaught.
///
/// ### Use Cases:
/// - Debugging code where exceptions are expected and handled, but you still
///   want the debugger to break at the point the exception is thrown. This
///   avoids having to manually set "break on all exceptions" in the debugger,
///   which can be noisy.
const notifyDebuggerOnException = pragma('vm:notify-debugger-on-exception');

/// **`@pragma('vm:invisible')`**
///
/// Marks a function to be hidden from stack traces.
///
/// ### Use Cases:
/// - Cleaning up stack traces by hiding internal framework or utility functions
///   that are not relevant to the end-user's debugging context. This makes
///   error reports more concise and easier to understand.
const invisible = pragma('vm:invisible');

/// **`@pragma('vm:deeply-immutable')`**
///
/// Asserts that a class and all its subtypes are deeply immutable. This allows
/// instances to be shared between isolates without the overhead of copying.
///
/// ### Use Cases:
/// - Creating data objects that can be passed between isolates by reference,
///   which is significantly faster than the default copy-by-value behavior.
///   This is ideal for high-performance concurrent applications.
///
/// ### Rules:
/// - The class must be `final` or `sealed`.
/// - All instance fields must be `final` and their types must also be
///   deeply immutable (e.g., `int`, `String`, `double`, other deeply immutable
///   classes).
const deeplyImmutable = pragma('vm:deeply-immutable');

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~                            UNSAFE PRAGMAS                             ~~
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// WARNING: These pragmas disable fundamental VM safety checks. Their use is
// strongly discouraged unless you have profiled your code, identified a
// critical bottleneck, and fully understand the severe risks involved.
// Misuse will lead to crashes, memory corruption, or other undefined behavior.

/// **`@pragma('vm:unsafe:no-interrupts')`**
///
/// **DANGER: EXTREMELY UNSAFE.** Removes stack overflow checks and GC safepoints
/// from a function.
///
/// ### Use Cases:
/// - (Rare) Optimizing extremely tight, short-lived, computation-bound loops
///   where the overhead of the check is a proven, significant bottleneck.
///   A known use case is in the core SDK's JSON parser.
///
/// ### Impact:
/// - **Positive (Performance)**: Can provide a small performance boost in
///   very specific, loop-heavy scenarios.
/// - **Negative (SEVERE RISK)**: A function with this pragma will never yield
///   to the VM. A long-running or infinite loop will starve the Garbage
///   Collector (leading to an out-of-memory crash) and block all inter-isolate
///   communication, potentially deadlocking the application.
const unsafeNoInterrupts = pragma('vm:unsafe:no-interrupts');

/// **`@pragma('vm:unsafe:no-bounds-checks')`**
///
/// **DANGER: EXTREMELY UNSAFE.** Removes all array/list bounds checks in AOT mode.
///
/// ### Use Cases:
/// - (Rare) Optimizing algorithms with a high volume of list/array access
///   where the logic can be mathematically proven to never access an index
///   out of bounds.
///
/// ### Impact:
/// - **Positive (Performance)**: Can significantly improve throughput for
///   array-heavy numerical code by removing the conditional check on every
///   access.
/// - **Negative (SEVERE RISK)**: If an out-of-bounds access occurs, it will
///   not throw a `RangeError`. Instead, it will cause undefined behavior,
///   leading to memory corruption, reading garbage data, or silent VM crashes.
///   This exposes your application to C-style memory safety bugs.
const unsafeNoBoundsChecks = pragma('vm:unsafe:no-bounds-checks');

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~                       FLUTTER-SPECIFIC PRAGMAS                        ~~
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// These pragmas are recognized by the Flutter build toolchain.

/// **`@pragma('flutter:keep-to-string')`**
///
/// Prevents the Flutter toolchain from stripping the `toString()` method of
/// the annotated class during release builds.
///
/// ### Use Cases:
/// - The Flutter build tools, for size optimization, can replace all `toString()`
///   implementations with a default one. However, Flutter's diagnostic tools
///   (like the Widget Inspector) rely on detailed `toString()` output from
///   classes mixed with `Diagnosticable`. This pragma ensures that the
///   custom `toString()` (and related methods like `debugFillProperties`) is
///   preserved, keeping diagnostics intact in release/profile builds.
const keepToString = pragma('flutter:keep-to-string');

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~                              EXAMPLES                                 ~~
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// This section contains non-executable examples to demonstrate pragma usage.

/*
// ignore_for_file: unused_element, unused_local_variable, dead_code

/// An example of a top-level function that would be used as an entry point
/// for a new isolate. It must be marked with `@entryPoint` to survive
/// AOT tree-shaking.
@entryPoint
void isolateEntryPoint(String message) {
  // This code runs in a separate isolate.
  print('Isolate received: $message');
}

class PragmaExamples {
  /// A small, frequently called function is a good candidate for inlining.
  @preferInline
  int _clamp(int value, int min, int max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  void processLotsOfData(List<int> data) {
    for (int i = 0; i < data.length; i++) {
      // The call to _clamp here is a candidate for inlining.
      data[i] = _clamp(data[i], 0, 255);
    }
  }

  /// A function we want to isolate for profiling. Marking it with
  /// `@neverInline` ensures it appears as a distinct call in the profiler.
  @neverInline
  void complexCalculation() {
    //... complex logic...
  }

  /// By annotating with `@notifyDebuggerOnException`, the debugger will pause
  /// on the `int.parse` line if it throws, even though we catch the exception.
  @notifyDebuggerOnException
  int? tryParseInt(String input) {
    try {
      return int.parse(input);
    } catch (e) {
      // The exception is handled, but the debugger will still break.
      return null;
    }
  }

  /// An internal helper function that we don't want to show in stack traces
  /// to reduce noise for the user of our library.
  @invisible
  void _internalHelper() {
    throw StateError('This error originated in an invisible helper.');
  }

  void publicApi() {
    // If this function calls _internalHelper and it throws, the stack trace
    // will appear to originate from `publicApi`, not `_internalHelper`.
    _internalHelper();
  }

  /// **WARNING: DANGEROUS EXAMPLE.**
  /// This demonstrates the syntax for unsafe pragmas but should NOT be used
  /// without extreme care and measurement.
  void unsafeProcessBuffer(List<int> buffer) {
    // By applying these pragmas, we are making a binding contract with the
    // compiler that this loop will NOT access out of bounds and will NOT
    // run for too long. Violating this contract will crash the app.
    @unsafeNoBoundsChecks
    @unsafeNoInterrupts
    void process() {
      for (int i = 0; i < buffer.length; i++) {
        buffer[i] *= 2;
      }
    }

    process();
  }
}

/// A simple, deeply immutable class for sharing across isolates.
@deeplyImmutable
final class SharedData {
  final String id;
  final int value;

  const SharedData(this.id, this.value);
}
*/
