//
//  HandleData.swift


import Foundation
import CoreData

class HandleData {
    
    
    func addRecord(_ table: String, context: NSManagedObjectContext) -> Any? {
        return NSEntityDescription.insertNewObject(forEntityName: table, into: context)
    }

    //check all products
    func getAllProducts() -> [Product]? {
        let context = CoreData.sharedCoreData.persistentContainer.viewContext
        return self.readRecords(fromCoreData: "Product", context: context) as? [Product]
    }
    
    func readAllProductsBasedOnProviders(_ provider: String) -> [Product]? {
        let context = CoreData.sharedCoreData.persistentContainer.viewContext
        let arrayItem = self.readRecords(fromCoreData: "Product", context: context) as? [Product]
        let items = arrayItem?.filter({$0.productProvider == provider})
        return items
    }
    
    func deleteProduct(_ product: Product)  {
        let context = CoreData.sharedCoreData.persistentContainer.viewContext
        context.delete(product)
        CoreData.sharedCoreData.storeContext()
    }
    
    //reading(go through) all products that we have added
    func readRecords(fromCoreData table: String, context: NSManagedObjectContext) -> [Any] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: table, in: context)
        fetchRequest.entity = entity
        fetchRequest.returnsObjectsAsFaults = false
        let records: [Any]? = try? context.fetch(fetchRequest)
        return records!
    }
    
    //Adding the product in list and store it
    func addProducts(_ item: [String:String])  {
        let context = CoreData.sharedCoreData.persistentContainer.viewContext
        let product = self.addRecord("Product", context: context) as? Product
        let productId = item["productId"] ?? "0"
        let productPrice = item["productPrice"] ?? "0"
        
        
        //Setting Values (add products)
        product?.productId = Int16(productId) ?? 0
        product?.productName = item["productName"] ?? ""
        product?.productDescription = item["productDescription"] ?? ""
        product?.productProvider = item["productProvider"] ?? ""
        product?.productPrice = Double(productPrice) ?? 0
        CoreData.sharedCoreData.storeContext()
    }
}
