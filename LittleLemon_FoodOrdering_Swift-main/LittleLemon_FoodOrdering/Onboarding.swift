//
//  Onboarding.swift
//  LittleLemon_FoodOrdering
//
//  Created by Sean Milfort on 3/22/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name keys"
let kEmail = "email key"

let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center) {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Image("logo").padding(.vertical, 20)
                TextField("First Name", text: $firstName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 20)
                TextField("Last Name", text: $lastName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 20)
                    TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 20)
                Button(action: {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    }
                }, label: {Text("Register").padding().background(Color.green).foregroundColor(.white).cornerRadius(15).frame(width: 260)})
                .onAppear{if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
                    
                }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
