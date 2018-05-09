//
//  BKNetworkConfig.swift
//  YTKNetWorkDemo
//
//  Created by liugangyi on 2018/5/2.
//  Copyright © 2018年 liugangyi. All rights reserved.
//

import UIKit

class BKNetworkConfig: NSObject {

    var sessionConfiguration: URLSessionConfiguration?
    var records: [String : BKBaseRequest] = [String : BKBaseRequest]()
    
    override init() {
        super.init()
    }
    
}
