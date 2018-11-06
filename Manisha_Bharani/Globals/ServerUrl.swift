//
//  ServerUrl.swift
//  Manisha_Bharani
//
//  Created by gadgetzone on 12/6/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit

class ServerUrl {
    
    static var base_app_url : String = "http://www.chefmanishabharani.com/app-serve/"
    static var base_image_url : String = base_app_url + "uploads/"
    static var SERVICES_URL : String  = base_app_url + "services/";
    static var home_url : String = SERVICES_URL + "list_cuisine.php"
    
    static var  MORE_INFO : String = SERVICES_URL + "more_info.php";
    static var  LIST_CATEGORY : String = SERVICES_URL + "list_category_count.php";
    static var  LIST_RECIPE : String = SERVICES_URL + "list_recipe.php";
    static var  RECIPE_DETAIL : String = SERVICES_URL + "recipe_detail.php";
    static var  INGREDIENT_DETAIL : String = SERVICES_URL + "ingredient_detail.php";
    static var  SEND_FEEDBACK : String = SERVICES_URL + "send_user_feedback_ios.php";
    static var  SHOUT_URL : String = SERVICES_URL + "shout_test.php";
    
    static var  facebook_url : String = "https://m.facebook.com/chefmanishabharani"
}
