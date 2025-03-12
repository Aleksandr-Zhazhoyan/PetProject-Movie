//
//  ProjectMovieApp.swift
//  ProjectMovieApp
//
//  Created by Aleksandr Zhazhoyan on 23.02.2025.
//

import SwiftUI
import Firebase


@main
struct ProjectMovieApp: App {
    let persistenceController = PersistenceController.shared
    private let networkService = NetworkService()
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            
            MainTabView(networkService: networkService)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(router)
                .environmentObject(AlertManager.shared)
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            
            FirebaseApp.configure()
            
            return true
        }
    }
}
