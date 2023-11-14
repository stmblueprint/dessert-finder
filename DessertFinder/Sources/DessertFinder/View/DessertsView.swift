//
//  ContentView.swift
//  DessertFinder
//
//  Created by Aaron Tulloch on 11/6/23.
//

import SwiftUI

struct DessertsView: View {
    @State private var desserts: [Desserts] = [] // original data
    @State private var filteredDesserts: [Desserts] = [] // array to filter data
    
    @State private var showDetails = false // nav to next view if true
    @State private var currentId = ""
    @State private var searchText = "" // search query

    var body: some View {
        NavigationStack {
            VStack {
                // MARK: search field
                TextField("Search for desserts", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .overlay{ // magnifying icon in the search field
                        if !searchText.isEmpty{
                            Button{
                                searchText = ""
                            }label: {
                                HStack {
                                    Spacer()
                                    Text("cancel")
                                        .padding(.trailing, 30)
                                        .foregroundStyle(.blue)
                                    
                                }
                            }
                        } else{
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .padding(.trailing, 30)
                                    .opacity(0.3)
                            }
                                
                        }
                    }

                // MARK: list of sorted desserts in alphabetical order
                List(filteredDesserts.sorted(by: { $0.strMeal < $1.strMeal }), id: \.idMeal) { dessert in
                    
                    // nav to DetailView
                    Button {
                        showDetails.toggle()
                        currentId = dessert.idMeal // binding meal id for meal details api param
                    } label: {
                        HStack {
                            Text(dessert.strMeal) // dessert name
                                .foregroundStyle(.black)
                                .frame(width: 100, height: 100)

                            Spacer() // push information to the trailing and leading edge of the HStack

                            // dessert image or show a progress icon until information is found
                            AsyncImage(url: URL(string: dessert.strMealThumb)) { image in
                                image.resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            // MARK: nav to DessertDetailsView when showDetails = true
            .navigationDestination(isPresented: $showDetails) {
                DessertDetailsView(currentId: $currentId)
            }
        }
        // MARK: fetch desserts data from the endpoint when the view appear
        .onAppear {
            Task {
                do {
                    let result = try await fetchDessertsCategory() // func that fetches endpoint data
                    desserts = result.meals
                    filterDesserts() // func that filters the desserts
                } catch {
                    print("Error fetching desserts: \(error)")
                }
            }
        }
        .onChange(of: searchText) {
            filterDesserts() // Re-filter desserts array when the search text changes
        }
    }
    
    // MARK: filter desserts data
    func filterDesserts() {
        filteredDesserts = desserts.filter { dessert in
            
            /* 
               continue to display desserts if the field is empty or
               if dessert contains the searchText
             
             */
            searchText.isEmpty || dessert.strMeal
                .lowercased()
                .contains(searchText.lowercased())
        }
    }
}

// MARK: Canvas Preview
#Preview {
    DessertsView()
}
