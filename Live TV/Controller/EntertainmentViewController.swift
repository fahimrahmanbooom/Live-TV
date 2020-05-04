//
//  EntertainmentViewController.swift
//  Live TV
//
//  Created by Fahim Rahman on 22/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVKit
import JGProgressHUD

final class EntertainmentViewController: UIViewController {
    
    @IBOutlet weak var enterViewBannerTop: GADBannerView!
    @IBOutlet weak var enterViewBannerBottom: GADBannerView!
    
    @IBOutlet weak var enterTableView: UITableView!
    
    
    private let hud = JGProgressHUD(style: .dark)
    
    private let avPlayer = AVPlayerViewController()
    
    private var response: Base!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.position = .center
        
//        enterViewBannerTop.delegate = self
//        enterViewBannerBottom.delegate = self
        
        enterTableView.delegate = self
        enterTableView.dataSource = self
        
        enterTableView.backgroundColor = UIColor(red: 41/255, green: 41/255, blue: 43/255, alpha: 1)
        
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


extension EntertainmentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return response.entertainment?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EnterTableViewCell = enterTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EnterTableViewCell
        
        cell.channelImageView.image = UIImage(named: (response.entertainment?[indexPath.row].image)!)
        cell.channelNameLabel.text = response.entertainment?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: (response.entertainment?[indexPath.row].link)!) else { return }
        let video = AVPlayer(url: url)
        avPlayer.player = video
        
        self.present(avPlayer, animated: true, completion: {
            
            video.play()
        })
    }
}







// ad extension

extension EntertainmentViewController {
    
    func prepareBannerAd() {
        
        // top banner
        enterViewBannerTop.adUnitID = "ca-app-pub-8021061863868813/4630812014"
        enterViewBannerTop.rootViewController = self
        
        
        // bottom banner
        enterViewBannerBottom.adUnitID = "ca-app-pub-8021061863868813/8378485332"
        enterViewBannerBottom.rootViewController = self
        
    }
    
    func presentBannerAd() {
        
        // top banner
        
        enterViewBannerTop.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        enterViewBannerTop.load(GADRequest())
        
        // bottom banner
        
        enterViewBannerBottom.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        enterViewBannerBottom.load(GADRequest())
    }
}





// Gad extention for delegate methods

//extension EntertainmentViewController: GADBannerViewDelegate {
//
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        hud.dismiss()
//    }
//
//}
