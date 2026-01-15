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

import Testing
import Error_Primitives

@Suite("Error.Code Tests")
struct ErrorCodeTests {
    @Test("POSIX code storage")
    func posixCode() {
        let code = Error.Code.posix(2) // ENOENT
        #expect(code.posixValue == 2)
        #expect(code.win32Value == nil)
        #expect(code.isPosix)
        #expect(!code.isWin32)
    }

    @Test("Win32 code storage")
    func win32Code() {
        let code = Error.Code.win32(2) // ERROR_FILE_NOT_FOUND
        #expect(code.win32Value == 2)
        #expect(code.posixValue == nil)
        #expect(code.isWin32)
        #expect(!code.isPosix)
    }

    @Test("Code equality")
    func equality() {
        let a = Error.Code.posix(1)
        let b = Error.Code.posix(1)
        let c = Error.Code.posix(2)
        let d = Error.Code.win32(1)

        #expect(a == b)
        #expect(a != c)
        #expect(a != d) // Different enum cases
    }

    @Test("Code description")
    func description() {
        let posix = Error.Code.posix(13)
        let win32 = Error.Code.win32(5)

        #expect(posix.description == "posix(13)")
        #expect(win32.description == "win32(5)")
    }
}

@Suite("Error.Context Tests")
struct ErrorContextTests {
    @Test("Context storage")
    func contextStorage() {
        let context = Error.Context(
            operation: "open",
            function: "readFile()",
            fileID: "MyModule/File.swift",
            line: 42
        )

        #expect(context.operation == "open")
        #expect(context.function == "readFile()")
        #expect(context.fileID == "MyModule/File.swift")
        #expect(context.line == 42)
    }

    @Test("Context description")
    func contextDescription() {
        let context = Error.Context(
            operation: "write",
            function: "saveData()",
            fileID: "Storage/Writer.swift",
            line: 100
        )

        #expect(context.description == "write at saveData() (Storage/Writer.swift:100)")
    }
}
