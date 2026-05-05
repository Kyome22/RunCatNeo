/*
 AppDependencies.swift
 Model

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

import DataSource
import SwiftUI

public final class AppDependencies: Sendable {
    public let appStateClient: AppStateClient
    public let loggingSystemClient: LoggingSystemClient
    public let userDefaultsClient: UserDefaultsClient

    nonisolated init(
        appStateClient: AppStateClient = .liveValue,
        loggingSystemClient: LoggingSystemClient = .liveValue,
        userDefaultsClient: UserDefaultsClient = .liveValue
    ) {
        self.appStateClient = appStateClient
        self.loggingSystemClient = loggingSystemClient
        self.userDefaultsClient = userDefaultsClient
    }

    static let shared = AppDependencies()
}

extension EnvironmentValues {
    @Entry public var appDependencies = AppDependencies.shared
}

extension AppDependencies {
    public static func testDependencies(
        appStateClient: AppStateClient = .testValue,
        loggingSystemClient: LoggingSystemClient = .testValue,
        userDefaultsClient: UserDefaultsClient = .testValue
    ) -> AppDependencies {
        AppDependencies(
            appStateClient: appStateClient,
            loggingSystemClient: loggingSystemClient,
            userDefaultsClient: userDefaultsClient
        )
    }
}
