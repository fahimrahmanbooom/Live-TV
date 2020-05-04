//
//  ViewController.swift
//  Live TV
//
//  Created by Fahim Rahman on 20/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import GoogleMobileAds
import JGProgressHUD

final class ViewController: UIViewController {
    
    @IBOutlet weak var allChannelsImage: UIImageView!
    
    @IBOutlet weak var bdChButton: UIButton!
    @IBOutlet weak var inChButton: UIButton!
    @IBOutlet weak var otChButton: UIButton!
    
    @IBOutlet weak var mainViewBannerTop: GADBannerView!
    @IBOutlet weak var mainViewBannerBottom: GADBannerView!
    
    private var interstitial: GADInterstitial!
    
    private let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.position = .center
        
//        mainViewBannerTop.delegate = self
//        mainViewBannerBottom.delegate = self
        
        prepareBannerAd()
        prepareInterstitialAd()
        designUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        presentBannerAd()
        hud.dismiss(afterDelay: 2, animated: true)
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
        mainViewBannerTop.adUnitID = "ca-app-pub-8021061863868813/3192579596"
        mainViewBannerTop.rootViewController = self
        
        
        // bottom banner
        mainViewBannerBottom.adUnitID = "ca-app-pub-8021061863868813/1074710383"
        mainViewBannerBottom.rootViewController = self
        
    }
    
    func presentBannerAd() {
        
        // top banner
        mainViewBannerTop.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        mainViewBannerTop.load(GADRequest())
        
        // bottom banner
        mainViewBannerTop.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        mainViewBannerBottom.load(GADRequest())
    }
    
    // prepare interstitial function
    func prepareInterstitialAd() {
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-8021061863868813/2196220369")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    // ad loading function for interstitial ads
    func loadInterstitialAd() -> GADInterstitial {
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-8021061863868813/2196220369")
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
}



// Gad extention for delegate methods

//extension ViewController: GADBannerViewDelegate {
//
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        hud.dismiss()
//    }
//}


// design extension

extension ViewController {
    
    
    // navigation
    
    func navigateToTabBarController() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Menu", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .red
    }

    
    // UI design
    
    func designUI() {
        
        allChannelsImage.layer.cornerRadius = 10
        
        bdChButton.layer.cornerRadius = 10
        inChButton.layer.cornerRadius = 10
        otChButton.layer.cornerRadius = 10
        
        bdChButton.clipsToBounds = true
        inChButton.clipsToBounds = true
        otChButton.clipsToBounds = true
    }
    
}
