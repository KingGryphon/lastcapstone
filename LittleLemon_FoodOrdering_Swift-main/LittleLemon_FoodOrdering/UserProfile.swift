//
//  UserProfile.swift
//  LittleLemon_FoodOrdering
//
//  Created by Sean Milfort on 3/22/23.
//

import SwiftUI

struct UserProfile: View {
    
    let userFirstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let userLastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let userEmail = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            Hero()
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(userFirstName)
            Text(userLastName)
            Text(userEmail)
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }, label: {Text("Logout")})
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
