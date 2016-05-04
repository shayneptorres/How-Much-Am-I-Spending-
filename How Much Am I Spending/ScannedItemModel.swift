//
//  ScannedItemModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 5/2/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import Alamofire

protocol ScannedItemModelDelegate{
    func dataReady()
}



class ScannedItemModel{
    let API_KEY = "AIzaSyCQ-gBz99RR2EyY5RhxiIgxjr_-CYpe-yw"
    var delegate:ScannedItemModelDelegate?
    
    func getItemData(code: String){
        Alamofire.request(.GET, "http://eandata.com/feed/?v=3&keycode=27B310435728D484&mode=json&find=\(code)").responseJSON { response in
            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}


//class ScannedItemModel{
//    let API_KEY = "AIzaSyCQ-gBz99RR2EyY5RhxiIgxjr_-CYpe-yw"
//    var delegate:ScannedItemModelDelegate?
//    
//    func getItemData(code: String){
//        Alamofire.request(.GET, "http://eandata.com/feed/?v=3&keycode=27B310435728D484&mode=json&find=0049000006582").responseJSON { response in
//            print(response.request)  // original URL request
//            //            print(response.response) // URL response
//            //            print(response.data)     // server data
//            //            print(response.result)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//        }
//    }
//}