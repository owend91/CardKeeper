//
//  FamilyFormView.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import SwiftUI

struct FamilyFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State private var name: String
    @State private var addressedAs: String
    @State private var streetAddress1: String
    @State private var streetAddress2: String
    @State private var city: String
    @State private var state: String
    @State private var country: String
    @State private var zipCode: String
    @State private var description: String
    @State var family: Family?
    
    init(family: Family) {
        self._family = State(initialValue: family)
        _name = State(initialValue: family.nameView)
        _addressedAs = State(initialValue: family.addressedAsView)
        _streetAddress1 = State(initialValue: family.streetAddress1View)
        _streetAddress2 = State(initialValue: family.streetAddress2View)
        _city = State(initialValue: family.cityView)
        _state = State(initialValue: family.stateView)
        _country = State(initialValue: family.countryView)
        _zipCode = State(initialValue: family.zipCodeView)
        _description = State(initialValue: family.descriptionView)
        
        
    }
    
    init() {
        _name = State(initialValue: "")
        _addressedAs = State(initialValue: "")
        _streetAddress1 = State(initialValue: "")
        _streetAddress2 = State(initialValue: "")
        _city = State(initialValue: "")
        _state = State(initialValue: "")
        _country = State(initialValue: "")
        _zipCode = State(initialValue: "")
        _description = State(initialValue: "")
    }
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("About") {
                    TextField("Name", text: $name)
                    TextField("Addressed As", text: $addressedAs)
                    TextField("Description", text: $description, axis: .vertical)
                }
                
                Section("Address") {
                    TextField("Street Address 1", text: $streetAddress1)
                    TextField("Street Address 2", text: $streetAddress2)
                    TextField("City", text: $city)
                    TextField("State", text: $state)
                    TextField("Country", text: $country)
                    TextField("Zip Code", text: $zipCode)
                    
                }
                Button {
                    saveFamily()
                } label: {
                    HStack {
                        Spacer()
                        Text(family == nil ? "Save" : "Update")
                        Spacer()
                    }
                }
            }
            .navigationTitle("Add Family")
            .toolbar {
                if family == nil {
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
    }
    
    func saveFamily() {
        if let family {
            family.name = name
            family.addressedAs = addressedAs
            family.familyDescription = description
            family.streetAddress1 = streetAddress1
            family.streetAddress2 = streetAddress2
            family.city = city
            family.state = state
            family.country = country
            family.zipCode = zipCode

        } else {
            let newFamily = Family(context: moc)
            newFamily.name = name
            newFamily.addressedAs = addressedAs
            newFamily.familyDescription = description
            newFamily.streetAddress1 = streetAddress1
            newFamily.streetAddress2 = streetAddress2
            newFamily.city = city
            newFamily.state = state
            newFamily.country = country
            newFamily.zipCode = zipCode
            
        }
        
        try? moc.save()
        dismiss()
    }
}

struct FamilyFormView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyFormView()
    }
}
