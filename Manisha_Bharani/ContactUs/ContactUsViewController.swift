//
//  ContactUsViewController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/7/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ContactUsViewController: UIViewController,GADBannerViewDelegate {

    @IBOutlet weak var lblTopLabel: UILabel!
    @IBOutlet weak var lblAppOverview: UIView!
    @IBOutlet weak var lblAppInfo: UILabel!
    @IBOutlet weak var lblAppVersion: UILabel!
    
    @IBOutlet weak var imgAppStore: UIImageView!
    //@IBOutlet weak var lblRateUs: UILabel!
    @IBOutlet weak var btnRateUs: UIButton!
    @IBOutlet weak var lblConnectUs: UILabel!
    
    @IBOutlet weak var viewConnect: UIView!
    
    
    @IBOutlet weak var viewFeedback: UIView!
    @IBOutlet weak var viewContactUs: UIView!
    @IBOutlet weak var viewWebsite: UIView!
    @IBOutlet weak var viewFacebook: UIView!
    @IBOutlet weak var viewTwitter: UIView!
    @IBOutlet weak var viewInstagram: UIView!
    @IBOutlet weak var viewYouTube: UIView!
    
    @IBOutlet weak var imgFeedback: UIImageView!
    @IBOutlet weak var btnFeedback: UIButton!
    
    @IBOutlet weak var imgContactUs: UIImageView!
    @IBOutlet weak var btnContactUs: UIButton!
    
    @IBOutlet weak var imgWebsite: UIImageView!
    @IBOutlet weak var btnWebsite: UIButton!
    
    @IBOutlet weak var imgFacebook: UIImageView!
    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBOutlet weak var imgTwitter: UIImageView!
    @IBOutlet weak var btnTwitter: UIButton!
    
    @IBOutlet weak var btnInstagram: UIButton!
    @IBOutlet weak var imgInstagram: UIImageView!
    
    
    @IBOutlet weak var btnYouTube: UIButton!
    @IBOutlet weak var imgYouTube: UIImageView!
    
    @IBOutlet weak var topBannerView: GADBannerView!
    
    @IBOutlet weak var bottomBannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = GADRequest()
       // request.testDevices = [kGADSimulatorID]
        topBannerView.adUnitID = "ca-app-pub-7638083441432626/6186180770"
        topBannerView.rootViewController = self
        topBannerView.delegate = self
        topBannerView.load(request)
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
//        bottomBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: view.frame.size.width, height: 50))
//        bottomBannerView.frame = CGRect(x: 0, y: screenHeight - 50.0, width: view.frame.size.width, height: 50)
        bottomBannerView.adUnitID = "ca-app-pub-7638083441432626/9524281249"
        bottomBannerView.rootViewController = self
        bottomBannerView.delegate = self
        bottomBannerView.load(request)
        
        lblTopLabel.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:70)
        
        
        self.lblAppOverview.frame = CGRect(x:10,y:80,width:self.view.frame.width-20,height:100)
        
        // Creates the Top border
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: self.lblAppOverview.frame.height - 1.0, width: self.lblAppOverview.frame.width , height:2.0)
        topBorder.backgroundColor = UIColor.rgb(hexcolor: "#e4e4e4").cgColor
        self.lblAppOverview.layer.addSublayer(topBorder)
        
        // Creates the Botttom border
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 0, width: self.lblAppOverview.frame.width, height: 2)
        bottomBorder.backgroundColor = UIColor.rgb(hexcolor: "#e4e4e4").cgColor
        self.lblAppOverview.layer.addSublayer(bottomBorder)
        
        self.lblAppInfo.frame = CGRect(x:10,y:0,width:self.lblAppOverview.frame.width-20,height:60)
        self.lblAppVersion.frame = CGRect(x:10,y:self.lblAppInfo.intrinsicContentSize.height+20,width:self.lblAppOverview.frame.width-20,height:60)
        
        self.lblAppOverview.addSubview(self.lblAppInfo)
        self.lblAppOverview.addSubview(self.lblAppVersion)
        imgAppStore.frame = CGRect(x:10,y:198,width:35,height:35)
        //lblRateUs.frame = CGRect(x:55,y:198,width:self.view.frame.width-20,height:40)
        btnRateUs.frame = CGRect(x:55,y:198,width:self.view.frame.width-20,height:40)
        viewConnect.frame = CGRect(x:10,y:253,width:self.view.frame.width-20,height:50)
        lblConnectUs.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:40)
        let bottomBorderConnect = CALayer()
        bottomBorderConnect.frame = CGRect(x: 0, y: 0, width: self.viewConnect.frame.width, height: 2)
        bottomBorderConnect.backgroundColor = UIColor.rgb(hexcolor: "#e4e4e4").cgColor
        self.viewConnect.layer.addSublayer(bottomBorderConnect)
        

        
        viewFeedback.frame = CGRect(x:5,y:300,width:self.view.frame.width-10,height:50)
        viewContactUs.frame = CGRect(x:5,y:360,width:self.view.frame.width-10,height:60)
        viewWebsite.frame = CGRect(x:5,y:420,width:self.view.frame.width-10,height:60)
        viewFacebook.frame = CGRect(x:5,y:480,width:self.view.frame.width-10,height:60)
        viewTwitter.frame = CGRect(x:5,y:545,width:self.view.frame.width-10,height:50)
        viewInstagram.frame = CGRect(x:5,y:600,width:self.view.frame.width-10,height:60)
        viewYouTube.frame = CGRect(x:5,y:660,width:self.view.frame.width-10,height:50)
        
        
        // Creates the Contact Top border
        let contactTopBorder = CALayer()
        contactTopBorder.frame = CGRect(x: 0, y: self.viewContactUs.frame.height - 1.0, width: self.viewContactUs.frame.width , height:2.0)
        contactTopBorder.backgroundColor = UIColor.rgb(hexcolor: "#e4e4e4").cgColor
        self.viewContactUs.layer.addSublayer(contactTopBorder)
        
        // Creates the Contact Botttom border
        let contactBottomBorder = CALayer()
        contactBottomBorder.frame = CGRect(x: 0, y: 0, width: self.viewContactUs.frame.width, height: 2)
        contactBottomBorder.backgroundColor = UIColor.rgb(hexcolor: "#e4e4e4").cgColor
        self.viewContactUs.layer.addSublayer(contactBottomBorder)
        
        
        
        // Creates the Facebook Top border
        let facebookTopBorder = CALayer()
        facebookTopBorder.frame = CGRect(x: 0, y: self.viewFacebook.frame.height - 1.0, width: self.viewFacebook.frame.width , height:2.0)
        facebookTopBorder.backgroundColor = UIColor.rgb(hexcolor: "#e4e4e4").cgColor
        self.viewFacebook.layer.addSublayer(facebookTopBorder)
        
        // Creates the Facebook Botttom border
        let facebookBottomBorder = CALayer()
        facebookBottomBorder.frame = CGRect(x: 0, y: 0, width: self.viewFacebook.frame.width, height: 2)
        facebookBottomBorder.backgroundColor = UIColor.rgb(hexcolor: "#e4e4e4").cgColor
        self.viewFacebook.layer.addSublayer(facebookBottomBorder)
        
        
        // Creates the Instagram Top border
        let instagramTopBorder = CALayer()
        instagramTopBorder.frame = CGRect(x: 0, y: self.viewInstagram.frame.height - 1.0, width: self.viewInstagram.frame.width , height:2.0)
        instagramTopBorder.backgroundColor = UIColor.rgb(hexcolor: "#e4e4e4").cgColor
        self.viewInstagram.layer.addSublayer(instagramTopBorder)
        
        // Creates the Instagram Botttom border
        let instagramBottomBorder = CALayer()
        instagramBottomBorder.frame = CGRect(x: 0, y: 0, width: self.viewInstagram.frame.width, height: 2)
        instagramBottomBorder.backgroundColor = UIColor.rgb(hexcolor: "#e4e4e4").cgColor
        self.viewInstagram.layer.addSublayer(instagramBottomBorder)
        
        
        
        btnFeedback.contentHorizontalAlignment = .left
        btnContactUs.contentHorizontalAlignment = .left
        btnInstagram.contentHorizontalAlignment = .left
        btnYouTube.contentHorizontalAlignment = .left
        btnTwitter.contentHorizontalAlignment = .left
        btnWebsite.contentHorizontalAlignment = .left
        btnFacebook.contentHorizontalAlignment = .left
        
        //Feedback Link
        imgFeedback.frame = CGRect(x:10,y:18,width:20,height:20)
        btnFeedback.frame = CGRect(x:45,y:8,width:self.viewFeedback.frame.width-20,height:40)
        viewFeedback.addSubview(imgFeedback)
        viewFeedback.addSubview(btnFeedback)
        
        //Contact Us Link
        imgContactUs.frame = CGRect(x:10,y:20,width:20,height:20)
        btnContactUs.frame = CGRect(x:45,y:10,width:self.viewContactUs.frame.width-20,height:40)
        viewContactUs.addSubview(imgContactUs)
        viewContactUs.addSubview(btnContactUs)
        
        //Website Link
        imgWebsite.frame = CGRect(x:10,y:20,width:20,height:20)
        btnWebsite.frame = CGRect(x:45,y:10,width:self.viewWebsite.frame.width-20,height:40)
        viewWebsite.addSubview(imgWebsite)
        viewWebsite.addSubview(btnWebsite)
        
        //Facebook Link
        imgFacebook.frame = CGRect(x:10,y:20,width:20,height:20)
        btnFacebook.frame = CGRect(x:45,y:10,width:self.viewFacebook.frame.width-20,height:40)
        viewFacebook.addSubview(imgFacebook)
        viewFacebook.addSubview(btnFacebook)
        
        //Twitter Link
        imgTwitter.frame = CGRect(x:10,y:15,width:20,height:20)
        btnTwitter.frame = CGRect(x:45,y:5,width:self.viewTwitter.frame.width-20,height:40)
        viewTwitter.addSubview(imgTwitter)
        viewTwitter.addSubview(btnTwitter)
        
        //Instagram Link
        imgInstagram.frame = CGRect(x:10,y:20,width:20,height:20)
        btnInstagram.frame = CGRect(x:45,y:10,width:self.viewInstagram.frame.width-20,height:40)
        viewInstagram.addSubview(imgInstagram)
        viewInstagram.addSubview(btnInstagram)
        
        //Youtube Link
        imgYouTube.frame = CGRect(x:10,y:20,width:20,height:20)
        btnYouTube.frame = CGRect(x:45,y:10,width:self.viewYouTube.frame.width-20,height:40)
        viewYouTube.addSubview(btnYouTube)
        viewYouTube.addSubview(btnYouTube)
        
        btnFeedback.addTarget(self, action : #selector(btnSendFeedback), for: .touchUpInside)
        
        
    }
    @objc func btnSendFeedback(_ sender: UIButton){
        self.performSegue(withIdentifier: "sendFeedbackIdentifier", sender: self)
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
    
    @IBAction func btnRateUsClicked(_ sender: Any) {
        
        rateApp(appId: "id1339162004") { success in
            print("RateApp \(success)")
        }
    }
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
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
