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
    var countryDetailModel : CountryDetailModel?
    var imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
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
        self.loadData()
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
        self.navigationController?.navigationBar.setupNavigationBar()
        self.view.addGradientBackground(from: UIColor.init(red: 213/255.0, green: 126/255.0, blue: 208/255.0, alpha: 1.0), to: UIColor.init(red: 120/255.0, green: 81/255.0, blue: 206/255.0, alpha: 1.0))
        self.countryDetailTableView.addSubview(self.refreshControl)
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.countryDetailTableView.estimatedRowHeight = 180
        } else {
            self.countryDetailTableView.estimatedRowHeight = 116
        }
        self.countryDetailTableView.isHidden = true
        self.countryDetailTableView.rowHeight  = UITableViewAutomaticDimension
        self.countryDetailTableView?.register(CountryDetailCell.nib, forCellReuseIdentifier: CountryDetailCell.identifier)
    }
    
    func loadData() {
        let queue = DispatchQueue(label: "bgQueue", qos: DispatchQoS.background)
        queue.async {
            CountryDetailViewModel.fetchDetail("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") { (countryDetail) in
                DispatchQueue.main.async {
                    self.countryDetailModel = countryDetail
                    self.title = countryDetail?.title
                    self.countryDetailTableView.isHidden = false
                    // Animate table view
                    let transition = CATransition()
                    transition.type = kCATransitionPush
                    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                    transition.fillMode = kCAFillModeForwards
                    transition.duration = 1
                    transition.subtype = kCATransitionFromTop
                    self.countryDetailTableView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
                    
                    // Update your data source here
                    
                    self.countryDetailTableView.reloadData()
                }
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        self.loadData()
    }
    
}

extension HomeScreenViewController: UITableViewDataSource, ImageDownloadProtocol {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let tableRowCount = self.countryDetailModel?.rows.count {
            return tableRowCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CountryDetailCell.identifier, for: indexPath) as? CountryDetailCell {
            cell.layer.cornerRadius = 5
            cell.thumbnailImageView.circularImageView()
            let detailItem = self.countryDetailModel?.rows[indexPath.section]
            cell.detailModel = detailItem
            
            
            
            if detailItem?.imageHref != nil {
                let imageUrl = (detailItem?.imageHref)!
                if let cachedImage = imageCache.object(forKey: imageUrl.absoluteString as NSString) {
                    cell.thumbnailImageView.image = cachedImage
                } else {
                    cell.thumbnailImageView.image = UIImage(named: "placeHolderIcon")
                    downloadImage(from: imageUrl) { (image) in
                        if let thumbnailImage = image {
                            self.imageCache.setObject(thumbnailImage, forKey: imageUrl.absoluteString as NSString)
                            cell.thumbnailImageView.image = thumbnailImage
                        }
                    }
                }
            } else {
                 cell.thumbnailImageView.image = UIImage(named: "placeHolderIcon")
            }
            return cell
        }
        return cell
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
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

//extension HomeScreenViewController: ImageDownloadProtocol {
//
//    func updateImage(_ url : URL) -> UIImage {
//        downloadImage(from: url) { image in
//            if Thread.isMainThread {
//                print("Thread is main")
//
//            }
//           // self.imageViewOne.image = image
//            print("Done")
//        }
//    }
//}


