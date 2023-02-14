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
    @State private var backImage: UIImage?
    @State private var takeBackImage = false
    @State private var dateReceived = Date()
    
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
                Section("Details") {
                    Picker("Family", selection: $family) {
                        ForEach(familyOptions) { familyOpt in
                            Text(familyOpt.nameView)
                        }
                    }
                    .pickerStyle(.menu)
                    .onAppear {
                        if let firstFamily = familyOptions.first {
                            family = firstFamily
                        }
                    }
                    
                    TextField("Description", text: $description, axis: .vertical)
                    DatePicker("Date Received", selection: $dateReceived, displayedComponents: .date)
                }

                Section("Pictures"){
                    HStack {
                        Text("Front Of Card")
                        Spacer()
                        
                        if let frontImage {
                            Image(uiImage: frontImage)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Button {
                                takeFrontImage.toggle()
                            } label: {
                                Image(systemName: "camera")
                            }
                        }
                    }
                    .sheet(isPresented: $takeFrontImage) {
                        Camera(selectedImage: $frontImage)
                    }
                    
                    HStack {
                        Text("Back Of Card")
                        Spacer()
                        
                        if let backImage {
                            Image(uiImage: backImage)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Button {
                                takeBackImage.toggle()
                            } label: {
                                Image(systemName: "camera")
                            }
                        }
                    }
                    .sheet(isPresented: $takeBackImage) {
                        Camera(selectedImage: $backImage)
                    }
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
        card.dateReceived = dateReceived
        if let frontImage = frontImage, let compressedImage = frontImage.jpegData(compressionQuality: 0.2) {
            card.cardFrontImage = UIImage(data: compressedImage)
        }
        if let backImage = backImage, let compressedImage = backImage.jpegData(compressionQuality: 0.2) {
            card.cardBackImage = UIImage(data: compressedImage)
        }
//        card.cardFrontImage = frontImage?.jpegData(compressionQuality: 0.2) as! UIImage
//        card.cardBackImage = backImage?.jpegData(compressionQuality: 0.2) as! UIImage
        try? moc.save()
        
//        if let frontImage {
//            FileManager().saveImage(with: frontCardId, image: frontImage)
//        }
        dismiss()
    }
}

struct CardFormView_Previews: PreviewProvider {
    static var previews: some View {
        CardFormView()
    }
}
