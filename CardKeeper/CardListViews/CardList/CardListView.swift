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
    @State private var selectedCard: Card?
    
    init(cardCategory: Category, year: String) {
        _cards = FetchRequest<Card>(sortDescriptors: [SortDescriptor(\.dateReceived, order: .reverse)], predicate: NSPredicate(format: "year == %@ AND category == %@", year, cardCategory.nameView))
        category = cardCategory
        self.year = year
        
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(cards) { card in
                        VStack {
                            Image(uiImage: card.frontImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(color: .black.opacity(0.6),radius: 2, x: 2, y: 2 )
                            if let family = card.family {
                                Text("\(family.nameView)")
                                    .font(.caption)
                                    .minimumScaleFactor(0.75)
                                    .lineLimit(1)
                            } else {
                                Text("\(card.cardDescriptionView)")
                                    .font(.caption)
                                    .minimumScaleFactor(0.75)
                                    .lineLimit(1)
                            }
                        }
                        .onTapGesture {
                            selectedCard = card
                        }
                    }
                }
            }
            .padding()
            if let selectedCard {
                VStack {
                    Image(uiImage: selectedCard.frontImage)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .shadow(color: .black.opacity(0.6),radius: 2, x: 2, y: 2 )
                        .padding()
                    NavigationLink {
                        Text(selectedCard.cardDescriptionView)
                    } label: {
                        Label("More Details", systemImage: "info")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    Spacer()
                }
            } else {
                Spacer()
            }
        }

//        List {
//            ForEach(cards, id: \.self) { card in
//                    VStack {
//                        HStack {
//                            Spacer()
//                            Image(uiImage: card.frontImage)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100, height: 100)
//                            Spacer()
//                        }
//                        if let family = card.family {
//                            Text(family.nameView)
//                                .font(.caption)
//                        } else {
//                            Text(card.cardDescriptionView)
//                                .font(.caption)
//                        }
//                    }
//            }
//            .onDelete(perform: removeCard)
            
//        }
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
    
//    func removeCard(at offsets: IndexSet) {
//        for index in offsets {
//            let card = cards[index]
//            moc.delete(card)
//        }
//    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(cardCategory: Category(context: CardsContainer().persistentContainer.viewContext), year: "2022")
    }
}
