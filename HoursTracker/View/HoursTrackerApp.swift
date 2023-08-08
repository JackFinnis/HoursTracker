//
//  HoursTrackerApp.swift
//  HoursTracker
//
//  Created by Jack Finnis on 08/08/2023.
//

import SwiftUI

@main
struct HoursTrackerApp: App {
    @StateObject var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(vm)
        }
    }
}
