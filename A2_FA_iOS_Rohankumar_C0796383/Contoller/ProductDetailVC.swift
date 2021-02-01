//
//  ProductDetailVC.swift


import UIKit

class ProductDetailVC: UIViewController {
    @IBOutlet var listTextItems: [UILabel]!
    
    var item: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        listTextItems[0].text = "Product ID: " + String(item?.productId ?? 0)
        listTextItems[1].text = "Product Name: " + (item?.productName ?? "")
        listTextItems[2].text = "Product Description: " + (item?.productDescription ?? "")
        listTextItems[3].text = "Product Price: " + String(item?.productPrice ?? 0)
        listTextItems[4].text = "Product Provider: " + (item?.productProvider ?? "")
    }

}
