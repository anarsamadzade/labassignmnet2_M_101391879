import CoreData
import SwiftUI

@main
struct A2_iOS_Anar_101391879App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    preloadSampleProductsIfNeeded(context: persistenceController.container.viewContext)
                }
        }
    }

    func preloadSampleProductsIfNeeded(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.fetchLimit = 1

        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                for i in 1...10 {
                    let newProduct = Product(context: context)
                    newProduct.productID = UUID()
                    newProduct.name = "Product \(i)"
                    newProduct.productDescription = "Description for Product \(i)"
                    newProduct.price = Double(i) * 10.0
                    newProduct.provider = "Provider \(i)"
                }
                try context.save()
                print("Sample products added.")
            } else {
                print("Sample products already exist.")
            }
        } catch {
            print("Failed to preload products: \(error)")
        }
    }
}
