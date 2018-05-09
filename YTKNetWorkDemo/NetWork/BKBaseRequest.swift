//
//  BKBaseRequest.swift
//  YTKNetWorkDemo
//
//  Created by liugangyi on 2018/5/2.
//  Copyright © 2018年 liugangyi. All rights reserved.
//

import UIKit
import Alamofire

///  HTTP Request method
enum BKRequestMethod: String {
    case OPTIONS = "OPTIONS"
    case GET     = "GET"
    case HEAD    = "HEAD"
    case POST    = "POST"
    case PUT     = "PUT"
    case PATCH   = "PATCH"
    case DELETE  = "DELETE"
    case TRACE   = "TRACE"
    case CONNECT = "CONNECT"
}

///  Request serializer type.
enum BKRequestSerializerType: Int {
    case BKRequestSerializerTypeHTTP = 0
    case BKRequestSerializerTypeJSON
}

///  Response serializer type, which determines response serialization process and the type of `responseObject`.
enum BKResponseSerializerType: Int {
    /// NSData type
    case BKResponseSerializerTypeHTTP = 0
    /// JSON object type
    case BKResponseSerializerTypeJSON
    /// NSXMLParser type
    case BKResponseSerializerTypeXMLParser
}

///  Request priority
enum BKRequestPriority: Int {
    case BKRequestPriorityLow = -4
    case BKRequestPriorityDefault = 0
    case BKRequestPriorityHigh = 4
}

//typealias AFConstructingBlock = (AFMultipartFormData) -> Void
typealias AFURLSessionTaskProgressBlock = (_ progress: Progress) -> Void
typealias AFQueryStringSerializationBlock = (_ request: NSURLRequest, _ parameters: [String:Any], _ error: NSError) -> String

typealias BKRequestCompletionBlock = ()

class BKBaseRequest: NSObject {

    // MARK: Request and Response Information
    var requestTask: URLSessionTask?
    var currentRequest: URLRequest = URLRequest(url: URL(string: "")!)
    var originalRequest: URLRequest = URLRequest(url: URL(string: "")!)
    var response: HTTPURLResponse?
    var responseStatusCode: Int { return 200 }
    var responseHeaders: [String:Any]?
    var responseData: Data?
    var responseString: String?
    var responseObject: Any?
    var responseJSONObject: Any?
    var error: NSError?
    var isCanceled: Bool = true
    var isExecuting: Bool = true
    
    // MARK: Request Configuration
    var tag: Int = 0
    var userInfo: [String:Any] = [String:Any]()
    weak var delegate: BKRequestDelegate? = nil
    var successCompletionBlock: BKRequestCompletionBlock? = nil
    var failedCompletionBlock: BKRequestCompletionBlock? = nil
    var queryStringSerializationBlock: AFQueryStringSerializationBlock? = nil
    var resumableDownloadProgressBlock: AFURLSessionTaskProgressBlock? = nil
    var requestPriority: BKRequestPriority = BKRequestPriority(rawValue: 0)!
    
    func setCompletionBlock(success:BKRequestCompletionBlock, failure: BKRequestCompletionBlock) {
        self.successCompletionBlock = success
        self.failedCompletionBlock = failure
    }
    
    /// encryption process and so on
    func requestArgumentCustomProcess(requestArgument: Any) -> Any {
        return requestArgument
    }
    /// decryption process and so on
    func responseArgumentCustomProcess(responseArgument: Any) -> Any {
        return responseArgument
    }
    
    func clearCompletionBlock() {
        self.successCompletionBlock = nil
        self.failedCompletionBlock = nil
    }
    
    // MARK: Request Action
    func start() {
        BKNetworkAgent.sharedAgent.addRequest(request: self)
    }
    
    func stop() {
        BKNetworkAgent.sharedAgent.cancelRequest(request: self)
    }
    
    func startWithCompletionBlock(success: BKRequestCompletionBlock, failure: BKRequestCompletionBlock) {
        self.setCompletionBlock(success: success, failure: failure)
        start()
    }
    
    // MARK: Subclass Override
    func requestCompletePreprocessor() {
    }
    
    func requestCompleteFilter() {
    }
    
    func requestFailedPreprocessor()  {
    }
    
    func requestFailedFilter() {
    }
    
    func baseUrl() -> String {
        return ""
    }
    
    func requestUrl() -> String {
        return ""
    }
    
    func cdnUrl() -> String {
        return ""
    }
    
    func requestTimeoutInterval() -> TimeInterval {
        return 10
    }
    
    func requestArgument() -> [String : Any]? {
        return nil
    }
    
    func requestMethod() -> BKRequestMethod {
        return .GET
    }
    
    func requestSerializerType() -> BKRequestSerializerType {
        return .BKRequestSerializerTypeHTTP
    }
    
    func responseSerializerType() -> BKResponseSerializerType {
        return .BKResponseSerializerTypeJSON
    }
    
    func requestAuthorizationHeaderFieldArray() -> [String]? {
        return nil
    }
    
    func requestHeaderFieldValueDictionary() -> [String : String]? {
        return nil
    }
    
    func buildCustomUrlRequest() -> URLRequest? {
        return nil
    }
    
    func useCDN() -> Bool {
        return false
    }
    
    func allowsCellularAccess() -> Bool {
        return true
    }
    
    func jsonValidator() -> Any? {
        return nil
    }
    
    func statusCodeValidator() -> Bool {
        let statusCode: Int = responseStatusCode;
        return (statusCode >= 200 && statusCode <= 299);
    }
    
    override init() {
        
    }
    
    override var description: String {
        return String(format: "<\(NSStringFromClass(self.classForCoder)): %p>{ URL:\(self.currentRequest.url?.absoluteString ?? "") } { method: \(self.currentRequest.httpMethod ?? "") } { arguments: \(self.requestArgument)}", self)

    }
}



@objc
protocol BKRequestDelegate {
    @objc optional
    func requestFinished(_ request: BKBaseRequest) -> Void
    func requestFailed(_ request: BKBaseRequest) -> Void
}





