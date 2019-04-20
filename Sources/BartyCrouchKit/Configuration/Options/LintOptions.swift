// Created by Cihat Gündüz on 06.11.18.

import Foundation
import MungoHealer
import Toml

public struct LintOptions {
    let path: String
    let duplicateKeys: Bool
    let emptyValues: Bool
    
    public init(
        path: String = ".",
        duplicateKeys: Bool = true,
        emptyValues: Bool = true) {
        self.path = path
        self.duplicateKeys = duplicateKeys
        self.emptyValues = emptyValues
    }
}

extension LintOptions: TomlCodable {
    static func make(toml: Toml) throws -> LintOptions {
        let lint: String = "lint"

        return LintOptions(
            path: toml.string(lint, "path") ?? ".",
            duplicateKeys: toml.bool(lint, "duplicateKeys") ?? true,
            emptyValues: toml.bool(lint, "emptyValues") ?? true
        )
    }

    func tomlContents() -> String {
        var lines: [String] = ["[lint]"]

        lines.append("path = \"\(path)\"")
        lines.append("duplicateKeys = \(duplicateKeys)")
        lines.append("emptyValues = \(emptyValues)")

        return lines.joined(separator: "\n")
    }
}
