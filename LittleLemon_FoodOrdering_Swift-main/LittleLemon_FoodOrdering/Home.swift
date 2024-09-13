//
//  Home.swift
//  LittleLemon_FoodOrdering
//
//  Created by Sean Milfort on 3/22/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView{
            Menu().environment(\.managedObjectContext, persistence.container.viewContext).tabItem({Label("Menu", systemImage: "list.dash")})
            UserProfile().tabItem({Label("Profile", systemImage: "square.and.pencil")})
            
        }.navigationBarBackButtonHidden(true)
    }
    let persistence = PersistenceController.shared
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
