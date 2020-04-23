//
//  NewsViewController.swift
//  Live TV
//
//  Created by Fahim Rahman on 23/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVKit
import JGProgressHUD

final class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsViewBannerTop: GADBannerView!
    @IBOutlet weak var newsViewBannerBottom: GADBannerView!
    
    @IBOutlet weak var newsTableView: UITableView!
    
    private let hud = JGProgressHUD(style: .dark)
    
    private let avPlayer = AVPlayerViewController()
    
    private var response: Base!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.position = .center
        
        newsViewBannerTop.delegate = self
        newsViewBannerBottom.delegate = self
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.backgroundColor = .white
        
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


extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return response.news!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = newsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        cell.channelNameLabel.text = response.news?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: (response.news?[indexPath.row].link)!) else { return }
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

extension NewsViewController {
    
    func prepareBannerAd() {
        
        // top banner
        newsViewBannerTop.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        newsViewBannerTop.rootViewController = self
        
        
        // bottom banner
        newsViewBannerBottom.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        newsViewBannerBottom.rootViewController = self
        
    }
    
    func presentBannerAd() {
        
        // top banner
        
        newsViewBannerTop.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        newsViewBannerTop.load(GADRequest())
        
        // bottom banner
        
        newsViewBannerBottom.adSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.width)
        newsViewBannerBottom.load(GADRequest())
    }
}





// Gad extention for delegate methods

extension NewsViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        hud.dismiss()
    }
    
}
