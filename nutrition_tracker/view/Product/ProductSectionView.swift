import SwiftUI

struct ProductSectionView: View {
    let product: [Product]
    
    var body: some View {
        VStack(alignment: .leading) {
            Section{
                Group{
                    if product.isEmpty {
                        Text("No products").foregroundColor(.gray)
                    }else {
                        ForEach(product, id: \.id) { product in
                            ProductRow(product: product)
                        }
                    }
                }
            }header: {
                Text("Products")
                    .font(.headline)
            }
        }
        
    }
    
}
