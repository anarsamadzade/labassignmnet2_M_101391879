import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // This is used only for SwiftUI Previews
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Optionally add some dummy Product objects for previews (can be empty)
        for i in 1...3 {
            let product = Product(context: viewContext)
            product.productID = UUID()
            product.name = "Preview Product \(i)"
            product.productDescription = "This is preview product \(i)"
            product.price = Double(i) * 9.99
            product.provider = "Preview Provider \(i)"
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Anar_101391879")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
