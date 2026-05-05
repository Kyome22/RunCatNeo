/*
 ContentStore.swift
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
import Observation
import SwiftUI

@MainActor @Observable
public final class ContentStore: Composable {
    private let appStateClient: AppStateClient
    private let userDefaultsRepository: UserDefaultsRepository
    private let logService: LogService

    public var appName: String
    public var appVersion: String
    public var count: Int
    public var isEnabled: Bool
    public let action: (Action) async -> Void

    public init(
        _ appDependencies: AppDependencies,
        appName: String = "",
        appVersion: String = "",
        count: Int = .zero,
        isEnabled: Bool = false,
        action: @escaping (Action) async -> Void = { _ in }
    ) {
        self.appStateClient = appDependencies.appStateClient
        self.userDefaultsRepository = .init(appDependencies.userDefaultsClient)
        self.logService = .init(appDependencies)
        self.appName = appName
        self.appVersion = appVersion
        self.count = count
        self.isEnabled = isEnabled
        self.action = action
    }

    public func reduce(_ action: Action) async {
        switch action {
        case let .task(screenName):
            logService.notice(.screenView(name: screenName))
            appName = appStateClient.withLock(\.name)
            appVersion = appStateClient.withLock(\.version)
            isEnabled = userDefaultsRepository.isEnabled

        case .plusButtonTapped:
            count += 1

        case let .isEnabledToggleSwitched(isEnabled):
            self.isEnabled = isEnabled
            userDefaultsRepository.isEnabled = isEnabled
        }
    }

    public enum Action: Sendable {
        case task(String)
        case plusButtonTapped
        case isEnabledToggleSwitched(Bool)
    }
}
