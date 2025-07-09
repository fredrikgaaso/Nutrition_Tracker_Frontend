import SwiftUI

struct CartDetailsView: View {
    let cart: Cart

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Cart Name: \(cart.cartName)")
                .font(.title)

            if !(cart.productsList ?? []).isEmpty {
                Text("Products:")
                    .font(.headline)

                ForEach(cart.productsList ?? []) { product in
                    Text("• \(product.productName)")
                }
            } else {
                Text("No products in this cart")
                    .foregroundColor(.gray)
            }

            if !(cart.allergens ?? []).isEmpty {
                Text("Allergens: \((cart.allergens ?? []).joined(separator: ", "))")
                    .foregroundColor(.red)
                    .font(.subheadline)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Cart Details")
    }
}
