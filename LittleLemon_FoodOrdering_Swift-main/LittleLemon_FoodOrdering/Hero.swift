//
//  Hero.swift
//  LittleLemon_FoodOrdering
//
//  Created by Sean Milfort on 3/23/23.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        HStack {
            Image("logo").frame(alignment: .center)
            Image("profile-image-placeholder").resizable().aspectRatio(contentMode: .fit).frame(height: 60, alignment: .leading)
        }.frame(height:80, alignment: .center)
    }
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
    }
}
