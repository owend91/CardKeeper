//
//  FamilyAddressView.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import SwiftUI

struct FamilyAddressView: View {
    
//    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var families: FetchedResults<Family>
    
    @State private var addFamily = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(families, id: \.self) { family in
                    NavigationLink(family.nameView, destination: FamilyFormView(family: family))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addFamily.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .sheet(isPresented: $addFamily) {
                FamilyFormView()
            }
        }
    }
}

struct FamilyAddressView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyAddressView()
    }
}
