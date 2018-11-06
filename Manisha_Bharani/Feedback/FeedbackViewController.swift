//
//  FeedbackViewController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/20/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
   
    var valpicked : String?
    @IBOutlet weak var txtFeedback: UITextView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var feedbackPicker: UIPickerView!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    let SelectReview = ["--select--","Excellent","Good","Average","Poor"]
    var indicator = UIActivityIndicatorView()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return SelectReview[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SelectReview.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        valpicked = SelectReview[row]
        print()
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.frame = CGRect(x:20,y:20,width:self.view.frame.width-40,height:560)
         mainView.layer.cornerRadius = 8
        feedbackPicker.frame = CGRect(x:15,y:0,width:self.mainView.frame.width-30,height:130)
        txtEmail.frame = CGRect(x:15,y:140,width:self.mainView.frame.width-30,height:50)
        txtPhone.frame = CGRect(x:15,y:200,width:self.mainView.frame.width-30,height:50)
        txtFeedback.frame = CGRect(x:15,y:250,width:self.mainView.frame.width-30,height:180)
        btnSubmit.frame = CGRect(x:15,y:445,width:self.mainView.frame.width-30,height:50)
        lblEmail.frame = CGRect(x:15,y:500,width:self.mainView.frame.width-30,height:50)
        
        btnSubmit.layer.cornerRadius = 4
        btnSubmit.backgroundColor = UIColor.rgb(hexcolor:"#ccad72")
        
        mainView.addSubview(feedbackPicker)
        mainView.addSubview(txtEmail)
        mainView.addSubview(txtPhone)
        mainView.addSubview(txtFeedback)
        mainView.addSubview(lblEmail)
        border(textname : txtEmail)
        border(textname : txtPhone)
        borderTextView(textname : txtFeedback)
        
        
        
        // Creates the Botttom border
//        let bottomBorder = CALayer()
//        bottomBorder.frame = CGRect(x: 0, y: 0, width: self.viewBelowlblDesc.frame.width, height: 4)
//        bottomBorder.backgroundColor = UIColor.rgb(hexcolor: "#767676").cgColor
//        self.viewBelowlblDesc.layer.addSublayer(bottomBorder)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let logo = UIImage(named: "manisha_logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationController?.navigationBar.backgroundColor = UIColor.rgb(hexcolor: "#34495E")
        navigationController?.navigationBar.barTintColor = UIColor.rgb(hexcolor:"#34495E")
    }
    

    func border(textname : UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x : 0, y : textname.frame.height-1,width:textname.frame.width, height : 1.0)
        bottomLine.backgroundColor = UIColor.rgb(hexcolor:"#6c4d15").cgColor
        textname.borderStyle = UITextBorderStyle.none
        textname.layer.addSublayer(bottomLine)
        
    }
    func borderTextView(textname : UITextView){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x : 0, y : textname.frame.height-1,width:textname.frame.width, height : 1.0)
        bottomLine.backgroundColor = UIColor.rgb(hexcolor:"#6c4d15").cgColor
        textname.layer.addSublayer(bottomLine)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        
    
        if(valpicked == "--select--" || valpicked == nil )
        {
           
            displayAlertMessage(userMessage: "Please select Valid Option")
            return
        }
        //let pos = phoneNumber.text
        if((txtEmail.text?.isEmpty)! || txtEmail.text == nil){
            print("here2")
            displayAlertMessage(userMessage: "Email cannot be Empty")
            return
            
        }
        
        
        if((txtFeedback.text?.isEmpty)! || txtFeedback.text == nil || txtFeedback.text == "Feedback Content")
        {
            print("here3")
            displayAlertMessage(userMessage: "Please Enter Feedback")
            return
        }
            
            
        else{
            print("here4")
            UpdateData()
        }
    }
    
    func UpdateData(){
        //print(UserDefaults.standard.string(forKey:"userEmail"))
        var useriFeedback = txtFeedback.text
        useriFeedback = useriFeedback?.replacingOccurrences(of: "Optional", with: "")
        useriFeedback = useriFeedback?.replacingOccurrences(of: "(", with: "")
        useriFeedback = useriFeedback?.replacingOccurrences(of: ")", with: "")
        
        
        var emailtext = txtEmail.text
        emailtext = emailtext?.replacingOccurrences(of: "Optional", with: "")
        emailtext = emailtext?.replacingOccurrences(of: "(", with: "")
        emailtext = emailtext?.replacingOccurrences(of: ")", with: "")
        
        var  phoneNumbertext="";
        if(txtPhone.text == nil){
              phoneNumbertext = "9999999999";
        }else{
        
            phoneNumbertext = txtPhone.text!
            phoneNumbertext = phoneNumbertext.replacingOccurrences(of: "Optional", with: "")
            phoneNumbertext = phoneNumbertext.replacingOccurrences(of: "(", with: "")
            phoneNumbertext = phoneNumbertext.replacingOccurrences(of: ")", with: "")
        }
        var valpickedtext = valpicked
        valpickedtext = valpickedtext?.replacingOccurrences(of: "Optional", with: "")
        valpickedtext = valpickedtext?.replacingOccurrences(of: "(", with: "")
        valpickedtext = valpickedtext?.replacingOccurrences(of: ")", with: "")
        print(useriFeedback!)
       
        print(valpickedtext!)
        let parameters = "email=\(emailtext!)&mobile=\(phoneNumbertext)&msg=\(useriFeedback!)&type=\(valpickedtext!)"
        
        //create the url with URL
        let url = URL(string: ServerUrl.SEND_FEEDBACK)! //change the url
        print(url)
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        
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
                
                print(json!)
                let Status = json?.object(forKey: "status") as? String;
                
                if (Status == "200")
                {
                    
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        
                        self.displayAlertMessage(userMessage: "Your Valuable FeedBack Taken")
                    }
                }
                    
                else{
                    
                    
                    
                    DispatchQueue.main.async {
                        self.displayAlertMessage(userMessage: "Some Thing Went Wrong")
                        //self.usernameresponse.alpha = 1
                        // self.usernameresponse.text = resuletemail
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        
                        
                        // UserDefaults.standard.set(self.userEmail.text, forKey: "userEmail")
                        
                    }
                }
                
                
                
                //}
                
                
                // }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        
    }
    func displayAlertMessage(userMessage : String){
        let myAlert = UIAlertController(title:"Manisha Bharani",message : userMessage,preferredStyle: UIAlertControllerStyle.alert)
        let OkAction = UIAlertAction(title : "OK",style:UIAlertActionStyle.default,handler:nil)
        myAlert.addAction(OkAction)
//        let imageView = UIImageView(frame: CGRect(x:20,y:5,width : 40,height: 40))
//        imageView.image = UIImage(named:"IconApp29x29")
//        myAlert.view.addSubview(imageView)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
   
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x:0,y: 0,width:40,height:40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
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
