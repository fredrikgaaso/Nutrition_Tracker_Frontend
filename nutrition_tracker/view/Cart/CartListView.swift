import SwiftUI

struct CartListView: View {
    @StateObject private var viewModel = CartViewModel()
    @State private var showCreateCartSheet = false
    @State private var newCartName: String = ""
    
    
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
                }
                else {
                
                    CartListSection(viewModel: viewModel)

                    .navigationTitle("Carts")
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showCreateCartSheet = true
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
            }.sheet(isPresented: $showCreateCartSheet) {
                VStack(spacing: 20) {
                    Text("Name you cart")
                        .font(.headline)
                    
                    TextField("Cart name", text: $newCartName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Create") {
                        viewModel.createCart(named: newCartName)
                        newCartName = ""
                        showCreateCartSheet = false
                    }
                    Button("Cancel") {
                        showCreateCartSheet = false
                    }
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

