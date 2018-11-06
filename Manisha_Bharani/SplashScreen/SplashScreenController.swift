//
//  SplashScreenController.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/7/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController {

    @IBOutlet weak var splashImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //splashImage = UIImageView(frame: self.view.frame) //imgView to display background
       // self.view.insertSubview(splashImage, at: 0)  //imgview add above the background of main view
        perform(#selector(SplashScreenController.showNavController), with: nil, afterDelay: 3)
        animate(splashImage)
    }
    @objc func showNavController(){
  
            performSegue(withIdentifier: "splashIdentifier", sender: self)
    
    }
    func animate(_ image: UIImageView) {
//        UIView.animate(withDuration: 5, delay: 0, options: .curveLinear, animations: {
//            image.transform = CGAffineTransform(translationX: -100, y: 0)
//        }) { (success: Bool) in
//            image.transform = CGAffineTransform.identity
//            self.animate(image)
//        }
//
//
        
        
        
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
