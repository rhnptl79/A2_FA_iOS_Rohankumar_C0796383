//
//  ProviderListVC.swift
//  A2_FA_iOS_Rohankumar_C0796383

import UIKit

class ProviderListVC: UIViewController {
    
    

    @IBOutlet weak var tblView: UITableView!
    
    var products: [Product] = []
    var providers:[String : Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fetchProductsFromDB()

    }
    
    func fetchProductsFromDB()  {
        if let product = HandleData().getAllProducts() {
            self.products.removeAll()
            self.products.append(contentsOf: product)
            let grouped = Dictionary(grouping: products.map({$0.productProvider ?? ""}), by: { $0 }).mapValues { items in items.count }
            providers = grouped
            tblView.reloadData()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? SourceResultListVC{
            controller.products = sender as? [Product]
        }
    }
    

}



extension ProviderListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        providers?.keys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "providercell", for: indexPath)
        let labelItem = cell.viewWithTag(10) as? UILabel// tage of label is 10
        let labelCount = cell.viewWithTag(11) as? UILabel// tage of label is 11
        if let providers = providers {
            let keys = Array(providers.keys)
            let provider = keys[indexPath.row]
            labelItem?.text = provider
            labelCount?.text = String(providers[provider] ?? 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let providers = providers {
            let keys = Array(providers.keys)
            let provider = keys[indexPath.row]
            let providerProducts = products.filter({$0.productProvider == provider})
            self.performSegue(withIdentifier: "providerListToProduct", sender: providerProducts)

        }
    }

}

