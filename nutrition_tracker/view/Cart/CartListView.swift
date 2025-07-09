import SwiftUI

struct CartListView: View {
    @StateObject private var viewModel = CartViewModel()
    
    init() {
            _viewModel = StateObject(wrappedValue: CartViewModel())
        }
    
    var body: some View {
    
    
        NavigationStack {
            VStack {
                NavigationLink(destination: ProductListView()) {
                    Text("Go to product list").foregroundColor(.blue).padding()
                }
                if viewModel.carts.isEmpty {
                    Button(action: {
                        viewModel.createCart(named: "New cart")
                    }){
                        Label("Create new cart", systemImage: "plus")
                    }
                    Text("Loading or no carts available")
                        .foregroundColor(.gray)
                        .padding()
                    ProgressView()
                } else {
                
                    List {
                        ForEach(viewModel.carts) { cart in
                            NavigationLink(destination: CartDetailsView()) {

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
                    .navigationTitle("Carts")
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                viewModel.createCart(named: "New cart")
                            }){
                                Image(systemName: "plus")
                            }
                        }
                    }
                    
                }

                if let error = viewModel.errormessage {
                    Text("❌ \(error)")
                        .foregroundColor(.red)
                }
            }
           
            .navigationTitle("Your Carts")
            .onAppear {
                print("📦 Calling fetchCarts...")
                viewModel.loadCarts()
            }
        }
    }

        }

