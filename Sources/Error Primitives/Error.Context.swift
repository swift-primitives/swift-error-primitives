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

extension Error_Primitives.Error {
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
    ///     file: .init(id: "MyModule/File.swift"),
    ///     line: 42
    /// )
    /// ```
    public struct Context: Sendable, Equatable, Hashable {
        /// The operation being performed when the error occurred.
        public let operation: Swift.String

        /// The function name where the error was captured.
        public let function: Swift.String

        /// The source file where the error was captured.
        public let file: File

        /// The line number where the error was captured.
        public let line: UInt32

        /// Creates a diagnostic context.
        ///
        /// - Parameters:
        ///   - operation: The operation being performed.
        ///   - function: The function name (typically from `#function`).
        ///   - file: The captured file identity (typically `.init(id: #fileID)`).
        ///   - line: The line number (typically from `#line`).
        @inlinable
        public init(
            operation: Swift.String,
            function: Swift.String,
            file: File,
            line: UInt32
        ) {
            self.operation = operation
            self.function = function
            self.file = file
            self.line = line
        }
    }
}

// MARK: - CustomStringConvertible

extension Error.Context: CustomStringConvertible {
    /// A textual representation of this error context.
    public var description: Swift.String {
        "\(operation) at \(function) (\(file.id):\(line))"
    }
}
