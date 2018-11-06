//
//  AboutUsViewController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/7/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AboutUsViewController: UIViewController,GADBannerViewDelegate {
    var indicator = UIActivityIndicatorView()
    
    
    @IBOutlet weak var lblTopDesc: UILabel!
    @IBOutlet weak var viewBelowlblDesc: UIView!
    @IBOutlet weak var lblabout2: UILabel!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var socialView: UIView!
    
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnWebsite: UIButton!
    
    
    @IBOutlet weak var lblFacebook: UILabel!
    @IBOutlet weak var lblTwitter: UILabel!
    @IBOutlet weak var lblInstagram: UILabel!
    @IBOutlet weak var lblYouTubeChannel: UILabel!
    @IBOutlet weak var lblGooglePlus: UILabel!
    
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnInstagram: UIButton!
    @IBOutlet weak var btnYoutube: UIButton!
    @IBOutlet weak var btnGooglePlus: UIButton!
    
    var maxLabelSize : CGSize!
    
    var id : String!
    var facebook_url : String!
    var twitter_url : String!
    var youtube_url : String!
    var instagram_url : String!
    var gplus_url :String!
    
    var app_description : String!
    var email_address : String!
    var website_url : String!
    var mobile_no : String!
    var full_address : String!
    var about_line1 : String!
    var about_line2 : String!
    
    @IBOutlet weak var topBannerView: GADBannerView!
    
    @IBOutlet weak var bottomBannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutUsData()
       
       
        let labelWidth = self.view.frame.width - 20
         maxLabelSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        lblTopDesc.frame = CGRect(x:10,y:40,width:labelWidth,height:CGFloat.greatestFiniteMagnitude)
        
        viewBelowlblDesc.isHidden = true
        lblabout2.isHidden = true
        self.lblTopDesc.isHidden = true
        emailView.isHidden = true
        socialView.isHidden = true
        let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        topBannerView.adUnitID = "ca-app-pub-7638083441432626/6186180770"
        topBannerView.rootViewController = self
        topBannerView.delegate = self
        topBannerView.load(request)
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        //bottomBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: view.frame.size.width, height: 50))
        //bottomBannerView.frame = CGRect(x: 0, y: screenHeight - 50.0, width: view.frame.size.width, height: 50)
        bottomBannerView.adUnitID = "ca-app-pub-7638083441432626/6186180770"
        bottomBannerView.rootViewController = self
        bottomBannerView.delegate = self
        bottomBannerView.load(request)
        
        
//        banner.adUnitID = "ca-app-pub-7638083441432626/6186180770"
//        banner.rootViewController = self
//        banner.delegate = self
//        let req:GADRequest = GADRequest()
//        banner.load(req)
    
       // bottomBannerView.frame = CGRect(x:0,y:screenHeight-100,width:view.frame.size.width,height:50)
    
        
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
    func displayAlertMessage(userMessage : String){
        let myAlert = UIAlertController(title:"Manish Bharani",message : userMessage,preferredStyle: UIAlertControllerStyle.alert)
        
        let OkAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
            
            //self.performSegue(withIdentifier: "afterregister", sender: self)
        }
        self.present(myAlert, animated: true, completion: nil)
    }
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x:0,y:0,width:50,height:50))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    @IBAction func btnInstagramClicke(_ sender: Any) {
        var instagramHooks = "http:www.instagram.com/"+self.instagram_url
        var instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "http://instagram.com/")! as URL)
        }
    }
    
    @IBAction func btnWebsiteClicked(_ sender: Any) {
        if let url = NSURL(string: "http:www."+self.website_url){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func btnGmailClicked(_ sender: Any) {
        print("gmail address",self.email_address)
        if let url = NSURL(string: "mailto:"+self.email_address) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnFacebookClicked(_ sender: Any) {
      
        let fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/"+self.facebook_url)!
        var fbURLID: NSURL = NSURL(string: "fb://profile/"+self.facebook_url)!
        if(UIApplication.shared.canOpenURL(fbURLID as URL)){
            // FB installed
            UIApplication.shared.openURL(fbURLID as URL)
        } else {
            // FB is not installed, open in safari
            UIApplication.shared.openURL(fbURLWeb as URL)
        }
    }
    
    @IBAction func btnTwitterClicked(_ sender: Any) {
        
    }
    
    @IBAction func btnYoutubeClicked(_ sender: Any) {
        
        var youtubeUrl = NSURL(string:"https://www.youtube.com/"+self.youtube_url)!
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            UIApplication.shared.openURL(youtubeUrl as URL)
        } else{
            //youtubeUrl = NSURL(youtubeUrl)!
            UIApplication.shared.openURL(youtubeUrl as URL)
        }
    }
    
    
    @IBAction func btnGooglePlusClicked(_ sender: Any) {
        
    }
    
    func aboutUsData(){
        
        //let parameters = "id=0"
        // print ("catId",labeltxt)
        // let url = URL(ServerUrl.home_url)! //change the url
        let url = URL(string: ServerUrl.MORE_INFO)!
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        activityIndicator()
        indicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
//        do {
//            request.httpBody = parameters.data(using: String.Encoding.utf8)
//        }
//
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                print("category json--",json)
                let Status = json?.object(forKey: "status") as? String;
                DispatchQueue.main.async {
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                
                if (Status == "200")
                {
                    let links = json?.object(forKey: "links") as? [NSDictionary]
                    let info = json?.object(forKey: "info") as? [NSDictionary]
                    for i in 0..<links!.count{
                        let jsonObject = links![i]
                        
                        self.id = jsonObject.object(forKey: "id") as? String
                         self.facebook_url = jsonObject.object(forKey: "facebook_url") as? String
                         self.twitter_url = jsonObject.object(forKey: "twitter_url") as? String
                         self.youtube_url = jsonObject.object(forKey: "youtube_url") as? String
                         self.instagram_url = jsonObject.object(forKey: "instagram_url") as? String
                         self.gplus_url = jsonObject.object(forKey: "gplus_url") as? String
                       
                      
                    }
                    for i in 0..<info!.count{
                        let jsonObject = info![i]
                        
                         self.app_description = jsonObject.object(forKey: "app_description") as? String
                         self.email_address = jsonObject.object(forKey: "email_address") as? String
                         self.website_url = jsonObject.object(forKey: "website_url") as? String
                         self.mobile_no = jsonObject.object(forKey: "mobile_no") as? String
                         self.full_address = jsonObject.object(forKey: "full_address") as? String
                         self.about_line1 = jsonObject.object(forKey: "about_line1") as? String
                         self.about_line2 = jsonObject.object(forKey: "about_line2") as? String
                        
                    }
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.lblTopDesc.isHidden = false
                        
                        self.indicator.isHidden = true
                        self.viewBelowlblDesc.isHidden = false
                        self.lblabout2.isHidden = false
                        let abtLine1 = self.about_line1.replacingOccurrences(of: "&#039;", with: "'")
                         let abtLine2 = abtLine1.replacingOccurrences(of: "&amp;", with: " & ")
                        self.lblTopDesc.text = abtLine2
                        self.lblTopDesc.sizeToFit()
                        let newString1 = self.about_line2.replacingOccurrences(of: "&#039;", with: "'")
                        let newString2 = newString1.replacingOccurrences(of: "&amp;", with: " & ")
                        self.lblabout2.text = newString2
                        self.lblabout2.sizeToFit()
                        self.emailView.isHidden = false
                        self.socialView.isHidden = false
                        
                        let actualLabelSize = self.lblTopDesc.text!.boundingRect(with: self.maxLabelSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: self.lblTopDesc.font], context: nil)
                        let labelHeight = actualLabelSize.height
                        
                        //Sencond Layout yaha se
                        
                        self.viewBelowlblDesc.frame = CGRect(x:10,y:labelHeight+20,width:self.view.frame.width-20,height:70)
                        
                         // Creates the Top border
                        let topBorder = CALayer()
                        topBorder.frame = CGRect(x: 0, y: self.viewBelowlblDesc.frame.height - 1.0, width: self.viewBelowlblDesc.frame.width , height:4.0)
                        topBorder.backgroundColor = UIColor.rgb(hexcolor: "#767676").cgColor
                        self.viewBelowlblDesc.layer.addSublayer(topBorder)
                    
                        // Creates the Botttom border
                        let bottomBorder = CALayer()
                        bottomBorder.frame = CGRect(x: 0, y: 0, width: self.viewBelowlblDesc.frame.width, height: 4)
                        bottomBorder.backgroundColor = UIColor.rgb(hexcolor: "#767676").cgColor
                        self.viewBelowlblDesc.layer.addSublayer(bottomBorder)
                        
                        self.lblabout2.frame = CGRect(x:0,y:10,width:self.viewBelowlblDesc.frame.width-20,height:60)
                        self.viewBelowlblDesc.addSubview(self.lblabout2)
                        
                        
                        //Email View Start yaha se
                        
                         self.emailView.frame = CGRect(x:10,y:self.viewBelowlblDesc.frame.origin.y+self.viewBelowlblDesc.frame.height+10,width:self.view.frame.width-20,height:90)
                        

                        let emailBottomBorder = CALayer()
                        emailBottomBorder.frame = CGRect(x: 0, y: 91, width: self.emailView.frame.width, height: 4)
                        emailBottomBorder.backgroundColor = UIColor.rgb(hexcolor: "#767676").cgColor
                        self.emailView.layer.addSublayer(emailBottomBorder)
                        
                        self.lblEmail.frame = CGRect(x:10,y:10,width:self.lblEmail.intrinsicContentSize.width,height:40)
                        self.lblWebsite.frame = CGRect(x:10,y:45,width:self.lblWebsite.intrinsicContentSize.width,height:40)
                        
                        
                        self.btnEmail.frame = CGRect(x:self.lblEmail.intrinsicContentSize.width + 20,y:10,width:self.emailView.frame.width,height:40)
                        
                        self.btnWebsite.frame = CGRect(x:self.lblWebsite.intrinsicContentSize.width + 20,y:45,width:self.emailView.frame.width,height:40)
                        self.btnEmail.contentHorizontalAlignment = .left
                        self.btnWebsite.contentHorizontalAlignment = .left
                        let attributedStringEmail = NSAttributedString(string: self.email_address, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "#0950d0")])
                        self.btnEmail.setAttributedTitle(attributedStringEmail, for: UIControlState.normal)
                        
                        let attributedStringWeb = NSAttributedString(string: self.website_url, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "#0950d0")])
                        self.btnWebsite.setAttributedTitle(attributedStringWeb, for: UIControlState.normal)
                        
                        //self.btnEmail.setTitle(self.email_address, for: .normal)
                        //self.btnWebsite.setTitle(self.website_url, for: .normal)
                        
                        
                        self.emailView.addSubview(self.lblEmail)
                        self.emailView.addSubview(self.lblWebsite)
                        self.emailView.addSubview(self.btnEmail)
                        self.emailView.addSubview(self.btnWebsite)
                        
                        
                        
                        
                        
                        //Social View start yaha se
                        self.socialView.frame = CGRect(x:10,y:self.emailView.frame.origin.y+self.emailView.frame.height+10,width:self.view.frame.width-20,height:290)
                        
                        
                        self.lblFacebook.frame = CGRect(x:10,y:10,width:self.lblFacebook.intrinsicContentSize.width,height:40)
                        self.lblTwitter.frame = CGRect(x:10,y:55,width:self.lblTwitter.intrinsicContentSize.width,height:40)
                        self.lblInstagram.frame = CGRect(x:10,y:105,width:self.lblInstagram.intrinsicContentSize.width,height:40)
                        self.lblYouTubeChannel.frame = CGRect(x:10,y:155,width:self.lblYouTubeChannel.intrinsicContentSize.width,height:40)
                        self.lblGooglePlus.frame = CGRect(x:10,y:205,width:self.lblGooglePlus.intrinsicContentSize.width,height:40)
                        
                        
                         self.btnFacebook.frame = CGRect(x:self.lblFacebook.intrinsicContentSize.width + 20,y:10,width:self.emailView.frame.width-self.lblFacebook.intrinsicContentSize.width-40,height:40)
                        
                         self.btnTwitter.frame = CGRect(x:self.lblTwitter.intrinsicContentSize.width + 20,y:55,width:self.emailView.frame.width-self.lblTwitter.intrinsicContentSize.width-40,height:40)
                        
                        self.btnInstagram.frame = CGRect(x:self.lblInstagram.intrinsicContentSize.width + 20,y:105,width:self.emailView.frame.width-self.lblInstagram.intrinsicContentSize.width-40,height:40)
                        
                         self.btnYoutube.frame = CGRect(x:self.lblYouTubeChannel.intrinsicContentSize.width + 20,y:155,width:self.emailView.frame.width-self.lblYouTubeChannel.intrinsicContentSize.width-40,height:40)
                         self.btnGooglePlus.frame = CGRect(x:self.lblGooglePlus.intrinsicContentSize.width + 20,y:205,width:self.emailView.frame.width-self.lblGooglePlus.intrinsicContentSize.width-40,height:40)
   
                        
                        let attributedStringfb = NSAttributedString(string: "https://m.facebook.com/"+self.facebook_url, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "#0950d0")])
                        self.btnFacebook.setAttributedTitle(attributedStringfb, for: UIControlState.normal)
                        
                        let attributedStringtwt = NSAttributedString(string: "http://www.twitter.com/"+self.twitter_url, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "#0950d0")])
                        self.btnTwitter.setAttributedTitle(attributedStringtwt, for: UIControlState.normal)
                        
                        let attributedStringInst = NSAttributedString(string: "http:www.instagram.com/"+self.instagram_url, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "#0950d0")])
                        self.btnInstagram.setAttributedTitle(attributedStringInst, for: UIControlState.normal)
                        
                        let attributedStringYou = NSAttributedString(string: "http://www.youtube.com/"+self.youtube_url, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "#0950d0")])
                        self.btnYoutube.setAttributedTitle(attributedStringYou, for: UIControlState.normal)
                        
                        let attributedStringGogle = NSAttributedString(string: "http://plus.google.com/"+self.gplus_url, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "#0950d0")])
                        self.btnGooglePlus.setAttributedTitle(attributedStringGogle, for: UIControlState.normal)
                        
 
                        
                        self.btnFacebook.contentHorizontalAlignment = .left
                        self.btnTwitter.contentHorizontalAlignment = .left
                        self.btnInstagram.contentHorizontalAlignment = .left
                        self.btnYoutube.contentHorizontalAlignment = .left
                        self.btnGooglePlus.contentHorizontalAlignment = .left
                        
                        
                        self.socialView.addSubview(self.lblFacebook)
                        self.socialView.addSubview(self.lblTwitter)
                        self.socialView.addSubview(self.lblInstagram)
                        self.socialView.addSubview(self.lblYouTubeChannel)
                        self.socialView.addSubview(self.lblGooglePlus)
                        
                        self.socialView.addSubview(self.btnFacebook)
                         self.socialView.addSubview(self.btnTwitter)
                         self.socialView.addSubview(self.btnYoutube)
                         self.socialView.addSubview(self.btnInstagram)
                         self.socialView.addSubview(self.btnGooglePlus)
                        
                        
    
                    }
                    
                }
                else if(Status == "220"){
                    
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    self.displayAlertMessage(userMessage: "No Product For this Category")
                }
                else{
                    
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    self.displayAlertMessage(userMessage: "No Product For this Category")
                }
                
                
                
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        
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
