//
//  CardDetailView.swift
//  CardKeeper
//
//  Created by David Owen on 2/14/23.
//

import SwiftUI

struct CardDetailView: View {
    @Binding var selectedCard: Card?
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        VStack {
            if let selectedCard {
                Text(selectedCard.cardDescriptionView)
                
                Button {
                    moc.delete(selectedCard)
                    self.selectedCard = nil
                    try? moc.save()
                    dismiss()
                } label: {
                    Text("Delete Card")
                    
                }
            }
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(selectedCard: .constant(Card()))
    }
}
