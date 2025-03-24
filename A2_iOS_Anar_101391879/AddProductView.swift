import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var description = ""
    @State private var price = ""
    @State private var provider = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Info")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Provider", text: $provider)
                }

                Button("Save Product") {
                    addProduct()
                }
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    func addProduct() {
        let newProduct = Product(context: viewContext)
        newProduct.productID = UUID()
        newProduct.name = name
        newProduct.productDescription = description
        newProduct.price = Double(price) ?? 0.0
        newProduct.provider = provider

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Error saving product: \(error)")
        }
    }
}
