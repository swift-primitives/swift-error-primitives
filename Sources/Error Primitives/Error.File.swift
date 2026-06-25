// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-error-primitives open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-error-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension Error_Primitives.Error {
    /// File identity captured at an error's call site.
    ///
    /// Wraps the `#fileID` magic-identifier string in a typed value so
    /// the captured surface is `error.context.file.id`, not a bare
    /// compound `fileID` field. The string format follows Swift's
    /// `#fileID` convention: `"ModuleName/FileName.swift"`.
    public struct File: Sendable, Equatable, Hashable {
        /// The `#fileID`-shaped identifier (`"Module/File.swift"`).
        public let id: Swift.String

        /// Creates a file identity from a `Swift.String` value.
        @inlinable
        public init(id: Swift.String) {
            self.id = id
        }
    }
}

// MARK: - StaticString convenience

extension Error_Primitives.Error.File {
    /// Creates a file identity from a `StaticString` (the type produced
    /// by `#fileID`).
    @inlinable
    public init(id: StaticString) {
        self.init(id: Swift.String(describing: id))
    }
}
