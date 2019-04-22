//
//  ViewController.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 19/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import UIKit
import RealmSwift

class CurrencyController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    let realm = try! Realm()
    lazy var currencies: Results<Currency> = { self.realm.objects(Currency.self) }()
    let cellNibName = "CurrencyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currencies"
        
        let cellNib = UINib.init(nibName: cellNibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellNibName)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if currencies.count == 0 {
            tableView.showActivityIndicator = true
        }
        
        loadCurrencies { }
    }
    
    func loadCurrencies(complete: @escaping () -> Void){
        CurrencyService.fetchCurrency { [weak self] (success, error) in
            
            guard let vc = self else { return }
            if let error = error {
                PopupController.present(for: error, on: vc, completion: complete)
            }
            if success  {
                vc.update()
            }
            vc.onLoadingFinish()
            complete()
        }
    }
    
    func update(){
        currencies = realm.objects(Currency.self)
        tableView.reloadData()
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        loadCurrencies {
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    private func onLoadingFinish() {
        tableView.showActivityIndicator = false
        
        if currencies.count == 0 {
            tableView.showNoItemsLabel(
                with: "No data"
            )
        }
    }

}



extension CurrencyController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellNibName, for: indexPath) as! CurrencyCell
        cell.selectionStyle = .none
        let currency = currencies[indexPath.row]
        cell.lettersView.setLetters(currency.name)
        cell.priceLabel.text = "\(currency.last) \(currency.symbol)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currencies.count != 0 {
            return currencies.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ExchangeController.init()
        viewController.currency = currencies[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}



