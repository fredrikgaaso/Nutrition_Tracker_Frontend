import Foundation

class ProductViewModel: ObservableObject {
    @Published var product: [Product] = []
    @Published var errormessage: String?
    
    init(){
        fetchProductsFromApi()
    }
    
    func getAllProducts() {
        ProductService.getAllProducts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.product = products
                case .failure(let error):
                    self.errormessage = error.localizedDescription
                    print("Error: \(error)")
                }
         
            }
        }
    }
    func fetchProductsFromApi(){
        ProductService.fetchProductsFromApi { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.product = products
                case .failure(let error):
                    self.errormessage = error.localizedDescription
                    print("Error: \(error)")
                }
            }
            
        }
    }
}
