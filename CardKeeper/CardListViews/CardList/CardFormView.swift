//
//  CardFormView.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import SwiftUI

struct CardFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State private var description = ""
    @State private var category = ""
    @State private var year = ""
    @State private var family: Family?
    @State private var frontImage: UIImage?
    @State private var takeFrontImage = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var familyOptions: FetchedResults<Family>
    
    init(year: String, category: String){
        self._year = State(initialValue: year)

        self._category = State(initialValue: category)
    }
    
    init(){}
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Family", selection: $family) {
                    ForEach(familyOptions) { familyOpt in
                        Text(familyOpt.nameView)
                    }
                }
                .pickerStyle(.menu)
                
                HStack {
                    Text("Front Of Card")
                    Spacer()
                    Button {
                        takeFrontImage.toggle()
                    } label: {
                        Image(systemName: "camera")
                    }
                    Spacer()
                    if let frontImage {
                        Image(uiImage: frontImage)
                            .resizable()
                            .scaledToFit()
                    }
                    
                }
                .sheet(isPresented: $takeFrontImage) {
                    Camera(selectedImage: $frontImage)
                }
                
                Button {
                    saveCard()
                } label: {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }
                
                
//                Button {
//                    saveFamily()
//                } label: {
//                    HStack {
//                        Spacer()
//                        Text("Save")
//                        Spacer()
//                    }
//                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color.black)
                    }
                }
                
            }
        }
    }
    
    func saveCard() {
        let frontCardId = UUID().uuidString
        let card = Card(context: moc)
        card.family = family
        card.cardDescription = description
        card.year = year
        card.category = category
        card.frontId = frontCardId
        try? moc.save()
        
        if let frontImage {
            FileManager().saveImage(with: frontCardId, image: frontImage)
        }
        dismiss()
    }
}

struct CardFormView_Previews: PreviewProvider {
    static var previews: some View {
        CardFormView()
    }
}
