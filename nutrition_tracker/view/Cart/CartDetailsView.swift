import SwiftUI

struct CartDetailsView: View {
    let cart: Cart
    let onDeleteProduct: ((Int) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Cart Name: \(cart.cartName)")
                .font(.title)
            if !(cart.allergens ?? []).isEmpty {
                Text("Allergens: \((cart.allergens ?? []).joined(separator: ", "))")
                    .foregroundColor(.red)
                    .font(.subheadline)
            }

            if let products = cart.productsList, !products.isEmpty {
                            Text("Products:")
                                .font(.headline)

                            List {
                                ForEach(products) { product in
                                    ProductRow(product: product)
                                        .swipeActions {
                                            Button(role: .destructive) {
                                                print("🗑 Deleting product with ID: \(product.id)")

                                                onDeleteProduct?(product.id)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                            .listStyle(.inset)
                        } else {
                            Text("No products in this cart")
                                .foregroundColor(.gray)
                        }

        

            Spacer()
        }
        .padding()
        .navigationTitle("Cart Details")
    }
}
