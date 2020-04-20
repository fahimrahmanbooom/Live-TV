//
//  ViewController.swift
//  Live TV
//
//  Created by Fahim Rahman on 20/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    
    @IBOutlet weak var bdChButton: UIButton!
    @IBOutlet weak var inChButton: UIButton!
    @IBOutlet weak var otChButton: UIButton!
    
    @IBOutlet weak var mainViewBannerTop: GADBannerView!
    @IBOutlet weak var mainViewBannerBottom: GADBannerView!
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUI()
        prepareBannerAd()
        prepareInterstitialAd()
        
    }
    
    
    // button actions
    
    @IBAction func bangladeshiChannelsAction(_ sender: UIButton) {
        
        presentInterstitialAd()
        navigateToTabBarController()
        Country.shared.countryName = "bangladesh"
    }
    
    @IBAction func indianChannelsAction(_ sender: UIButton) {
        
        presentInterstitialAd()
        navigateToTabBarController()
        Country.shared.countryName = "india"
    }
    
    @IBAction func otherChannelsAction(_ sender: UIButton) {
        
        presentInterstitialAd()
        navigateToTabBarController()
        Country.shared.countryName = "other"
    }
}


// ad extension

extension ViewController {
    
    func prepareBannerAd() {
        
        // top banner
        mainViewBannerTop.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        mainViewBannerTop.rootViewController = self
        mainViewBannerTop.adSize = kGADAdSizeSmartBannerPortrait
        mainViewBannerTop.load(GADRequest())
        
        // bottom banner
        mainViewBannerBottom.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        mainViewBannerBottom.rootViewController = self
        mainViewBannerBottom.adSize = kGADAdSizeSmartBannerPortrait
        mainViewBannerBottom.load(GADRequest())
        
    }
    
    // prepare interstitial function
    func prepareInterstitialAd() {
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    // ad loading function for interstitial ads
    func loadInterstitialAd() -> GADInterstitial {
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.load(GADRequest())
        return interstitial
    }
    
    
    // present function for interstitial ad
    func presentInterstitialAd() {
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
            interstitial = loadInterstitialAd()
            
        }
    }
    
    // navigation
    
    func navigateToTabBarController() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Countries", style: .plain, target: nil, action: nil)
    }
    
}


// design extension

extension ViewController {
    
    func designUI() {
        
        bdChButton.layer.cornerRadius = 15
        inChButton.layer.cornerRadius = 15
        otChButton.layer.cornerRadius = 15
        
        bdChButton.clipsToBounds = true
        inChButton.clipsToBounds = true
        otChButton.clipsToBounds = true
    }
    
}
