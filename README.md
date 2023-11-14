# iOS Coding Challenge

## Language & API
### Swift | SwiftUI
### https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
### https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID

<hr/>

## Requirements
### GET and display a list of meals in the Dessert category, sorted alphabetically
### Re-direct the user to a detail view when they select a dessert
### The detail view should display: Meal name, Instructions, Ingredients/Measurements

<hr/>

## Architecture(MVVM)
### Models to store data from the API endpoint to be displayed
```swift

    //  https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
    struct DessertsAPIModel: Codable { 
        let meals: [Desserts] 
    }
    
    // https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
    struct DessertsDetailsAPIModel: Codable { 
        let meals: [DessertsDetails]
    }

    struct Desserts: Codable { 
        let idMeal: String
        let strMealThumb: String
        let strMeal: String
        // ...
    }
    
    struct DessertsDetails: Codable { 
        let idMeal: String
        let strMeal: String
        let strMealThumb: String
        let strInstructions: String
        let strIngredient1: String
        let strMeasure1: String
        // ...
    }

```
### Views to display data
```swift
    struct DessertsView: View {
        @State private var desserts: [Desserts] = [] 
        var body: some View {
            
            // ...
        }
    }
    
    struct DessertDetailsView: View {
        @State var dessertDetails: [DessertsDetails] = [] 
        var body: some View {
            
            // ...
        }
    }
```
### ViewModel to fetch and return data from the endpoints
```swift
   class NetworkingManager {
    static let shared = NetworkingManager()

    private init() {}

    func fetchData<T: Decodable>(from endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
    // ...

    
```

## Results
### Desserts View
<img src="https://github.com/stmblueprint/resources/blob/main/images/dessertfinder1.png" alt="catalog view" width="300">

### Dessert Detail View
<img src="https://github.com/stmblueprint/resources/blob/main/images/dessertfinder3.png" alt="catalog view" width="300">

<img src="https://github.com/stmblueprint/resources/blob/main/images/dessertfinder4.png" alt="catalog view" width="300">

### Additional Feature: Search by meal name
<img src="https://github.com/stmblueprint/resources/blob/main/images/dessertfinder2.png" alt="catalog view" width="300">
