//
//  HeroesListViewController.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 02..
//

import UIKit

class HeroesListViewController: UIViewController {

    let tableView = UITableView()
    var avengers: [Avenger] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        configureNavigationController()
        configureTableView()
        getHeroesInfo()
    }
    func configureNavigationController() {
        view.backgroundColor = .red
        navigationItem.title = "Heroes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func getHeroesInfo() {
        APICaller.shared.getHeroes { result in
            switch result {
                
            case .success(let heroes):
                self.avengers = heroes.avengers
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HeroCell.self, forCellReuseIdentifier: "myCell")
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HeroesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? HeroCell else {
            fatalError()
        }
        cell.accessoryType = .disclosureIndicator
        
        let heroesInfo = avengers[indexPath.row]
        cell.bind(imageURL: heroesInfo.imageURL,
                  titleLabelText: heroesInfo.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avengers.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showHeroVC = MapViewController(selectedHero: avengers[indexPath.row])
        navigationController?.pushViewController(showHeroVC, animated: true)
    }
}

extension HeroesListViewController: UITableViewDelegate {
    
}
