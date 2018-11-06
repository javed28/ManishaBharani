//
//  SecondViewController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/6/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleMobileAds

class SecondViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate,GADInterstitialDelegate {
    var indicator = UIActivityIndicatorView()
    var catId : String!
    var selectRecipeId : String!
    var selectRecipeName : String!
    
    @IBOutlet weak var bannerView: GADBannerView!
    var fullScreenAds : GADInterstitial!
    @IBOutlet weak var topBannerView: GADBannerView!
    var cuisineCategoryData : NSMutableArray = NSMutableArray()
    var dataDishCount : [String] = []
    @IBOutlet weak var cuisineCategory: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cuisineCategoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cuisineCategory.dequeueReusableCell(withIdentifier: "categoryIdentifier", for: indexPath) as! CategoryViewCell
        cell.selectionStyle = .none
        // cell.cuisineImage.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:160)
        
        let cuisineData  = self.cuisineCategoryData[indexPath.row] as! CatInfo
        
        cell.secBorderView.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:210)
        cell.secBorderView.layer.borderWidth = 1.5
        cell.secBorderView.layer.borderColor = UIColor.rgb(hexcolor: "#ccad72").cgColor
        cell.secIndicator.startAnimating()
        cell.secCuisineImage.frame = CGRect(x:3,y:3,width:cell.secBorderView.frame.width - 6,height:203)
        cell.secIndicator.frame = CGRect(x:self.view.frame.width/2-30,y:self.view.frame.height/2-30,width:60,height:60)
        
        cell.secCatName.frame = CGRect(x:3,y:152,width:cell.secBorderView.frame.width-6,height:55)
        
        
        
        cell.secBottomView.layer.zPosition = 1;
        cell.secBottomView.bringSubview(toFront: cell.secCuisineImage);
        
        cell.secBottomView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        cell.secBottomView.frame = CGRect(x:3,y:152,width:cell.secBorderView.frame.width-6,height:55)
        cell.secBottomView.addSubview(cell.secCatName)
        cell.secBottomView.addSubview(cell.seclblCatCount)
        
        
        cell.secCatName.frame = CGRect(x:3,y:0,width:cell.secBottomView.frame.width-6,height:55)
        cell.secCatName.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.secCatName.textAlignment = NSTextAlignment.left
        cell.secCatName.textColor = UIColor.white
        var catImageData : String = cuisineData.catImage
        var catNameData : String = cuisineData.catName
        cell.secCatName.text = "   "+catNameData
        
        cell.seclblCatCount.frame = CGRect(x:cell.secBottomView.frame.width-120,y:0,width:80,height:55)
        cell.seclblCatCount.text = "( "+dataDishCount[indexPath.row]+" )"
        cell.seclblCatCount.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.seclblCatCount.textAlignment = NSTextAlignment.right
        cell.seclblCatCount.textColor = UIColor.white
        

        cell.secBorderView.addSubview(cell.secBottomView)
        cell.secBorderView.addSubview(cell.secCuisineImage)
        cell.secBorderView.addSubview(cell.secIndicator)
    
       
        //cell.imgrecomend.image = UIImage(named : ServerUrl.base_image_url+recommendImage)
        let CuisineImageWithSpace = catImageData.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        let thumbImageUrl  =   NSURL(string: ServerUrl.base_image_url+CuisineImageWithSpace)
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: thumbImageUrl as URL?, options: SDWebImageDownloaderOptions.useNSURLCache, progress: nil,  completed: { (image, data, error, bool) -> Void in
            if image != nil {
                DispatchQueue.main.async{
                    cell.secCuisineImage.image = image
                    cell.secIndicator.stopAnimating()
                }
            }
        })
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
        let cuisineData  = self.cuisineCategoryData[indexPath.row] as! CatInfo
        selectRecipeId = cuisineData.catId
        selectRecipeName = cuisineData.catName
        if(dataDishCount[indexPath.row] == "0"){
            displayAlertMessage(userMessage: "No Recipe for This Category")
        }else{
            self.fullScreenAds = CreatedandLoadIntertitial()
        self.performSegue(withIdentifier: "showReciepeIdentifier", sender: self)
    }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReciepeIdentifier" {
            let addEventLisner = segue.destination as! ListReceipeViewController
            addEventLisner.reciepeId = selectRecipeId
            addEventLisner.lastrecpName = selectRecipeName
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x:0,y:0,width:50,height:50))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    func categoryDataFromServer(){
        
        let parameters = "id=0"
        // print ("catId",labeltxt)
        // let url = URL(ServerUrl.home_url)! //change the url
        let url = URL(string: ServerUrl.LIST_CATEGORY)!
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        activityIndicator()
        indicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        do {
            request.httpBody = parameters.data(using: String.Encoding.utf8)
        }
        
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
                //print("category json--",json)
                let Status = json?.object(forKey: "status") as? String;
                DispatchQueue.main.async {
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                
                if (Status == "200")
                {
                    let data = json?.object(forKey: "data") as? [NSDictionary]
                     let dataCount = json?.object(forKey: "count") as? [NSDictionary]
                    for i in 0..<data!.count{
                        let jsonObject = data![i]
                        let catInfo = CatInfo()
                        catInfo.catId = jsonObject.object(forKey: "id") as? String
                        catInfo.catName = jsonObject.object(forKey: "name") as? String
                        catInfo.catImage = jsonObject.object(forKey: "image") as? String
                        self.cuisineCategoryData.add(catInfo)
                    }
                    for i in 0..<dataCount!.count{
                        let jsonObject = dataCount![i]
                        
                        self.dataDishCount.append((jsonObject.object(forKey: "count") as? String)!)
                        
                    }
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.cuisineCategory.reloadData()
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
    
    func displayAlertMessage(userMessage : String){
        let myAlert = UIAlertController(title:"Manish Bharani",message : userMessage,preferredStyle: UIAlertControllerStyle.alert)
        
        let OkAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
            
            //self.performSegue(withIdentifier: "afterregister", sender: self)
        }
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("add loaded")
        ad.present(fromRootViewController: self)
    }
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("add failed")
    }
    func CreatedandLoadIntertitial() -> GADInterstitial?{
        fullScreenAds  = GADInterstitial(adUnitID:"ca-app-pub-7638083441432626/5740469971")
        guard let fullScreenAds = fullScreenAds else {
            return nil
        }
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        fullScreenAds.load(request)
        fullScreenAds.delegate = self
        return fullScreenAds
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        categoryDataFromServer()
     
        //addBannerViewToView(bannerView)
       
        
        
        let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        bannerView.adUnitID = "ca-app-pub-7638083441432626/6186180770"
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(request)
        
    
        topBannerView.adUnitID = "ca-app-pub-7638083441432626/9524281249"
        topBannerView.rootViewController = self
        topBannerView.delegate = self
        topBannerView.load(request)
        
    }
//    func addBannerViewToView(_ bannerView: GADBannerView) {
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView,
//                                attribute: .bottom,
//                                relatedBy: .equal,
//                                toItem: bottomLayoutGuide,
//                                attribute: .top,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//            ])
//    }
    

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
        self.cuisineCategory.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }


}

