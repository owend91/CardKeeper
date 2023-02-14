//
//  CardCategoryListView.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import SwiftUI

struct CardCategoryListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    var cardYear: Year
    
    @State private var addCategory = false
    @State private var category = ""

    
    var body: some View {
        List {
            ForEach(cardYear.categoryArray, id: \.self) { category in
                NavigationLink(category.nameView, destination: CardListView(cardCategory: category, year: cardYear.yearView))
//                Text(category.nameView)
            }
        }
        
        .navigationTitle("\(cardYear.yearView)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addCategory.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .alert("Add category", isPresented: $addCategory) {
            TextField("Year", text: $category)
            Button {
                if cardYear.categoryArray.filter({ $0.nameView == category }).count == 0 && !category.isEmpty{
                    let newCategory = Category(context: moc)
                    newCategory.name = category
                    newCategory.year = cardYear
                    try? moc.save()
                }
            } label: {
                Text("OK")
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please enter a new category")
        }
    }
}

struct CardCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CardCategoryListView(cardYear: Year(context: CardsContainer().persistentContainer.viewContext))
    }
}
