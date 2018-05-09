//
//  ViewController.swift
//  YTKNetWorkDemo
//
//  Created by liugangyi on 2018/5/2.
//  Copyright © 2018年 liugangyi. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(URL(string: "https://www.baidu.com")!).responseJSON(queue: DispatchQueue.main, options: .allowFragments) { (responceJson) in
            responceJson.error
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}

