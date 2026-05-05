/*
 ContentView.swift
 UserInterface

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

import Model
import SwiftUI

struct ContentView: View {
    @StateObject var store: ContentStore

    var body: some View {
        List {
            Section {
                LabeledContent("App Name", value: store.appName)
                LabeledContent("App Version", value: store.appVersion)
            } header: {
                Text("Environment")
            }
            Section {
                LabeledContent("Counter: \(store.count)") {
                    Button("Add") {
                        Task { await store.send(.plusButtonTapped) }
                    }
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.isEnabled },
                    asyncSet: { await store.send(.isEnabledToggleSwitched($0)) }
                )) {
                    Text("Flag")
                }
            } header: {
                Text("Sample Action")
            }
        }
        .task {
            await store.send(.task(String(describing: Self.self)))
        }
    }
}

extension ContentStore: ObservableObject {}
