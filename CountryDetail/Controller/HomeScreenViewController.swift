//
//  HomeScreenViewController.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/12/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet var countryDetailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
    }
        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.view.updateGradientFrame()
        }) { (context) in }
    }

    func setupUI() {
        self.view.addGradientBackground(from: UIColor.init(red: 213/255.0, green: 126/255.0, blue: 208/255.0, alpha: 1.0), to: UIColor.init(red: 120/255.0, green: 81/255.0, blue: 206/255.0, alpha: 1.0))
        self.countryDetailTableView.estimatedRowHeight = 95
        self.countryDetailTableView.rowHeight  = UITableViewAutomaticDimension
        self.countryDetailTableView?.register(CountryDetailCell.nib, forCellReuseIdentifier: CountryDetailCell.identifier)
    }
}

extension HomeScreenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CountryDetailCell.identifier, for: indexPath) as? CountryDetailCell {
            //let placeDetail = self.placeArray[indexPath.section]
            //cell.item = placeDetail
            cell.layer.cornerRadius = 10
            cell.imageVw.circularImageView()
            return cell
        }
        return cell
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.section % 2 == 0) {
            cell.backgroundColor = UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}


