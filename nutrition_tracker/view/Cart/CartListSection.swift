import SwiftUI

struct CartListSection: View {
    @ObservedObject var viewModel: CartViewModel

    var body: some View {
        List {
            ForEach(viewModel.carts) { cart in
                NavigationLink(destination: CartDetailsView(cart: cart){productId in viewModel.deleteProduct(cartId: cart.id, productId: productId)} ) {
                    
                    CartSectionView(cart: cart)
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.deleteCart(cartId: cart.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
        }
    }
}
