import Foundation

class CartViewModel: ObservableObject {
    @Published var carts: [Cart] = []
    @Published var errormessage: String?
    
    init() {
        loadCarts()
    }
    
    func loadCarts() {
        CartService.fetchCartItems { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let carts):
                    self.carts = carts
                case .failure(let error):
                    self.errormessage = error.localizedDescription
                    print("Error: \(error)")
                }
            }
        }
    }
    func createCart(named name: String) {
        CartService.createCart(cartName: name) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newCart):
                    self.carts.append(newCart)
                case .failure(let error):
                    self.errormessage = "Failed to create cart: \(error.localizedDescription)"
                    print("❌ \(error)")
                }
            }
        }
    }
    func deleteCart(cartId: Int) {
        CartService.deleteCart(cartId: cartId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let carts):
                    self.carts.removeAll { $0.id == cartId }
                case .failure(let error):
                    self.errormessage = "Failed to delete cart: \(error.localizedDescription)"
                    print("❌ \(error)")
                }
            }
        
        }
        
    }
}
