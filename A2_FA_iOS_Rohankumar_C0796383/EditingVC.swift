//
//  EditingVC.swift
//  A2_FA_iOS_Rohankumar_C0796383

import UIKit

protocol AddEditDelegate: class {
    func updateProductItems(_ product: Product?)
}


class EditingVC: UIViewController {

    @IBOutlet weak var txtProductId: UITextField!
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtProductPrice: UITextField!
    @IBOutlet weak var txtProductProvider: UITextField!
    @IBOutlet weak var txtProductDescription: UITextView!
    
    weak var delegate: AddEditDelegate?

    var product: Product?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.intialSetup()
    }
    
    
    @IBAction func didTapSaveBtn(_ sender: UIBarButtonItem) {
        
        if (txtProductId.text?.isEmpty ?? false) || (txtProductName.text?.isEmpty ?? false) || (txtProductPrice.text?.isEmpty ?? false) || (txtProductProvider.text?.isEmpty ?? false) || (txtProductDescription.text?.isEmpty ?? false){
            showAlert(message: "Please fill all the field", options: ["Ok"], completion: nil)
        }
        else {
            if let product = product { // edit
                product.productId = Int16(txtProductId.text ?? "") ?? 0
                product.productName = txtProductName.text ?? ""
                product.productPrice = Double(txtProductPrice.text ?? "") ?? 0
                product.productProvider = txtProductProvider.text ?? ""
                product.productDescription = txtProductDescription.text ?? ""
                CoreData.sharedCoreData.storeContext()
                self.delegate?.updateProductItems(product)
            }
            else { // add
                let dictProduct = ["productId"          : txtProductId.text ?? "",
                                   "productPrice"       : txtProductPrice.text ?? "",
                                   "productName"        : txtProductName.text ?? "",
                                   "productDescription" : txtProductDescription.text ?? "",
                                   "productProvider"    : txtProductProvider.text ?? ""]
                HandleData().addProducts(dictProduct)
            }
        }
        
        
    }
    
    func intialSetup()  {
        if let product = product {
            txtProductId.text = String(product.productId )
            txtProductName.text = product.productName
            txtProductPrice.text = String(product.productPrice)
            txtProductProvider.text = product.productProvider
            txtProductDescription.text = product.productDescription
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}


extension EditingVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtProductId {
            self.txtProductName.becomeFirstResponder()
        }
        else if textField == self.txtProductName {
            self.txtProductPrice.becomeFirstResponder()
        }
        else if textField == self.txtProductPrice {
            self.txtProductProvider.becomeFirstResponder()
        }
        else if textField == self.txtProductProvider {
            self.txtProductDescription.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let frame = self.view.convert(textField.frame, from:textField.superview)
        let val = (self.view.frame.height - 260) - frame.maxY
        if val < 0 {
            animateViewMoving(up: true, moveValue: val)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat = 0){
        UIView.animate(withDuration: 0.5,delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: moveValue, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

}

extension EditingVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let frame = self.view.convert(textView.frame, from:textView.superview)
        let val = (self.view.frame.height - 260) - frame.maxY
        if val < 0 {
            animateViewMoving(up: true, moveValue: val)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        animateViewMoving(up: false)
    }
    
}
