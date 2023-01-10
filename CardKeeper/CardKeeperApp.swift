//
//  CardKeeperApp.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import SwiftUI

@main
struct CardKeeperApp: App {
    let moc = CardsContainer().persistentContainer.viewContext
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environment(\.managedObjectContext, moc)
        }
    }
}
