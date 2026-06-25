# Error Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A throwable platform-error carrier for Swift — wraps a raw POSIX `errno` / Win32 `GetLastError` code with optional diagnostic context, with zero platform dependencies.

---

## Quick Start

`Error` is the ecosystem's transport layer for platform errors: it carries a raw `Error.Code` (the unmodified `errno` / `GetLastError` value) plus optional call-site `Error.Context`. It stores integers only — no C imports — so the same value travels unchanged from the syscall boundary through every layer that re-throws it.

```swift
import Error_Primitives

// Wrap a raw platform error code.
let notFound = Error(code: .posix(2))              // ENOENT

// Capture call-site context (operation, function, file, line) for diagnostics.
let denied = Error.capturing(.posix(13), operation: "open")   // EACCES

print(notFound.description)      // "posix(2)"
print(denied.code.posix ?? 0)    // 13
print(denied.code.isPosix)       // true
```

`Error.Code` is a two-case enum — `.posix(Int32)` and `.win32(UInt32)` — preserving Windows codes at full `UInt32` width. Higher-level packages add semantic interpretation (`Permission.Error`, `IO.Error`, …) via extensions; this package is the raw carrier they share.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-error-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Error Primitives", package: "swift-error-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Two library products, zero external dependencies.

| Product | Target | Purpose |
|---------|--------|---------|
| `Error Primitives` | `Sources/Error Primitives/` | The `Error` carrier struct + nested `Error.Code` (POSIX / Win32), `Error.Context` (diagnostic context), and `Error.File` (`#fileID`-shaped capture). |
| `Error Primitives Test Support` | `Tests/Support/` | Re-exports the main target for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |
| Swift Embedded | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
