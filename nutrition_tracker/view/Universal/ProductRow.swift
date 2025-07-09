import SwiftUI

struct ProductRow: View {
    let product: Product
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            Text(product.productName).font(.subheadline).bold()
            Text("Calories: \(product.calories, specifier: "%.0f") • Quantity: \(product.quantity ?? 0)")
            Text("Group: \(product.foodGroup)")
            ForEach(product.nutritionalInfo, id: \.nutrientName) {nutrient in
                Text("\(nutrient.nutrientName): \(nutrient.nutrientValue, specifier: "%.1f")g").font(.caption).foregroundColor(.secondary)}
        }
        .padding(.vertical, 4)
        }
     
    }
