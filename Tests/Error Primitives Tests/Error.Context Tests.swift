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

import Error_Primitives
import Testing

@Suite
struct `Error.Context Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Error.Context Tests`.Unit {

    @Test
    func `Context storage`() {
        let context = Error.Context(
            operation: "open",
            function: "readFile()",
            file: .init(id: "MyModule/File.swift"),
            line: 42
        )

        #expect(context.operation == "open")
        #expect(context.function == "readFile()")
        #expect(context.file.id == "MyModule/File.swift")
        #expect(context.line == 42)
    }

    @Test
    func `Context description`() {
        let context = Error.Context(
            operation: "write",
            function: "saveData()",
            file: .init(id: "Storage/Writer.swift"),
            line: 100
        )

        #expect(context.description == "write at saveData() (Storage/Writer.swift:100)")
    }
}
