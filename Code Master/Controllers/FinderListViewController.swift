//
//  FinderListViewController.swift
//  Edhita
//
//  Created by Tatsuya Tobioka on 10/7/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import UIKit

class FinderListViewController: EDHFinderListViewController {

    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.initAd()
        // self.view.backgroundColor = UIColor(white:0.89, alpha:1.0)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func gettingStarted() {
        let alert = UIAlertController(title: "Getting Started", message: "This is where we will implement a little manual for users that have never used Code Master or are new to coding in general. Stay tuned!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cool", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Utilities
    
    /*
    func initAd() {
        if UIDevice.currentDevice().orientation.isLandscape {
            self.bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)
        } else {
            self.bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        }
        
//        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
//            self.bannerView = GADBannerView(adSize: kGADAdSizeMediumRectangle)
//        } else {
//            self.bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//        }
        
        self.bannerView.adUnitID =  AppSecret.Ad.AdMob.unitId
        self.bannerView.rootViewController = self
        
        let request = GADRequest()
        request.testDevices = [GAD_SIMULATOR_ID]
        self.bannerView.loadRequest(request)
        
        self.tableView.tableFooterView = self.bannerView
    }
    */
}
