//
//  ExchangeController.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 20/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import UIKit

class ExchangeController: UIViewController {
    @IBOutlet weak var lettersView: LetterView!
    @IBOutlet weak var bitcounTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    var currency:Currency?
    var factor:Float = 0.0
    
    let controllerNibName = "ExchangeController"
    init() {
        super.init(nibName: controllerNibName, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Converter"
        if let currency = currency {
            factor = currency.last
            lettersView.setLetters(currency.name)
            bitcounTextField.text = "1"
            currencyTextField.text = "\(currency.last)"
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(bitcoinDidChange(_:)), name: UITextField.textDidChangeNotification, object: bitcounTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(currencyDidChange(_:)), name: UITextField.textDidChangeNotification, object: currencyTextField)
    }
    

}

extension ExchangeController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func closeKeyboard(){
        self.view.endEditing(true)
     }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            return true
        case ".":
            guard let text = textField.text else { return true }
            let array = Array(text)
            var decimalCount = 0
            for character in array {
                if character == "." {
                    decimalCount += 1
                }
            }
            
            if decimalCount == 1 {
                return false
            } else {
                return true
            }
        default:
            let array = Array(string)
            if array.count == 0 {
                return true
            }
            return false
        }
    }
    
    @objc private func bitcoinDidChange(_ notification: Notification) {
        let bit = Float(bitcounTextField.text ?? "") ?? 0.0
        let update = bit * factor
        var updateString = update < 1 ? "\(update)" :String(format: "%.2f", update)
        if update == 0.0 { updateString = "" }
        currencyTextField.text = updateString
    }
    @objc private func currencyDidChange(_ notification: Notification) {
        let cur = Float(currencyTextField.text ?? "") ?? 0.0
        let update = cur / factor
        var updateString = update < 1 ? "\(update)" :String(format: "%.2f", update)
        if update == 0.0 { updateString = "" }
        bitcounTextField.text = updateString
    }
    
}
