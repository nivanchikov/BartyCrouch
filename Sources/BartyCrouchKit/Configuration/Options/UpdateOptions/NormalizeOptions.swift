// Created by Cihat Gündüz on 06.11.18.

import Foundation
import Toml

public struct NormalizeOptions {
    let path: String
    let sourceLocale: String
    let harmonizeWithSource: Bool
    let sortByKeys: Bool
    
    public init(path: String = ".", sourceLocale: String = "en", harmonizeWithSource: Bool = true, sortByKeys: Bool = true) {
        self.path = path
        self.sourceLocale = sourceLocale
        self.harmonizeWithSource = harmonizeWithSource
        self.sortByKeys = sortByKeys
    }
}

extension NormalizeOptions: TomlCodable {
    static func make(toml: Toml) throws -> NormalizeOptions {
        let update: String = "update"
        let normalize: String = "normalize"

        return NormalizeOptions(
            path: toml.string(update, normalize, "path") ?? ".",
            sourceLocale: toml.string(update, normalize, "sourceLocale") ?? "en",
            harmonizeWithSource: toml.bool(update, normalize, "harmonizeWithSource") ?? true,
            sortByKeys: toml.bool(update, normalize, "sortByKeys") ?? true
        )
    }

    func tomlContents() -> String {
        var lines: [String] = ["[update.normalize]"]

        lines.append("path = \"\(path)\"")
        lines.append("sourceLocale = \"\(sourceLocale)\"")
        lines.append("harmonizeWithSource = \(harmonizeWithSource)")
        lines.append("sortByKeys = \(sortByKeys)")

        return lines.joined(separator: "\n")
    }
}
