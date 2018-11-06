//
//  ListReceipeViewController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/12/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit
import AACarousel
import Kingfisher
import SDWebImage
import GoogleMobileAds
class ListReceipeViewController: UIViewController,AACarouselDelegate,GADBannerViewDelegate,GADInterstitialDelegate {
    
    var indicator = UIActivityIndicatorView()
    @IBOutlet weak var carouselView: AACarousel!
    var imagePathArray = [String]()
    var reciepeId : String!
    var selectRecipeId : String!
    var selectedPosition : Int!
    var titleArray = [String]()
    var recepieId = [String]()
    var lastrecpName : String!
    var fullScreenAds : GADInterstitial!
    @IBOutlet weak var lstReceipeName: UILabel!
    var recipeData :  NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var topBannerView: GADBannerView!
    
    @IBOutlet weak var bottomBannerView: GADBannerView!
    
  
   
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let logo = UIImage(named: "manisha_logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationController?.navigationBar.backgroundColor = UIColor.rgb(hexcolor: "#34495E")
        navigationController?.navigationBar.barTintColor = UIColor.rgb(hexcolor:"#34495E")
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        listReceipeDataFromServer(reciId: reciepeId)
        lstReceipeName.frame = CGRect(x:20,y:120,width:self.view.frame.width-40,height:50)
        lstReceipeName.text = lastrecpName
       
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
    
    func listReceipeDataFromServer(reciId : String){
        let parameters = "id=\(reciId)"
         //print ("parameter",parameters)
        // let url = URL(ServerUrl.home_url)! //change the url
        let url = URL(string: ServerUrl.LIST_RECIPE)!
        //create the session object
        //print ("url------",url)
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        activityIndicator()
        indicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
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
            
                let Status = json?.object(forKey: "status") as? String;
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                   // UIApplication.shared.endIgnoringInteractionEvents()
                }
                
                if (Status == "200")
                {
                    let data = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<data!.count{
                        let jsonObject = data![i]
                        //let catInfo = CatInfo()
                        let recepiefinalId = jsonObject.object(forKey: "id") as? String
                        self.recepieId.append(recepiefinalId!)
                        
                        
                        let recepieImage = jsonObject.object(forKey: "image") as? String
                        let recipeImageWithSpace = recepieImage?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
                        self.imagePathArray.append(ServerUrl.base_image_url+recipeImageWithSpace!)
                        
                        let recepieName = jsonObject.object(forKey: "name") as? String
                        self.titleArray.append(recepieName!)
                        
                        let receipeInfo = ReceipeInfo()
                        receipeInfo.recepieId = recepiefinalId
                        receipeInfo.recepieName = recepieName
                        receipeInfo.recepieImage = ServerUrl.base_image_url+recipeImageWithSpace!
                        
                        self.recipeData.add(receipeInfo)
                    }
                    DispatchQueue.main.async {
                       
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.sliderData()
                        //self.cuisineCategory.reloadData()
                    }
                    
                }
                else if(Status == "220"){
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
    
    func sliderData(){
        
        //let imagePathArray = ["http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg"]
//        titleArray = ["picture 1","picture 2","picture 3","picture 4","picture 5"]
        self.carouselView.delegate = self
        self.carouselView.setCarouselData(paths: self.imagePathArray,  describedTitle: titleArray, isAutoScroll: false, timer: 100.0, defaultImage: "defaultImage")
       
        //optional methods
        
        self.carouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        self.carouselView.setCarouselLayout(displayStyle: 1, pageIndicatorPositon: imagePathArray.count, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
    }
    
    func downloadImages(_ url: String, _ index: Int) {
       
        
        
        //let imageView = UIImageView()
            //        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            //            self.carouselView.images[index] = downloadImage!
            //        })
            let thumbImageUrl  =   NSURL(string: url)
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: thumbImageUrl as URL?, options: SDWebImageDownloaderOptions.useNSURLCache, progress: nil,  completed: { (image, data, error, bool) -> Void in
                if image != nil {
                    DispatchQueue.main.async{
                        self.carouselView.images[index] = image!
                       
                    }
                }
            })
    }
    
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        
        selectRecipeId = self.recepieId[index]
        selectedPosition = index
         self.fullScreenAds = CreatedandLoadIntertitial()
        self.performSegue(withIdentifier: "reciepeDetailIdentifier", sender: self)
        
//        let alert = UIAlertView.init(title:"Alert" , message: titleArray[index], delegate: self, cancelButtonTitle: "OK")
//        alert.show()
    }
    
   

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "reciepeDetailIdentifier" {
        let addEventLisner = segue.destination as! ListRecepieDetailController
        addEventLisner.detailId = selectRecipeId
        addEventLisner.receipeData = recipeData
        addEventLisner.selectedPosition = selectedPosition
    }
    
    
}
    
    
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
    
    func displayAlertMessage(userMessage : String){
        let myAlert = UIAlertController(title:"Manish Bharani",message : userMessage,preferredStyle: UIAlertControllerStyle.alert)
        let OkAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
            myAlert.dismiss(animated: true, completion: nil)
            //self.performSegue(withIdentifier: "afterregister", sender: self)
        }
         myAlert.addAction(OkAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x:0,y:0,width:50,height:50))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
