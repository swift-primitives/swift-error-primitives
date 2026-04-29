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

/// A throwable error carrying a raw platform error code.
///
/// This is the transport layer for platform errors in the ecosystem.
/// It wraps ``Code`` (the raw errno/GetLastError value) and can be
/// thrown directly or used as the fallback case in operation-specific
/// typed errors.
///
/// Semantic interpretation is provided by higher-level packages via
/// extensions and the domain error types (`Permission.Error`,
/// `IO.Error`, etc.).
///
/// ## Usage
///
/// ```swift
/// // Throwing a raw platform error
/// throw Error(code: .posix(EIO))
///
/// // With context for debugging
/// throw Error.capturing(.posix(EIO), operation: "read")
/// ```
///
/// ## Types
///
/// - ``Code``: Unified platform error code (POSIX errno / Win32 GetLastError)
/// - ``Context``: Diagnostic context for debugging
public struct Error: Swift.Error, Sendable, Equatable, Hashable {

    /// The raw platform error code.
    public let code: Code

    /// Optional diagnostic context.
    public let context: Context?

    /// Creates an error from a platform code.
    @inlinable
    public init(code: Code, context: Context? = nil) {
        self.code = code
        self.context = context
    }

    /// Creates an error capturing call-site context.
    @inlinable
    public static func capturing(
        _ code: Code,
        operation: StaticString,
        function: StaticString = #function,
        fileID: StaticString = #fileID,
        line: UInt32 = #line
    ) -> Self {
        Self(code: code, context: Context(
            operation: Swift.String(describing: operation),
            function: Swift.String(describing: function),
            fileID: Swift.String(describing: fileID),
            line: line
        ))
    }
}

// MARK: - CustomStringConvertible

extension Error: CustomStringConvertible {
    public var description: Swift.String {
        if let context {
            return "\(context.operation): \(code) at \(context.function) (\(context.fileID):\(context.line))"
        }
        return "\(code)"
    }
}
