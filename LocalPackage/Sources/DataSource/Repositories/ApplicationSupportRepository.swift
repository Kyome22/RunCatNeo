/*
 ApplicationSupportRepository.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Koyme22 (Takuto Nakamura)

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation

public struct ApplicationSupportRepository: Sendable {
    private var dataClient: DataClient
    private var fileManagerClient: FileManagerClient
    private var appDirectoryURL: URL

    public init(
        _ dataClient: DataClient,
        _ fileManagerClient: FileManagerClient
    ) {
        self.dataClient = dataClient
        self.fileManagerClient = fileManagerClient

        let url = fileManagerClient
            .urls(.applicationSupportDirectory, .userDomainMask)
            .first?
            .appending(path: "RunCatNeo", directoryHint: .isDirectory)
            .absoluteURL
        guard let url else {
            fatalError("Failed to get application support directory.")
        }
        self.appDirectoryURL = url

        guard !fileManagerClient.fileExists(url.path(percentEncoded: false)) else {
            return
        }
        do {
            try fileManagerClient.createDirectory(url, true)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
