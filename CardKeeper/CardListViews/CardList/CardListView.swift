//
//  CardListView.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import SwiftUI

struct CardListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    

    @FetchRequest var cards: FetchedResults<Card>
    
    var category: Category
    var year: String
    @State private var addCard = false
    
    init(cardCategory: Category, year: String) {
        _cards = FetchRequest<Card>(sortDescriptors: [SortDescriptor(\.dateReceived, order: .reverse)], predicate: NSPredicate(format: "year == %@ AND category == %@", year, cardCategory.nameView))
        category = cardCategory
        self.year = year
        
    }
    
    var body: some View {

        List(cards, id: \.self) { card in
            VStack {
                HStack {
                    Spacer()
                    Image(uiImage: card.frontImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Spacer()
                }
                Text(card.cardDescription!)
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addCard.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .sheet(isPresented: $addCard) {
            CardFormView(year: year, category: category.nameView)
        }
        .navigationTitle("\(category.nameView) Cards")
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(cardCategory: Category(context: CardsContainer().persistentContainer.viewContext), year: "2022")
    }
}
