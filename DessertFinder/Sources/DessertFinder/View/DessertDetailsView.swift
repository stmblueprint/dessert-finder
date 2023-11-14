//
//  DessertDetails.swift
//  DessertFinder
//
//  Created by Aaron Tulloch on 11/6/23.
//

import SwiftUI

struct DessertDetailsView: View {
    
    @State var dessertDetails: [DessertsDetails] = [] // data for the current meal thats being viewed
    @Binding var currentId: String // binding idMeal from DessertsView for meal details api param
    
    var body: some View {
        ScrollView {
            
            // MARK: display all the details for the dessert
            ForEach(dessertDetails, id: \.idMeal) { detail in
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(detail.strMeal) // dessert name
                        .font(.title)
                        .bold()
                    
                    // dessert image
                    AsyncImage(url: URL(string: detail.strMealThumb)) { image in
                        image.resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 350, height: 250)
                    
                    
                    Text("Instructions:")
                        .font(.headline)
                    Text(detail.strInstructions) // dessert instructions
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                    HStack{
                        // dessert ingredients/measurements from IngredientsMeasurements View
                        IngredientsMeasurements(currentId: $currentId)
                        
                    }
                    
                }
                .padding(.horizontal, 20)
                
            }
        }
        .onAppear{
            Task{
                do{
                    // MARK: set data based on the current idMeal being viewed
                    let result = try await fetchDessertDetails(currentId)
                    dessertDetails = result.meals
                } catch {
                    if (currentId.isEmpty) {
                        print("id not found")
                    } else {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    DessertDetailsView(currentId: .constant("52787"))
}
