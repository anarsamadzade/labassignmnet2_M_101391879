import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    @State private var showAddProductView = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProducts) { product in
                    VStack(alignment: .leading) {
                        Text(product.name ?? "No Name")
                            .font(.headline)
                        Text(product.productDescription ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("All Products")
            .searchable(text: $searchText, prompt: "Search by name or description")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddProductView.toggle()
                    }) {
                        Label("Add Product", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddProductView) {
                AddProductView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return products.map { $0 }
        } else {
            return products.filter {
                ($0.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                ($0.productDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
}
