//
//  FirstViewController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/6/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit
import SDWebImage

class FirstViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var HomeCuisine: UICollectionView!
    var indicator = UIActivityIndicatorView()
    var ImageCache = [String:UIImage]()
    var selectCatId : String!
    var CuisineArrayData : NSMutableArray = NSMutableArray()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return CuisineArrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HomeCuisine.dequeueReusableCell(withReuseIdentifier: "CuisineIdentifier", for: indexPath) as! HomeViewCell
       
        
        cell.borderView.frame = CGRect(x:2,y:0,width:HomeCuisine.bounds.width/2-8,height:260)
        cell.borderView.layer.borderColor = UIColor.rgb(hexcolor: "#ccad72").cgColor
        cell.borderView.layer.borderWidth = 1.5
        
        cell.cuisineImage.frame = CGRect(x:5,y:5,width:cell.borderView.frame.width-10,height:250)
        
        cell.cuisineName.frame = CGRect(x:5,y:210,width:cell.borderView.frame.width-10,height:45)
        cell.cuisineName.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.cuisineName.textAlignment = NSTextAlignment.center
        cell.cuisineName.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        cell.cuisineName.textColor = UIColor.white
        
        cell.borderView.addSubview(cell.cuisineImage)
        cell.borderView.addSubview(cell.cuisineName)
        
        cell.progressView.frame = CGRect(x:cell.borderView.frame.width/2-30,y:cell.borderView.frame.height/2-30,width:60,height:60)
        cell.progressView.startAnimating()
        let cuisineData  = self.CuisineArrayData[indexPath.row] as! CuisineModel
        var CuisineName : String = cuisineData.cuisineName
        
        
         cell.cuisineName.text = CuisineName.uppercased()
         //cell.cuisineName.sizeToFit()
        var CuisineImage : String = cuisineData.cuisineImage
        let CuisineImageWithSpace = CuisineImage.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        let thumbImageUrl  =   NSURL(string: ServerUrl.base_image_url+CuisineImageWithSpace)
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: thumbImageUrl as URL?, options: SDWebImageDownloaderOptions.useNSURLCache, progress: nil,  completed: { (image, data, error, bool) -> Void in
            if image != nil {
                DispatchQueue.main.async{
                    cell.cuisineImage.image = image
                    cell.progressView.stopAnimating()
                }
            }
        })
       
        return cell
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cuisineData  = self.CuisineArrayData[indexPath.row] as! CuisineModel
        print("cuisineId------",cuisineData.cuisineId)
        selectCatId = cuisineData.cuisineId
        self.performSegue(withIdentifier: "showCuisineCategory", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCuisineCategory" {
            
            let addEventLisner = segue.destination as! CuisineCategoryController
            addEventLisner.catId = selectCatId
        }
        
    
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x:0,y:0,width:50,height:50))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    

    func tableDataFromServer(){

        //let parameters = "catId=\(labeltxt)"
       // print ("catId",labeltxt)
       // let url = URL(ServerUrl.home_url)! //change the url
        let url = URL(string: ServerUrl.home_url)!
        //create the session object
        let session = URLSession.shared
        print("adadasda",url)
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
                 //print(json)
                let Status = json?.object(forKey: "status") as? String;
                DispatchQueue.main.async {
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                
                if (Status == "200")
                {
                    
                    let data = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<data!.count{
                        let jsonObject = data![i]
                        let cuisineData = CuisineModel()
                        cuisineData.cuisineId = jsonObject.object(forKey: "id") as? String
                        cuisineData.cuisineName = jsonObject.object(forKey: "name") as? String
                        cuisineData.cuisineImage = jsonObject.object(forKey: "image") as? String
                        self.CuisineArrayData.add(cuisineData)
                    }
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.HomeCuisine.reloadData()
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
        tableDataFromServer()
//        let cellSize = CGSize(width:self.view.frame.width/2, height:250)
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical //.horizontal
//        layout.itemSize = cellSize
//        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//        layout.minimumLineSpacing = 1.0
//        layout.minimumInteritemSpacing = 1.0
//        HomeCuisine.setCollectionViewLayout(layout, animated: true)
        //Alo()
        // Do any additional setup after loading the view, typically from a nib.
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding: CGFloat =  10
//        let collectionViewSize = HomeCuisine.frame.size.width - padding
//
//        return CGSize(width: collectionViewSize/2, height: 250)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (HomeCuisine.bounds.width - (2 * 5))/2, height: 260)
        return cellSize
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
//    {
//        return 5
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsetsMake(8,0,0,0)
        return sectionInset
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let logo = UIImage(named: "manisha_logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationController?.navigationBar.backgroundColor = UIColor.rgb(hexcolor: "#34495E")
        navigationController?.navigationBar.barTintColor = UIColor.rgb(hexcolor:"#34495E")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

