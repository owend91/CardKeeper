//
//  CardListView.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import SwiftUI

struct CardYearListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.year, order: .reverse)])
    private var years: FetchedResults<Year>
    
    @State private var addYear = false
    @State private var year = ""
//    @State private var navigationPath: NavigationPath = NavigationPath()
    var body: some View {
        NavigationStack {
            List {
                ForEach(years, id: \.self) { year in
                    NavigationLink(year.yearView, destination: CardCategoryListView(cardYear: year))
                }
            }
            .navigationTitle("Card Years")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addYear.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .alert("Add year", isPresented: $addYear) {
                TextField("Year", text: $year)
                    .keyboardType(.numberPad)
    
                Button {
                    if years.filter({ $0.yearView == year }).count == 0 && !year.isEmpty {
                        let newYear = Year(context: moc)
                        newYear.year = year
                        try? moc.save()
                        year = ""
                    }
 
//                    dismiss()
                } label: {
                    Text("OK")
                }
                Button("Cancel", role: .cancel) {
                    year = ""
                }
            } message: {
                Text("Please enter a new year")
            }
           

        }
    }
}

struct CardYearListView_Previews: PreviewProvider {
    static var previews: some View {
        CardYearListView()
    }
}
