/*
 RunCatNeoApp.swift
 RunCatNeo

 Created by Takuto Nakamura on 2026/01/15.
*/

import Model
import SwiftUI
import UserInterface

@main
struct RunCatNeoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        ContentScene()
    }
}
