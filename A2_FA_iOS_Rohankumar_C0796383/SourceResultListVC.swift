//
//  SourceResultListVC.swift
//  A2_FA_iOS_Rohankumar_C0796383


import UIKit

class SourceResultListVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblView.tableFooterView = UIView()

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? ProductDetailVC {
            controller.item = sender as? Product
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}


extension SourceResultListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productcell", for: indexPath)
        let labelItem = cell.viewWithTag(10) as? UILabel
        let product = products?[indexPath.row]
        labelItem?.text = product?.productName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products?[indexPath.row]
        self.performSegue(withIdentifier: "sourceProductToDetail", sender: product)
    }

}



