//
//  ContentView.swift
//  DessertFinder
//
//  Created by Aaron Tulloch on 11/7/23.
//

import SwiftUI

struct IngredientsMeasurements: View {
    // state property to store the dessert details
    @State private var dessertDetails: DessertsDetails?
    
    // binding property for the current dessert's id being viewed
    @Binding var currentId: String
    
    var body: some View {
        VStack {
            if let dessertDetails = dessertDetails {
                HStack{
                    Text("Ingredients")
                        .fontWeight(.bold)
                    Spacer()
                    Text("Measurements")
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10) 
                
                // loop from 1 to 20 because all desserts have 20 fields for measurements and ingredients
                ForEach(1...20, id: \.self) { index in
                    
                    // get the current ingredient and measure for the current index
                        if let (ingredient, measure) = dessertDetails.value(forIndex: index) {
                            
                            // filter out empty information
                            if !ingredient.isEmpty && !measure.isEmpty {
                                HStack {
                                    Text(ingredient) // display ingredient
                                    Spacer()
                                    Text(measure) // display measure
                                }
                                .padding(.horizontal, 30)
                                Divider()
                            }
                        }
                    
                }
                
            } else {
                ProgressView() // display a loading icon if dessertDetails is nil
            }
        }
        .onAppear {
            Task {
                do {
                    // fetch dessert details
                    let details = try await fetchDessertDetails(currentId)
                    
                    // store the details
                    dessertDetails = details.meals.first
                } catch {
                    // catch  and print errors
                    if currentId.isEmpty {
                        print("id not found")
                    } else {
                        print("Error fetching dessert details: \(error)")
                    }
                }
            }
        }
    }
 
}

// Access values by index in DessertsDetails data
extension DessertsDetails {
    
    // return ingredient with its corresponding measurement
    func value(forIndex index: Int) -> (String, String)? {
        switch index {
        case 1: return (strIngredient1, strMeasure1)
        case 2: return (strIngredient2, strMeasure2)
        case 3: return (strIngredient3, strMeasure3)
        case 4: return (strIngredient4, strMeasure4)
        case 5: return (strIngredient5, strMeasure5)
        case 6: return (strIngredient6, strMeasure6)
        case 7: return (strIngredient7, strMeasure7)
        case 8: return (strIngredient8, strMeasure8)
        case 9: return (strIngredient9, strMeasure9)
        case 10: return (strIngredient10, strMeasure10)
        case 11: return (strIngredient11, strMeasure11)
        case 12: return (strIngredient12, strMeasure12)
        case 13: return (strIngredient13, strMeasure13)
        case 14: return (strIngredient14, strMeasure14)
        case 15: return (strIngredient15, strMeasure15)
        case 16: return (strIngredient16, strMeasure16)
        case 17: return (strIngredient17, strMeasure17)
        case 18: return (strIngredient18, strMeasure18)
        case 19: return (strIngredient19, strMeasure19)
        case 20: return (strIngredient20, strMeasure20)
        default:
            return nil
        }
    }
}



#Preview {
    // preview ingredients and measurements for idMeal = "52787"
    IngredientsMeasurements(currentId: .constant("52787"))
}


