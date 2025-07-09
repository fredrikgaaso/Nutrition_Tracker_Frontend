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
                        Text("Number of products: \(cart.productsList?.count ?? 0)")
                        
                }
                }
            } header: {
                Text(cart.cartName)
                    .font(.headline)
            }
        }
    }
}
