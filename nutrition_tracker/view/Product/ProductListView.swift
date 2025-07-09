import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel: ProductViewModel = .init()
    
    
    var body: some View {
        NavigationView {
            VStack{
                if viewModel.product.isEmpty {
                    Text("Loading products or products is empty")
                        .foregroundColor(.gray)
                        .padding()
                    ProgressView()
                } else {
                    List {
                        ForEach(viewModel.product) {product in
                            ProductSectionView(product: [product])
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.fetchProductsFromApi()
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            if let error = viewModel.errormessage {
                Text("❌ \(error)")
                    .foregroundColor(.red)
            }
        }
    }
}
