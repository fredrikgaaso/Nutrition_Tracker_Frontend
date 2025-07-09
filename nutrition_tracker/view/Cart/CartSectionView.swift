import SwiftUI

struct CartSectionView: View {
    let cart: Cart

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Section {
                Group{
                    if (cart.productsList ?? []).isEmpty {
                        Text("No products in cart")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(cart.productsList ?? [], id: \.id) { product in
                            ProductRow(product: product)
                        }
                }
                }
            } header: {
                Text(cart.cartName)
                    .font(.headline)
            }

            if (cart.allergens ?? []).isEmpty == false {
                Text("Allergens: \((cart.allergens ?? []).joined(separator: ", "))")
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 4)
            }
        }
    }
}
