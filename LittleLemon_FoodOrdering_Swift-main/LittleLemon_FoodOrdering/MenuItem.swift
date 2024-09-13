//
//  MenuItem.swift
//  LittleLemon_FoodOrdering
//
//  Created by Sean Milfort on 3/23/23.
//

import SwiftUI

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    let category: String
}
