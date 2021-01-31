//
//  ProductDetailViewController.swift


import UIKit

class ProductDetailVC: UIViewController {
    @IBOutlet var listTextItems: [UILabel]!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        listTextItems[0].text = "Product ID: " + String(product?.productId ?? 0)
        listTextItems[1].text = "Product Name: " + (product?.productName ?? "")
        listTextItems[2].text = "Product Description: " + (product?.productDescription ?? "")
        listTextItems[3].text = "Product Price: " + String(product?.productPrice ?? 0)
        listTextItems[4].text = "Product Provider: " + (product?.productProvider ?? "")
    }

}
