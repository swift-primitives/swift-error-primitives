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

extension Error {
    /// Unified platform error code (errno / Win32 last-error).
    ///
    /// Data-only: stores the raw platform error code without any platform dependencies.
    /// The code is captured at the syscall boundary and preserved throughout the error chain.
    ///
    /// ## Design Principles
    /// - **Capture once**: Raw platform code captured at syscall boundary, never re-derived.
    /// - **No loss of information**: Windows codes remain `UInt32`-accurate end-to-end.
    /// - **Data-only**: This is NOT `Swift.Error`; prevents accidental "throw raw code".
    /// - **Platform-agnostic**: No C imports; just stores integers.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// // Create from POSIX errno value
    /// let code = Error.Code.posix(ENOENT)
    ///
    /// // Create from Windows GetLastError value
    /// let code = Error.Code.win32(ERROR_FILE_NOT_FOUND)
    /// ```
    public enum Code: Sendable, Equatable, Hashable {
        /// POSIX errno value.
        case posix(Int32)

        /// Windows GetLastError value.
        case win32(UInt32)
    }
}

// MARK: - Typed Accessors

extension Error.Code {
    /// The POSIX errno value, if this is a POSIX error.
    @inlinable
    public var posixValue: Int32? {
        if case .posix(let v) = self { v } else { nil }
    }

    /// The Win32 error code, if this is a Windows error.
    @inlinable
    public var win32Value: UInt32? {
        if case .win32(let v) = self { v } else { nil }
    }

    /// Whether this is a POSIX error.
    @inlinable
    public var isPosix: Bool {
        if case .posix = self { true } else { false }
    }

    /// Whether this is a Windows error.
    @inlinable
    public var isWin32: Bool {
        if case .win32 = self { true } else { false }
    }
}

// MARK: - CustomStringConvertible

extension Error.Code: CustomStringConvertible {
    public var description: Swift.String {
        switch self {
        case .posix(let code):
            return "posix(\(code))"
        case .win32(let code):
            return "win32(\(code))"
        }
    }
}
