//
//  ProductListVC.swift 


import UIKit

class ProductListVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchProducts()
    }
    
    func fetchProducts()
    {
        let EnterData = UserDefaults.standard.bool(forKey: "enterData")
        if EnterData
        {
            if let product = HandleData().getAllProducts()
            {
                self.products.append(contentsOf: product)
            }
        }
        else {
            if let destination = Bundle.main.path(forResource: "product", ofType: "plist"),
               let data = NSData(contentsOfFile: destination)
            {
                do
                {
                    let pListData = try PropertyListSerialization.propertyList(from: data as Data, options: .mutableContainers, format: nil)
                    if let pListData = pListData as? [[String : String]]
                    {
                        for product in pListData { HandleData().addProducts(product ) }
                        if let product = HandleData().getAllProducts()
                        {
                            self.products.append(contentsOf: product)
                        }
                        UserDefaults.standard.set(true, forKey: "enterData")
                    }
                }
                catch
                {
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let controller = segue.destination as? ProductDetailVC
        {
            controller.item = sender as? Product
        }
    }
}



extension ProductListVC: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product_cell", for: indexPath)
        let labelItemname = cell.viewWithTag(10) as? UILabel// tage of label is 10
        let product = products[indexPath.row]
        labelItemname?.text = product.productName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let product = products[indexPath.row]
        self.performSegue(withIdentifier: "productListToDetail", sender: product)
    }

}

extension ProductListVC: UITextFieldDelegate
{
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool
    {
        if let text = textField.text, let textRange = Range(range, in: text)
        {
            let updatedText = text.replacingCharacters(in: textRange, with: string).lowercased()
            
            if let product = HandleData().getAllProducts()
            {
                if updatedText.isEmpty
                {
                    self.products.removeAll()
                    self.products.append(contentsOf: product)
                }
                else
                {
                    let items = product.filter({($0.productName!.lowercased().contains(updatedText))})
                    self.products.removeAll()
                    self.products.append(contentsOf: items)
                }
                self.tblView.reloadData()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
