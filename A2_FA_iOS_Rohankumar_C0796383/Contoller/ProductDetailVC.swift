//
//  ProductDetailVC.swift


import UIKit

class ProductDetailVC: UIViewController, AddEditDelegate {
    @IBOutlet var listTextItems: [UILabel]!
    
    var item: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateItems()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? EditingVC {
            controller.product = item
            controller.delegate = self
        }
    }
    
    func updateProductItems(_ product: Product?) {
        self.item = product
    }
    
    
    func updateItems()
    {
        listTextItems[0].text = "Product ID: " + String(item?.productId ?? 0)
        listTextItems[1].text = "Product Name: " + (item?.productName ?? "")
        listTextItems[2].text = "Product Description: " + (item?.productDescription ?? "")
        listTextItems[3].text = "Product Price: " + String(item?.productPrice ?? 0)
        listTextItems[4].text = "Product Provider: " + (item?.productProvider ?? "")
    }

}
