//
//  ContentView.swift
//  DessertFinder
//
//  Created by Aaron Tulloch on 11/6/23.
//

import SwiftUI

struct DessertsView: View {
    @State private var desserts: [Desserts] = []
    @State private var filteredDesserts: [Desserts] = []
    @State private var showDetails = false
    @State private var currentId = ""
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                SearchField(searchText: $searchText)

                DessertsList(desserts: $filteredDesserts, showDetails: $showDetails, currentId: $currentId)

            }
            .navigationDestination(isPresented: $showDetails) {
                DessertDetailsView(currentId: $currentId)
            }
        }
        .onAppear {
            Task {
                
                do {
                    let result: DessertsAPIModel = try await NetworkingManager.shared.fetchData(from: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")
                    desserts = result.meals
                    filterDesserts()
                    // Handle the result
                } catch {
                    print("Error fetching desserts: \(error)")
                }
                
            }
        }
        .onChange(of: searchText) {
            filterDesserts()
        }
    }

    func filterDesserts() {
        filteredDesserts = desserts.filter { dessert in
            searchText.isEmpty || dessert.strMeal.lowercased().contains(searchText.lowercased())
        }
    }
}

struct SearchField: View {
    @Binding var searchText: String

    var body: some View {
        TextField("Search for desserts", text: $searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .overlay {
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        CancelButton()
                    }
                } else {
                    MagnifyingGlass()
                }
            }
    }
}

struct DessertsList: View {
    @Binding var desserts: [Desserts]
    @Binding var showDetails: Bool
    @Binding var currentId: String

    var body: some View {
        List(desserts.sorted(by: { $0.strMeal < $1.strMeal }), id: \.idMeal) { dessert in
            Button {
                showDetails.toggle()
                currentId = dessert.idMeal
            } label: {
                DessertRow(dessert: dessert)
            }
        }
    }
}

struct DessertRow: View {
    let dessert: Desserts

    var body: some View {
        HStack {
            Text(dessert.strMeal)
                .foregroundStyle(.black)
                .frame(width: 100, height: 100)

            Spacer()

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

struct CancelButton: View {
    var body: some View {
        HStack {
            Spacer()
            Text("cancel")
                .padding(.trailing, 30)
                .foregroundStyle(.blue)
        }
    }
}

struct MagnifyingGlass: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "magnifyingglass")
                .padding(.trailing, 30)
                .opacity(0.3)
        }
    }
}

// MARK: Canvas Preview
#Preview {
    DessertsView()
}
