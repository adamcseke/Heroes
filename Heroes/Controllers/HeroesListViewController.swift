//
//  HeroesListViewController.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 02..
//

import UIKit

class HeroesListViewController: UIViewController {

    private var tableView: UITableView!
    private var param: String?
    private var avengers: [Avenger] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        configureNavigationController()
        configureTableView()
        getHeroesInfo(param: "5addd58b30000066154b28c9")
    }
    private func configureNavigationController() {
        navigationItem.title = "Heroes"
        navigationItem.titleView?.tintColor = .label
        navigationController?.navigationBar.installBlurEffect()
        view.backgroundColor = .systemBackground
    }
    private func getHeroesInfo(param: String) {
        APICaller.shared.getHeroes(param: param) { result in
            switch result {
                
            case .success(let heroes):
                self.avengers = heroes.avengers
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HeroCell.self, forCellReuseIdentifier: "myCell")
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension HeroesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? HeroCell else {
            fatalError()
        }
        cell.accessoryType = .disclosureIndicator
        let heroesInfo = avengers[indexPath.row]
        cell.bind(imageURL: heroesInfo.imageURL, titleLabelText: heroesInfo.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avengers.count
    }
}

extension HeroesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showHeroVC = MapViewController(selectedHero: avengers[indexPath.row])
        navigationController?.pushViewController(showHeroVC, animated: true)
    }
}
