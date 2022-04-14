//
//  ViewController.swift
//  TableViewExample
//
//  Created by Shaik, Suneelahammad (Cognizant) on 13/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: DrinksViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = DrinksViewModel(service: ServiceManager())
        
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        self.tableView.register(UINib(nibName: HeaderTableViewCell.className, bundle: nil), forCellReuseIdentifier: HeaderTableViewCell.className)
    }
    
    private func loadData() {
        Loader.shared.show()
        viewModel?.callService(completion: { [weak self] isSuccess in
            Loader.shared.hide()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getNoOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrinksTableViewCell.className, for: indexPath) as? DrinksTableViewCell, let drink = self.viewModel?.getDrink(index: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setDrink(drink, indexPath: indexPath)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.className) as? HeaderTableViewCell else {
            return UIView()
        }
        cell.titleLbl.text = self.viewModel?.getHeaderTitle()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: DrinksTableViewCellProtocol {
    func tappedCell(index: Int) {
        print("Tapped cell row \(index)")
    }
}

