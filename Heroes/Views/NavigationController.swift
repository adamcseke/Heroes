//
//  NavigationController.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 03..
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isOpaque = false
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
