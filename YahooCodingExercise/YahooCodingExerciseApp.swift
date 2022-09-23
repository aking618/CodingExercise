//
//  YahooCodingExerciseApp.swift
//  YahooCodingExercise
//
//  Created by Ayren King on 9/23/22.
//

import SwiftUI

@main
struct YahooCodingExerciseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
