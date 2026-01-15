// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-error-primitives open source project
//
// Copyright (c) 2024 Coen ten Thije Boonkkamp and the swift-error-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

/// Namespace for error primitives.
///
/// This module provides platform-agnostic error types that can be used
/// across different packages without introducing C dependencies.
///
/// ## Types
///
/// - ``Error/Code``: Unified platform error code (POSIX errno / Win32 GetLastError)
/// - ``Error/Context``: Diagnostic context for debugging
public enum Error {}
