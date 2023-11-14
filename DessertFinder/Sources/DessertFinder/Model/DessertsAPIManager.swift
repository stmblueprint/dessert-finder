//
//  DessertsAPIModel.swift
//  DessertFinder
//
//  Created by Aaron Tulloch on 11/6/23.
//

import Foundation


/* api json format for the list of desserts
        {
            "meals:" [
                {
                    
                },
 
                 {
                     
                 },
                
            ]
        }
 */

/* api json format for dessert details
        {
            "meals:" [
                {
                    
                }
            ]
        }
 */


struct DessertsAPIModel: Codable { //"https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let meals: [Desserts] // NOTE: if not named 'meals', results in invalidData error
}

struct DessertsDetailsAPIModel: Codable { //"https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
    let meals: [DessertsDetails]
}



struct Desserts: Codable { // data for: DessertsAPIModel
    let idMeal: String
    let strMealThumb: String
    let strMeal: String
    
}

struct DessertsDetails: Codable { // data for: DessertsDetailsAPIModel
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let strIngredient1: String
    let strMeasure1: String
    let strIngredient2: String
    let strMeasure2: String
    let strIngredient3: String
    let strMeasure3: String
    let strIngredient4: String
    let strMeasure4: String
    let strIngredient5: String
    let strMeasure5: String
    let strIngredient6: String
    let strMeasure6: String
    let strIngredient7: String
    let strMeasure7: String
    let strIngredient8: String
    let strMeasure8: String
    let strIngredient9: String
    let strMeasure9: String
    let strIngredient10: String
    let strMeasure10: String
    let strIngredient11: String
    let strMeasure11: String
    let strIngredient12: String
    let strMeasure12: String
    let strIngredient13: String
    let strMeasure13: String
    let strIngredient14: String
    let strMeasure14: String
    let strIngredient15: String
    let strMeasure15: String
    let strIngredient16: String
    let strMeasure16: String
    let strIngredient17: String
    let strMeasure17: String
    let strIngredient18: String
    let strMeasure18: String
    let strIngredient19: String
    let strMeasure19: String
    let strIngredient20: String
    let strMeasure20: String
    
}


enum DessertsAPIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case badGateway
    case nonHttpError
}


//struct DessertsDetails: Codable {
//    let idMeal: String
//    let strMeal: String
//    let strMealThumb: String
//    let strInstructions: String
//    let ingredients: [(ingredient: String, measure: String)]
//
//    enum CodingKeys: String, CodingKey {
//        case idMeal, strMeal, strMealThumb, strInstructions
//        case strIngredient1, strMeasure1
//        case strIngredient2, strMeasure2
//        // ... repeat for other ingredients and measures
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        idMeal = try container.decode(String.self, forKey: .idMeal)
//        strMeal = try container.decode(String.self, forKey: .strMeal)
//        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
//        strInstructions = try container.decode(String.self, forKey: .strInstructions)
//
//        var ingredients: [(ingredient: String, measure: String)] = []
//
//        for i in 1...20 {
//            let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)")!
//            let measureKey = CodingKeys(stringValue: "strMeasure\(i)")!
//
//            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
//               let measure = try container.decodeIfPresent(String.self, forKey: measureKey),
//               !ingredient.isEmpty {
//                ingredients.append((ingredient, measure))
//            }
//        }
//
//        self.ingredients = ingredients
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(idMeal, forKey: .idMeal)
//        try container.encode(strMeal, forKey: .strMeal)
//        try container.encode(strMealThumb, forKey: .strMealThumb)
//        try container.encode(strInstructions, forKey: .strInstructions)
//
//        for (index, ingredient) in ingredients.enumerated() {
//            try container.encode(ingredient.ingredient, forKey: CodingKeys(stringValue: "strIngredient\(index + 1)")!)
//            try container.encode(ingredient.measure, forKey: CodingKeys(stringValue: "strMeasure\(index + 1)")!)
//        }
//    }
//}
