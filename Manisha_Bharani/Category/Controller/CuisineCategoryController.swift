//
//  CuisineCategoryController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/8/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleMobileAds

class CuisineCategoryController: UIViewController,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate,GADInterstitialDelegate{
     var indicator = UIActivityIndicatorView()
    var catId : String!
    var selectRecipeId : String!
    var selectRecipeName : String!
    var cuisineCategoryData : NSMutableArray = NSMutableArray()
    @IBOutlet weak var cuisineCategory: UITableView!
      var fullScreenAds : GADInterstitial!
    var dataDishCount : [String] = []
    @IBOutlet weak var bttomBannerView: GADBannerView!
    @IBOutlet weak var topBannerView: GADBannerView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cuisineCategoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cuisineCategory.dequeueReusableCell(withIdentifier: "categoryIdentifier", for: indexPath) as! CategoryViewCell
        cell.selectionStyle = .none
       // cell.cuisineImage.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:160)
        
        let cuisineData  = self.cuisineCategoryData[indexPath.row] as! CatInfo
        
        cell.borderView.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:210)
        cell.borderView.layer.borderWidth = 1.5
        cell.borderView.layer.borderColor = UIColor.rgb(hexcolor: "#ccad72").cgColor
        cell.indicator.startAnimating()
        cell.cuisineImage.frame = CGRect(x:3,y:3,width:cell.borderView.frame.width - 6,height:203)
        cell.indicator.frame = CGRect(x:self.view.frame.width/2-30,y:self.view.frame.height/2-30,width:60,height:60)
        
        
        
        cell.bottomView.layer.zPosition = 1;
        cell.bottomView.bringSubview(toFront: cell.cuisineImage);
        
        cell.bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        cell.bottomView.frame = CGRect(x:3,y:152,width:cell.borderView.frame.width-6,height:55)
        cell.bottomView.addSubview(cell.catName)
        cell.bottomView.addSubview(cell.lblCatCount)
        
        
        cell.catName.frame = CGRect(x:3,y:0,width:cell.bottomView.frame.width-6,height:55)
        cell.catName.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.catName.textAlignment = NSTextAlignment.left
        cell.catName.textColor = UIColor.white
        var catImageData : String = cuisineData.catImage
        var catNameData : String = cuisineData.catName
        cell.catName.text = "   "+catNameData
        
        cell.lblCatCount.frame = CGRect(x:cell.bottomView.frame.width-120,y:0,width:80,height:55)
        cell.lblCatCount.text = "( "+dataDishCount[indexPath.row]+" )"
        cell.lblCatCount.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.lblCatCount.textAlignment = NSTextAlignment.right
        cell.lblCatCount.textColor = UIColor.white
        
        
       
        
       
        //cell.imgrecomend.image = UIImage(named : ServerUrl.base_image_url+recommendImage)
        //let thumbImageUrl  =   NSURL(string: ServerUrl.base_image_url+catImageData)
        let CuisineImageWithSpace = catImageData.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        let thumbImageUrl  =   NSURL(string: ServerUrl.base_image_url+CuisineImageWithSpace)
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: thumbImageUrl as URL?, options: SDWebImageDownloaderOptions.useNSURLCache, progress: nil,  completed: { (image, data, error, bool) -> Void in
            if image != nil {
                DispatchQueue.main.async{
                    cell.cuisineImage.image = image
                    cell.indicator.stopAnimating()
                }
            }
        })
        cell.borderView.addSubview(cell.bottomView)
        cell.borderView.addSubview(cell.cuisineImage)
        cell.borderView.addSubview(cell.indicator)
        
        return cell
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
    func categoryDataFromServer(catId : String){
        
        let parameters = "id=\(catId)"
         //print ("catId-------",parameters)
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("cuisine ID-----",catId)
        // Do any additional setup after loading the view.
        categoryDataFromServer(catId: catId)
        
        let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        topBannerView.adUnitID = "ca-app-pub-7638083441432626/6186180770"
        topBannerView.rootViewController = self
        topBannerView.delegate = self
        topBannerView.load(request)
        
        bttomBannerView.adUnitID = "ca-app-pub-7638083441432626/9524281249"
        bttomBannerView.rootViewController = self
        bttomBannerView.delegate = self
        bttomBannerView.load(request)
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
       self.cuisineCategory.separatorStyle = UITableViewCellSeparatorStyle.none
        
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
