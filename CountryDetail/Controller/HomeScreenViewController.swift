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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(HomeScreenViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.white
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupUI()
       // self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.countryDetailTableView.reloadData()
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
        self.title = "Canada"
        self.navigationController?.navigationBar.setupNavigationBar()
        self.view.addGradientBackground(from: UIColor.init(red: 213/255.0, green: 126/255.0, blue: 208/255.0, alpha: 1.0), to: UIColor.init(red: 120/255.0, green: 81/255.0, blue: 206/255.0, alpha: 1.0))
        self.countryDetailTableView.addSubview(self.refreshControl)
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.countryDetailTableView.estimatedRowHeight = 180
        } else {
            self.countryDetailTableView.estimatedRowHeight = 116
        }
        self.countryDetailTableView.rowHeight  = UITableViewAutomaticDimension
        self.countryDetailTableView?.register(CountryDetailCell.nib, forCellReuseIdentifier: CountryDetailCell.identifier)
    }
    
    func loadData() {
        CountryDetailViewModel.fetchDetail("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") { (root, code) in
            print(root)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.countryDetailTableView.reloadData()
        refreshControl.endRefreshing()
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
            cell.descriptionLabel.text = "Adfdfsd moose is a common sight in Canada. Tall and majestic, they represent many of the values which Canadians imagine that they possess. They grow up to 2.7 metres long and can weigh over 700 kg. They swim at 10 km/h. Moose antlers weigh roughly 20 kg. The plural of moose is actually 'meese', despite what most dictionaries, encyclopedias, and experts will tell you."
            cell.layer.cornerRadius = 5
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}


