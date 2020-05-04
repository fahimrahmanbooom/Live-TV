//
//  CartoonViewController.swift
//  Live TV
//
//  Created by Fahim Rahman on 23/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVKit
import JGProgressHUD

final class CartoonViewController: UIViewController {
    
    
    @IBOutlet weak var cartoonViewBannerTop: GADBannerView!
    
    @IBOutlet weak var cartoonViewBannerBottom: GADBannerView!
    
    @IBOutlet weak var cartoonTableView: UITableView!
    
    private let hud = JGProgressHUD(style: .dark)
    
    private let avPlayer = AVPlayerViewController()
    
    private var response: Base!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.position = .center
        
//        cartoonViewBannerTop.delegate = self
//        cartoonViewBannerBottom.delegate = self
        
        cartoonTableView.delegate = self
        cartoonTableView.dataSource = self
        
        cartoonTableView.backgroundColor = UIColor(red: 41/255, green: 41/255, blue: 43/255, alpha: 1)
        
        prepareBannerAd()
        gettingDataFromResource(resourceName: Country.shared.countryName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentBannerAd()
        hud.dismiss(afterDelay: 2, animated: true)
    }
    
    //getting data from resource
    func gettingDataFromResource(resourceName: String ) {
        
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else { return }
        guard let jsonData = try? String(contentsOfFile: path).data(using: .utf8) else { return }
        
        do {
            try response = JSONDecoder().decode(Base.self, from: jsonData)
        }
        catch {
            print(error)
        }
    }
}


extension CartoonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return response.cartoon?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartoonTableViewCell = cartoonTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartoonTableViewCell
        
        cell.channelImageView.image = UIImage(named: (response.cartoon?[indexPath.row].image)!)
        cell.channelNameLabel?.text = response.cartoon?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: (response.cartoon?[indexPath.row].link)!) else { return }
        let video = AVPlayer(url: url)
        avPlayer.player = video
    
        self.present(avPlayer, animated: true, completion: {
            
            video.play()
        })
    }
}







// ad extension

extension CartoonViewController {
    
    func prepareBannerAd() {
        
        // top banner
        cartoonViewBannerTop.adUnitID = "ca-app-pub-8021061863868813/4247668630"
        cartoonViewBannerTop.rootViewController = self
        
        
        // bottom banner
        cartoonViewBannerBottom.adUnitID = "ca-app-pub-8021061863868813/2934586967"
        cartoonViewBannerBottom.rootViewController = self
        
    }
    
    func presentBannerAd() {
        
        // top banner
        
        cartoonViewBannerTop.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        cartoonViewBannerTop.load(GADRequest())
        
        // bottom banner
        
        cartoonViewBannerBottom.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        cartoonViewBannerBottom.load(GADRequest())
    }
}





// Gad extention for delegate methods

//extension CartoonViewController: GADBannerViewDelegate {
//
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        hud.dismiss()
//    }
//
//}
