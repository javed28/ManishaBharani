//
//  FacebookViewController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/7/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMobileAds
class FacebookViewController: UIViewController,GADBannerViewDelegate {

    @IBOutlet weak var facebookView: UIWebView!
    
    @IBOutlet weak var bottomBannerView: GADBannerView!
    @IBOutlet weak var topBannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: ServerUrl.facebook_url)
        let requestObj = URLRequest(url: url!)
        facebookView.loadRequest(requestObj)
        let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        topBannerView.adUnitID = "ca-app-pub-7638083441432626/6186180770"
        topBannerView.rootViewController = self
        topBannerView.delegate = self
        topBannerView.load(request)
        
        bottomBannerView.adUnitID = "ca-app-pub-7638083441432626/9524281249"
        bottomBannerView.rootViewController = self
        bottomBannerView.delegate = self
        bottomBannerView.load(request)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let logo = UIImage(named: "manisha_logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationController?.navigationBar.backgroundColor = UIColor.rgb(hexcolor: "#34495E")
        navigationController?.navigationBar.barTintColor = UIColor.rgb(hexcolor:"#34495E")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
