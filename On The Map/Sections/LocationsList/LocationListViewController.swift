//
//  LocationListViewController.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import UIKit

class LocationListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var presenter: LocationListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

    }

}
extension LocationListViewController: RefreshableViewController {
    func refreshView() {
        presenter.viewDidLoad()
    }
}
extension LocationListViewController: LocationListViewProtocol {
    func showAlertError(text: String) {
        let alert = UIAlertController(title: "Oops...", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateLoading(hide: Bool) {
        loadingIndicator.isHidden = hide
        tableView.isHidden = !hide
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}

extension LocationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationViewCell") else {
            return UITableViewCell()
        }
        cell.imageView?.image = UIImage(named: "pin_icon")
        cell.textLabel?.text = presenter.textForLocation(index: indexPath.row)
        
        cell.detailTextLabel?.text = presenter.textForUrl(index: indexPath.row)
        return cell
    }
}

extension LocationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectedLocation(index: indexPath.row)
    }
}
