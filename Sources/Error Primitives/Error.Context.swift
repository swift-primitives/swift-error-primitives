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
    /// Diagnostic context for error debugging.
    ///
    /// Captures call-site information when an error is created, providing
    /// valuable debugging information without affecting error identity.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let context = Error.Context(
    ///     operation: "open",
    ///     function: "readFile",
    ///     fileID: "MyModule/File.swift",
    ///     line: 42
    /// )
    /// ```
    public struct Context: Sendable, Equatable, Hashable {
        /// The operation being performed when the error occurred.
        public let operation: Swift.String

        /// The function name where the error was captured.
        public let function: Swift.String

        /// The file ID where the error was captured.
        public let fileID: Swift.String

        /// The line number where the error was captured.
        public let line: UInt32

        /// Creates a diagnostic context.
        ///
        /// - Parameters:
        ///   - operation: The operation being performed.
        ///   - function: The function name (typically from `#function`).
        ///   - fileID: The file ID (typically from `#fileID`).
        ///   - line: The line number (typically from `#line`).
        @inlinable
        public init(
            operation: Swift.String,
            function: Swift.String,
            fileID: Swift.String,
            line: UInt32
        ) {
            self.operation = operation
            self.function = function
            self.fileID = fileID
            self.line = line
        }
    }
}

// MARK: - CustomStringConvertible

extension Error.Context: CustomStringConvertible {
    public var description: Swift.String {
        "\(operation) at \(function) (\(fileID):\(line))"
    }
}
