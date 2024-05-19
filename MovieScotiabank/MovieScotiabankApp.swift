//
//  MovieScotiabankApp.swift
//  MovieScotiabank
//
//  Created by user on 17/05/24.
//

import SwiftUI

@main
struct MovieScotiabankApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


