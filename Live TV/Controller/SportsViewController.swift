//
//  SportsViewController.swift
//  Live TV
//
//  Created by Fahim Rahman on 23/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVKit
import JGProgressHUD

class SportsViewController: UIViewController {
    
    
    @IBOutlet weak var sportsViewBannerTop: GADBannerView!

    @IBOutlet weak var sportsViewBannerBottom: GADBannerView!
    
    @IBOutlet weak var sportsTableView: UITableView!
    
    let hud = JGProgressHUD(style: .dark)
    
    let avPlayer = AVPlayerViewController()
    
    var response: Base!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.position = .center
        
        sportsViewBannerTop.delegate = self
        sportsViewBannerBottom.delegate = self
        
        sportsTableView.delegate = self
        sportsTableView.dataSource = self
        
        prepareBannerAd()
        gettingDataFromResource(resourceName: Country.shared.countryName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentBannerAd()
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


extension SportsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return response.sports!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SportsTableViewCell = sportsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SportsTableViewCell
        
        cell.channelNameLabel?.text = response.sports?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: (response.sports?[indexPath.row].link)!) else { return }
        let video = AVPlayer(url: url)
        avPlayer.player = video
    
        self.present(avPlayer, animated: true, completion: {
            
            video.play()
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    
}







// ad extension

extension SportsViewController {
    
    func prepareBannerAd() {
        
        // top banner
        sportsViewBannerTop.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        sportsViewBannerTop.rootViewController = self
        
        
        // bottom banner
        sportsViewBannerBottom.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        sportsViewBannerBottom.rootViewController = self
        
    }
    
    func presentBannerAd() {
        
        // top banner
        
        sportsViewBannerTop.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        sportsViewBannerTop.load(GADRequest())
        
        // bottom banner
        
        sportsViewBannerBottom.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        sportsViewBannerBottom.load(GADRequest())
    }
}





// Gad extention for delegate methods

extension SportsViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        hud.dismiss()
    }
    
}
