//
//  ListRecepieDetailController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/14/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleMobileAds

class ListRecepieDetailController: UIViewController,UIWebViewDelegate,GADBannerViewDelegate {
    var detailId : String!
    var DishName : String!
    var youtubeUrl : String!
    var recipeImageWithSpace : String!
    
    var selectedPosition : Int!
    var selectedCurrentPosition : Int?
    
    var receipeData : NSMutableArray = NSMutableArray()
    
    var indicator = UIActivityIndicatorView()
    
    @IBOutlet weak var TopNameView: UIView!
    @IBOutlet weak var ingredientView: UIView!
    @IBOutlet weak var methodView: UIView!
    @IBOutlet weak var secondTopView: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var ScrollinsideView: UIView!
    
    @IBOutlet weak var lblCountReceipe: UILabel!
    @IBOutlet weak var btnNextReceipi: UIButton!
    @IBOutlet weak var btnPrevReceipi: UIButton!
    @IBOutlet weak var videoView: UIButton!
    

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var imgSecondImage: UIImageView!
    
    @IBOutlet weak var lblDishName: UILabel!
    @IBOutlet weak var lblPreparationTime: UILabel!
    @IBOutlet weak var lblCookingTime: UILabel!
    @IBOutlet weak var lblMakeforNoOfPerson: UILabel!
    @IBOutlet weak var lblWatchVideo: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblIngredient: UILabel!
    @IBOutlet weak var lblMethod: UILabel!
    
    @IBOutlet weak var TopScrollview: UIScrollView!
   
    var topheight = CGFloat()
    var currentLabelYPosition : CGFloat = 0
    var labelHeight : CGFloat = 0
    
    @IBOutlet weak var webV: UIWebView!
    @IBOutlet weak var ScrollHeight: NSLayoutConstraint!
    @IBOutlet weak var TopViewHeight: NSLayoutConstraint!
    @IBOutlet weak var SecondViewHeight: NSLayoutConstraint!
    //var banner : GADBannerView!
    var maxLabelSize : CGSize!
    var ingredientLabel = UILabel()
    
    @IBOutlet weak var banner: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedCurrentPosition == receipeData.count){
            btnNextReceipi.isHidden = true
        }else{
            let  tempSelectedCurrentPosition : Int! = selectedPosition! + 1
            
            if(tempSelectedCurrentPosition == receipeData.count){
                btnNextReceipi.isHidden = true
            }else{
                btnNextReceipi.isHidden = false
            }
    
        }
        if(selectedPosition == 0){
            btnPrevReceipi.isHidden = true
        }
        webV.delegate = self
        
        //banner = GADBannerView(adSize : kGADAdSizeSmartBannerPortrait)
        banner.adUnitID = "ca-app-pub-7638083441432626/6186180770"
        banner.rootViewController = self
         banner.delegate = self
        let req:GADRequest = GADRequest()
        banner.load(req)
       // banner.frame = CGRect(x:0,y:view.bounds.height - banner.frame.size.height,width:banner.frame.size.height,height:banner.frame.size.height)
         banner.frame = CGRect(x:0,y:20,width:view.frame.size.width,height:50)
       // self.view.addSubview(banner)
       
       
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {

         //print("selectPsotin==",detailId)
         //print("selectPsotin==",selectedPosition)
         //print("selectPsotin==",receipeData)
        
        listReceipeDataFromServer(reciId: detailId)
        let logo = UIImage(named: "manisha_logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationController?.navigationBar.backgroundColor = UIColor.rgb(hexcolor: "#34495E")
        navigationController?.navigationBar.barTintColor = UIColor.rgb(hexcolor:"#34495E")
        
        TopNameView.frame = CGRect(x:0,y:5,width:self.view.frame.width,height:60)
        TopNameView.backgroundColor = UIColor.white
        lblDishName.frame = CGRect(x:10,y:0,width:self.TopNameView.frame.width-20,height:60)
    
        lblDishName.text = "dadadadada"
        lblDishName.textColor = UIColor.rgb(hexcolor: "#6C4D15")
        TopNameView.addSubview(lblDishName)
        
        
        secondTopView.frame = CGRect(x:0,y:self.TopNameView.frame.origin.y+self.TopNameView.frame.height,width:self.view.frame.width,height:60)
        
        lblCountReceipe.frame = CGRect(x:self.secondTopView.frame.width/2-60,y:self.TopNameView.frame.origin.y+5,width:self.secondTopView.frame.width-20,height:50)
        
        btnPrevReceipi.frame = CGRect(x:10,y:TopNameView.frame.origin.y+5,width:60,height:50)
        btnNextReceipi.frame = CGRect(x:secondTopView.frame.width-70,y:TopNameView.frame.origin.y+5,width:60,height:50)
        
        secondTopView.addSubview(lblCountReceipe)
        secondTopView.addSubview(btnNextReceipi)
        secondTopView.addSubview(btnPrevReceipi)
        
        
        borderView.frame = CGRect(x:5,y:10,width:self.view.frame.width-10,height:240)
        borderView.layer.borderWidth = 1.5
        borderView.layer.borderColor = UIColor.rgb(hexcolor: "#ccad72").cgColor
        
        mainImageView.frame = CGRect(x:3,y:5,width:borderView.frame.width - 6,height:230)
        borderView.addSubview(mainImageView)
        
        
        
        lblPreparationTime.frame = CGRect(x:8,y:borderView.frame.height+5,width:borderView.frame.width-90,height:50)
        lblCookingTime.frame = CGRect(x:8,y:lblPreparationTime.frame.origin.y+40,width:borderView.frame.width - 90,height:50)
        lblMakeforNoOfPerson.frame = CGRect(x:8,y:lblCookingTime.frame.origin.y+40,width:borderView.frame.width - 90,height:50)
        videoView.frame = CGRect(x:borderView.frame.width-80,y:borderView.frame.height+10,width:75,height:75)
        lblWatchVideo.frame = CGRect(x:borderView.frame.width-lblWatchVideo.intrinsicContentSize.width-10,y:videoView.frame.origin.y+50,width:120,height:60)
        selectedCurrentPosition = selectedPosition + 1
        
        lblCountReceipe.text = "Recipe "+String(describing: selectedCurrentPosition!)+" of "+String(receipeData.count)
        secondTopView.backgroundColor = UIColor.rgb(hexcolor: "#BDBDBD")
        
        //self.lblDescription.frame = CGRect(x:8,y:self.lblMakeforNoOfPerson.frame.origin.y+lblMakeforNoOfPerson.intrinsicContentSize.height+20,width:self.view.frame.width,height:100)
        
       lblDescription.numberOfLines = 0
       lblDescription.lineBreakMode = NSLineBreakMode.byWordWrapping

        
       
        
    }
    
    
    @IBAction func btnPreviousRecipe(_ sender: Any) {
        
            selectedCurrentPosition = selectedCurrentPosition! - 1
            selectedPosition = selectedPosition - 1
        
            let reciepiData  = self.receipeData[selectedPosition] as! ReceipeInfo
            
            var recipId : String = reciepiData.recepieId
        
        
        self.ScrollHeight?.constant = 0
        self.currentLabelYPosition = 0
        self.labelHeight = 0
        self.ingredientView.isHidden = true
        self.webV.isHidden = true
        self.methodView.isHidden = true
        DispatchQueue.main.async() {
        
            for subview in self.ScrollinsideView.subviews {
                if (subview.tag == 100) {
                    subview.removeFromSuperview()
                }
            }
        }
            listReceipeDataFromServer(reciId: recipId)
        
            
            self.lblCountReceipe.text = "Recipe "+String(describing: selectedCurrentPosition!)+" of "+String(receipeData.count)
//            if(selectedPosition == 0){
//
//            }
        if(selectedPosition != 0){
            
             btnPrevReceipi.isHidden = false
        }else{
            
            btnPrevReceipi.isHidden = true
        }
        btnNextReceipi.isHidden = false
    }
    
    @IBAction func btnYoutubeClicked(_ sender: Any) {
       
        var youtubeUrl = NSURL(string:self.youtubeUrl)!
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            UIApplication.shared.openURL(youtubeUrl as URL)
        } else{
            //youtubeUrl = NSURL(youtubeUrl)!
            UIApplication.shared.openURL(youtubeUrl as URL)
        }
    }
    
    @IBAction func BtnNextRecipe(_ sender: Any) {
        
        selectedCurrentPosition = selectedCurrentPosition! + 1
        selectedPosition = selectedPosition + 1
    
        let reciepiData  = self.receipeData[selectedPosition] as! ReceipeInfo
       
        var recipId : String = reciepiData.recepieId
        
        
        self.ScrollHeight?.constant = 0
        self.currentLabelYPosition = 0
        self.labelHeight = 0
        self.ingredientView.isHidden = true
        self.webV.isHidden = true
        self.methodView.isHidden = true
         DispatchQueue.main.async() {
        //self.ingredientLabel.removeFromSuperview()
        //self.ingredientLabel.willRemoveSubview(self.ingredientView)
            for subview in self.ScrollinsideView.subviews {
                if (subview.tag == 100) {
                    subview.removeFromSuperview()
                }
            }
        }
        //self.ingredientView.removeFromSuperview()
    
        
        listReceipeDataFromServer(reciId: recipId)
        btnPrevReceipi.isHidden = false
         self.lblCountReceipe.text = "Recipe "+String(describing: selectedCurrentPosition!)+" of "+String(receipeData.count)
        if(selectedCurrentPosition == receipeData.count){
            btnNextReceipi.isHidden = true
        }else{
             btnNextReceipi.isHidden = false
        }
        if(selectedPosition == 0){
            btnPrevReceipi.isHidden = true
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        // Creates the bottom border
 
        
        let topBorder = CALayer()
        //topBorder.frame = CGRect(x: 0, y: secondTopView.frame.height - 1.0, width: secondTopView.frame.width , height: secondTopView.frame.height - 5.0)
        
        topBorder.frame = CGRect(x: 0, y: secondTopView.frame.height - 1.0, width: secondTopView.frame.width , height:4.0)
        topBorder.backgroundColor = UIColor.rgb(hexcolor: "#767676").cgColor
        secondTopView.layer.addSublayer(topBorder)
        
        
        
        // Creates the Top border
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 0, width: secondTopView.frame.width, height: 4)
        bottomBorder.backgroundColor = UIColor.rgb(hexcolor: "#767676").cgColor
        secondTopView.layer.addSublayer(bottomBorder)
        
    }
    
    func listReceipeDataFromServer(reciId : String){
        let parameters = "id=\(reciId)"
        print ("parameterdetildPara",parameters)
        // let url = URL(ServerUrl.home_url)! //change the url
        let url = URL(string: ServerUrl.RECIPE_DETAIL)!
        //create the session object
        print ("url------",url)
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
                //print("json---",json)
                let Status = json?.object(forKey: "status") as? String;
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    // UIApplication.shared.endIgnoringInteractionEvents()
                }
                
                if (Status == "200")
                {
                    let data = json?.object(forKey: "data") as? [NSDictionary]
                    //for i in 0..<data!.count{
                        let jsonObject = data![0]
                        //let catInfo = CatInfo()
                        _ = jsonObject.object(forKey: "id") as? String
                        
                        let recepieImage = jsonObject.object(forKey: "image") as? String
                         let recipeImageWithoutSpace = recepieImage?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
                        self.recipeImageWithSpace  = ServerUrl.base_image_url+recipeImageWithoutSpace!
                        self.DishName =  jsonObject.object(forKey: "name") as? String
                    //}
                    DispatchQueue.main.async {
                    
                        self.lblDishName.text = self.DishName
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        let preparationTime = jsonObject.object(forKey: "prep_time") as? String
                        self.youtubeUrl = jsonObject.object(forKey: "video_url") as? String
                        let cookingTime = jsonObject.object(forKey: "cook_time") as? String
                        let makesfor = jsonObject.object(forKey: "makes_for") as? String
                        let description = jsonObject.object(forKey: "description") as? String
                        let ingredientsId = jsonObject.object(forKey: "ingredient_id") as? String
                        let recipe_methods = jsonObject.object(forKey: "recipe_methods") as? String
                        
                        
                        
                        let labelWidth = self.view.frame.width - 20
                        self.maxLabelSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
                        
                        self.lblDescription.text = description
                        self.lblDescription.sizeToFit()
                      
                        
                        let actualLabelSize = self.lblDescription.text!.boundingRect(with: self.maxLabelSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: self.lblDescription.font], context: nil)
                         self.labelHeight = actualLabelSize.height
                        
                        self.lblDescription.frame = CGRect(x:8,y:self.lblMakeforNoOfPerson.frame.origin.y+self.lblMakeforNoOfPerson.intrinsicContentSize.height+20,width:self.view.frame.width-16,height:self.labelHeight)
                    
                        self.ScrollHeight?.constant = self.labelHeight+(self.TopViewHeight?.constant)! + (self.SecondViewHeight?.constant)! + 1000
                        self.ScrollinsideView?.frame = CGRect(x:0,y:(self.ScrollHeight?.constant)!,width:self.view.frame.width,height:(self.ScrollHeight?.constant)!)
                        
                        self.imgSecondImage.frame = CGRect(x:8,y:self.labelHeight+self.lblMakeforNoOfPerson.frame.origin.y+self.lblMakeforNoOfPerson.intrinsicContentSize.height+20,width:self.view.frame.width - 16,height:230)
                        if(ingredientsId == ""){
                            self.ingredientView.isHidden = true
                        }else{
                            self.ingredientView.isHidden = false
      
                        self.ingredientView.frame = CGRect(x:3,y:self.imgSecondImage.frame.origin.y+230,width:self.view.frame.width - 6,height:45)
                        self.lblIngredient.frame = CGRect(x:8,y:4,width:self.ingredientView.frame.width - 16,height:40)
                        self.ingredientView.addSubview(self.lblIngredient)
                        
                        
                        let topBorder = CALayer()
                        topBorder.frame = CGRect(x: 3, y: self.ingredientView.frame.height, width: self.ingredientView.frame.width - 6 , height:4.0)
                        topBorder.backgroundColor = UIColor.rgb(hexcolor: "#767676").cgColor
                        self.ingredientView.layer.addSublayer(topBorder)
                        
                        self.currentLabelYPosition = self.imgSecondImage.frame.origin.y+280
                        
                        
                            let ingredient_val = jsonObject.object(forKey: "ingredient_val") as? String
                            let ingredientsData = json?.object(forKey: "ingredients") as? [NSDictionary]
                            let fullIngredientArr = ingredient_val?.components(separatedBy: ":@:")
                            for i in 0..<ingredientsData!.count{
                                let jsonObject = ingredientsData![i]
                                
                                    let ingredientName = jsonObject.object(forKey: "name") as? String
                                    self.ingredientLabel = UILabel(frame: CGRect(x:10,y:self.currentLabelYPosition,width:self.view.frame.width,height:40))
                                       self.ingredientLabel.text = ingredientName!+"   "+fullIngredientArr![i]
                                    self.ingredientLabel.tag = 100
                                    self.ingredientLabel.textColor = UIColor.rgb(hexcolor: "805F1B")
                                    self.currentLabelYPosition = self.currentLabelYPosition + self.ingredientLabel.frame.size.height
                                    self.ScrollinsideView.addSubview(self.ingredientLabel)
                            }
                        }
                        
                        if(recipe_methods == "NA"){
                          self.methodView.isHidden = true
                            self.webV.isHidden = true
                        }else{
                            self.methodView.isHidden = false
                            // self.webV.isHidden = false
                            let abc =  self.unescapeHtml(escapedHtml: recipe_methods!)
                            self.tableDataFromServer(dataToSend: abc)
                            self.ScrollinsideView?.frame = CGRect(x:0,y:(self.ScrollHeight?.constant)!,width:self.view.frame.width,height:(self.ScrollHeight?.constant)!)
                            
                            
                            
                            self.methodView.frame = CGRect(x:3,y:self.currentLabelYPosition+10,width:self.view.frame.width - 6,height:45)
                            self.lblMethod.frame = CGRect(x:8,y:4,width:self.ingredientView.frame.width - 16,height:40)
                            self.methodView.addSubview(self.lblMethod)
                            
                            
                            let topBorder = CALayer()
                            topBorder.frame = CGRect(x: 3, y: self.methodView.frame.height, width: self.methodView.frame.width - 6 , height:4.0)
                            topBorder.backgroundColor = UIColor.rgb(hexcolor: "#767676").cgColor
                            self.methodView.layer.addSublayer(topBorder)
 
                            self.ScrollinsideView.addSubview(self.webV)
                          
                        }
                        
                        
                        let boldAttribute = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!]
                        let regularAttribute = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Light", size: 18.0)!]
                        
                        let beginningAttributedString = NSAttributedString(string: "Preparation Time : ", attributes: regularAttribute )
                        let boldAttributedString = NSAttributedString(string: preparationTime!, attributes: boldAttribute)
                
                        let fullString =  NSMutableAttributedString()
                        
                        fullString.append(beginningAttributedString)
                        fullString.append(boldAttributedString)
                        
                        
                        self.lblPreparationTime.attributedText = fullString
        
                        let beginningAttributedString1 = NSAttributedString(string: "Cooking Time : ", attributes: regularAttribute )
                        let boldAttributedString1 = NSAttributedString(string: cookingTime!, attributes: boldAttribute)
                        
                        let cookingTimeAtt =  NSMutableAttributedString()
                        
                        cookingTimeAtt.append(beginningAttributedString1)
                        cookingTimeAtt.append(boldAttributedString1)
                        
                        
                        self.lblCookingTime.attributedText = cookingTimeAtt
                        
                        self.lblMakeforNoOfPerson.text = "Makes for " + makesfor!
                        let thumbImageUrl  =   NSURL(string: self.recipeImageWithSpace)
                        SDWebImageManager.shared().imageDownloader?.downloadImage(with: thumbImageUrl as URL?, options: SDWebImageDownloaderOptions.useNSURLCache, progress: nil,  completed: { (image, data, error, bool) -> Void in
                            if image != nil {
                                DispatchQueue.main.async{
                                    self.mainImageView.image = image!
                                    self.imgSecondImage.image = image!
                                }
                            }
                        })
                     
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
    func  unescapeHtml(escapedHtml : String) -> String {
        let newString1 = escapedHtml.replacingOccurrences(of: "&amp;", with: "@")
        let newString2 = newString1.replacingOccurrences(of: "&lt;", with: "<")
        let newString3 = newString2.replacingOccurrences(of: "&gt;", with: ">")
        let newString4 = newString3.replacingOccurrences(of: "&quot;", with: "\"")
        let newString5 = newString4.replacingOccurrences(of: "&amp;nbsp;", with: "&nbsp;")
        let newString6 = newString5.replacingOccurrences(of: "&nbsp;", with: " ")
        let newString7 = newString6.replacingOccurrences(of: "#", with: "/-/")
        let newString8 = newString7.replacingOccurrences(of: " ", with: "%20")
    
        return newString8;
    }
    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedStringKey.font: font])
        let boldFontAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
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
   
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.webViewResizeToContent(webView: self.webV)
    }
    
    func webViewResizeToContent(webView: UIWebView) {
        self.webV.layoutSubviews()
        
        // Set to smallest rect value
        var frame:CGRect = webView.frame
        frame.size.height = 1.0
        self.webV.frame = frame
        
        var height:CGFloat = webView.scrollView.contentSize.height
        print("UIWebView.height: \(height)")
        
       // self.webV.setHeight(height: height)
        let heightConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: height)
        self.webV.addConstraint(heightConstraint)
        
        // Set layout flag
        self.webV.window?.setNeedsUpdateConstraints()
        self.webV.window?.setNeedsLayout()
        //self.webV.frame.size.height = 1
        //self.webV.frame.size = webView.sizeThatFits(.zero)
        self.webV.scrollView.isScrollEnabled=false;
        
        
        
        self.ScrollHeight?.constant = self.labelHeight+(self.TopViewHeight?.constant)! + (self.SecondViewHeight?.constant)! + 1000 + height
        
        self.webV.frame = CGRect(x:3,y:self.currentLabelYPosition+75,width:self.view.frame.width-6, height:(self.ScrollHeight?.constant)!)
        self.webV.isHidden = false
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
    func tableDataFromServer(dataToSend : String){
        
        let parameters = "content=\(dataToSend)"
        let url = URL(string: ServerUrl.SHOUT_URL)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        //activityIndicator()
        //indicator.startAnimating()
                do {
                    request.httpBody = parameters.data(using: String.Encoding.utf8)
                }
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error == nil {
            
                DispatchQueue.main.async {
                    
                    self.webV.loadRequest(request)
                }
            }else {
                print("errorrr\(error)")
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
