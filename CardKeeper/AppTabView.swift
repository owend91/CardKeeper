//
//  AppTabView.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            CardYearListView()
                .tabItem {
                    Label("Card", systemImage: "greetingcard")

                }
            FamilyAddressView()
                .tabItem {
                    Label("Address", systemImage: "figure.2.and.child.holdinghands")

                }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
