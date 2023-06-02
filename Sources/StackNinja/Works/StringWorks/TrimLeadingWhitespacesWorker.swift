//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 02.06.2023.
//

import ReactiveWorks

public final class TrimLeadingWhitespacesWorker: WorkerProtocol {
    public init() {}

    public func doAsync(work: Work<String, String>) {
        let text = work.unsafeInput

        work.success(result: removeLeadingSpaces(string: text))
    }

    private func removeLeadingSpaces(string: String) -> String {
        String(string.dropFirst(string.prefix { $0.isWhitespace }.count))
    }
}
