//
//  Menu.swift
//  LittleLemon_FoodOrdering
//
//  Created by Sean Milfort on 3/22/23.
//

import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
    @State var starters = true
    @State var desserts = true
    @State var drinks = true
    @State var mains = true
    
    
    var body: some View {
        VStack{
            Hero()
            VStack(alignment: .leading, spacing: 8) {
                Text("Little Lemon").foregroundColor(Color(red: 0.5191, green: 0.4383, blue: 0.00426)).font(.system(size:40)).padding(.horizontal, 10)
                HStack {
                    VStack(alignment: .leading){
                        Text("Chicago").foregroundColor(Color.white).font(.system(size: 20)).padding(.leading, 10).padding(.bottom, 10)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.").padding(.leading, 10)
                    }
                    Image("sample-food").resizable().aspectRatio(contentMode: .fit).cornerRadius(15).frame(width: 175, height: 150)
                }
                TextField("Search menu", text: $searchText).textFieldStyle(RoundedBorderTextFieldStyle()).padding(10)
            }.background(Color(red: 0.2874, green: 0.3701, blue: 0.3425)).frame(alignment: .leading)
            Text("Order for Delivery!").frame(alignment: .leading)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing:10) {
                    Toggle("Starters", isOn: $starters).toggleStyle(.button).tint(.blue).padding(.leading, 10)
                    Toggle("Mains", isOn: $mains).toggleStyle(.button).tint(.blue)
                    Toggle("Drinks", isOn: $drinks).toggleStyle(.button).tint(.blue)
                    Toggle("Desserts", isOn: $desserts).toggleStyle(.button).tint(.blue)
                }
            }
            FetchedObjects(predicate: buildPredicate(),sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    if dishes.count != 0 {
                        ForEach(dishes, id: \.self) { dish in
                                HStack{
                                    VStack (alignment: .leading){
                                        Text(dish.title!).font(Font.headline.weight(.bold))
                                        Spacer()
                                        Text("$" + dish.price!)
                                    }
                                    Spacer()
                                    AsyncImage(url: URL(string: dish.image!)) {image in image.resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 100)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            
                        }
                    }
                }
            }
        }.onAppear{
            getMenuData()
        }
    }
    
    func getMenuData() {
        
        PersistenceController.shared.clear()
        
        let url = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let URLData = URL(string: url)!
        let request = URLRequest(url: URLData)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data {
                let jsonDecoder = JSONDecoder()
                let decoded = try? jsonDecoder.decode( MenuList.self, from: data)
                if let decoded {
                    for menuItem in decoded.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.price = menuItem.price
                        dish.image = menuItem.image
                        dish.category = menuItem.category
                    }
                    try? viewContext.save()
                }
                
            }
        }
        task.resume()
    }
            
    
    func buildSortDescriptors () -> [NSSortDescriptor] {
        return [NSSortDescriptor (key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() ->
            NSCompoundPredicate {
                    let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
                    let starters = !starters ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
                    let mains = !mains ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
                    let desserts = !desserts ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
                    let drinks = !drinks ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)

                    let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
                    return compoundPredicate
                }
        }
    

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
