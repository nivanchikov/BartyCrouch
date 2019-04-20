// Created by Cihat Gündüz on 06.11.18.

import Foundation
import Toml

public struct InterfacesOptions {
    let path: String
    let defaultToBase: Bool
    let ignoreEmptyStrings: Bool
    let unstripped: Bool
    
    public init(path: String = ".", defaultToBase: Bool = false, ignoreEmptyStrings: Bool = false, unstripped: Bool = false) {
        self.path = path
        self.defaultToBase = defaultToBase
        self.ignoreEmptyStrings = ignoreEmptyStrings
        self.unstripped = unstripped
    }
}

extension InterfacesOptions: TomlCodable {
    static func make(toml: Toml) throws -> InterfacesOptions {
        let update: String = "update"
        let interfaces: String = "interfaces"

        return InterfacesOptions(
            path: toml.string(update, interfaces, "path") ?? ".",
            defaultToBase: toml.bool(update, interfaces, "defaultToBase") ?? false,
            ignoreEmptyStrings: toml.bool(update, interfaces, "ignoreEmptyStrings") ?? false,
            unstripped: toml.bool(update, interfaces, "unstripped") ?? false
        )
    }

    func tomlContents() -> String {
        var lines: [String] = ["[update.interfaces]"]

        lines.append("path = \"\(path)\"")
        lines.append("defaultToBase = \(defaultToBase)")
        lines.append("ignoreEmptyStrings = \(ignoreEmptyStrings)")
        lines.append("unstripped = \(unstripped)")

        return lines.joined(separator: "\n")
    }
}
