//
//  BKNetworkAgent.swift
//  YTKNetWorkDemo
//
//  Created by liugangyi on 2018/5/2.
//  Copyright © 2018年 liugangyi. All rights reserved.
//

import UIKit
import Alamofire

class BKNetworkAgent: NSObject {

    private var _manager: SessionManager!
    private var _config: BKNetworkConfig!

    private var _requestsRecord: [NSNumber:BKBaseRequest]
    private var _processingQueue: DispatchQueue
    private var _lock: pthread_mutex_t
    private var _allStatusCodes: IndexSet

    static let sharedAgent: BKNetworkAgent = BKNetworkAgent()
    override init() {
        _config = BKNetworkConfig()
        _manager = SessionManager(configuration: _config.sessionConfiguration!, delegate: BKSessionDelegate(), serverTrustPolicyManager: nil)
        _requestsRecord = [NSNumber:BKBaseRequest]()
        _allStatusCodes = IndexSet.init(integersIn: Range.init(NSRange.init(location: 100, length: 500))!)
        _processingQueue = DispatchQueue(label: "com.bk.networkagent.processing")
        _lock = pthread_mutex_t()
    }

    func addRequest(request: BKBaseRequest) {

        let customUrlRequest = request.buildCustomUrlRequest()
        if customUrlRequest != nil {
           
        } else {
//            request.requestTask = sessionTaskForRequest(request: request, error: &requestSerializationError)
        }

    }

    func cancelRequest(request: BKBaseRequest?) {
        
    }

    func cancelAllRequest() {

    }

    func buildRequestUrl(request: BKBaseRequest) -> String {


        return ""
    }
//    func dataTask(httpMethod: String, requestSerializer: AFHTTPRequestSerializer, URLString: String, parameters:[String : Any], constructingBlock: AFConstructingBlock?, error:  NSErrorPointer) -> URLSessionDataTask? {
//
//        var request: URLRequest? = nil
//
//        if let block = constructingBlock {
//            request = requestSerializer.multipartFormRequest(withMethod: httpMethod, urlString: URLString, parameters: parameters, constructingBodyWith: block, error: error) as URLRequest
//        } else {
//            request = requestSerializer.request(withMethod: httpMethod, urlString: URLString, parameters: parameters, error: error) as URLRequest
//        }
//
//        var dataTask: URLSessionDataTask? = nil
//        dataTask = _manager.dataTask(with: request!, uploadProgress: nil, downloadProgress: nil, completionHandler: { (responce, responceObject, error) in
//
//        })
//
//        return dataTask
//    }

//    func handleRequestResult(task: URLSessionDataTask, responceObject: AnyObject?, error: NSError?) {
//        pthread_mutex_lock(&_lock)
//        let request = _requestsRecord[NSNumber(integerLiteral: task.taskIdentifier)]
//        pthread_mutex_unlock(&_lock)
//        if request == nil { return }
//
//        var serializationError: NSError? = nil
//        var validationError: NSError? = nil
//        var requestError: NSError? = nil
//        var succeed = false
//
//        request?.responseObject = responceObject
//        if let resObj = request?.responseObject, resObj.isKind(of: NSData.classForCoder()) {
//            request?.responseData = responceObject as! NSData
//            request?.responseString = String.init(data: <#T##Data#>, encoding: <#T##String.Encoding#>)
//            let resType = request?.responseSerializerType() ?? .BKResponseSerializerTypeHTTP
//
//            switch resType {
//            case .BKResponseSerializerTypeHTTP
//                break
//            case .BKResponseSerializerTypeJSON
//                request?.responseString
//                break
//                case .BKResponseSerializerTypeXMLParser
//                break
//
//            default:
//                break
//            }
//        }
//    }

////    - (void)handleRequestResult:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error {
////    Lock();
////    YTKBaseRequest *request = _requestsRecord[@(task.taskIdentifier)];
////    Unlock();
////
////    // When the request is cancelled and removed from records, the underlying
////    // AFNetworking failure callback will still kicks in, resulting in a nil `request`.
////    //
////    // Here we choose to completely ignore cancelled tasks. Neither success or failure
////    // callback will be called.
////    if (!request) {
////    return;
////    }
////
////    YTKLog(@"Finished Request: %@", NSStringFromClass([request class]));
////
////    NSError * __autoreleasing serializationError = nil;
////    NSError * __autoreleasing validationError = nil;
////
////    NSError *requestError = nil;
////    BOOL succeed = NO;
////
////    request.responseObject = responseObject;
////    if ([request.responseObject isKindOfClass:[NSData class]]) {
////    request.responseData = responseObject;
////    request.responseString = [[NSString alloc] initWithData:responseObject encoding:[YTKNetworkUtils stringEncodingWithRequest:request]];
////
////    switch (request.responseSerializerType) {
////    case YTKResponseSerializerTypeHTTP:
////    // Default serializer. Do nothing.
////    break;
////    case YTKResponseSerializerTypeJSON:
////    request.responseObject = [self.jsonResponseSerializer responseObjectForResponse:task.response data:request.responseData error:&serializationError];
////    request.responseObject = [request responseArgumentCustomProcess:request.responseObject];
////    request.responseJSONObject = request.responseObject;
////    break;
////    case YTKResponseSerializerTypeXMLParser:
////    request.responseObject = [self.xmlParserResponseSerialzier responseObjectForResponse:task.response data:request.responseData error:&serializationError];
////    break;
////    }
////    }
////    if (error) {
////    succeed = NO;
////    requestError = error;
////    } else if (serializationError) {
////    succeed = NO;
////    requestError = serializationError;
////    } else {
////    succeed = [self validateResult:request error:&validationError];
////    requestError = validationError;
////    }
////
////    if (succeed) {
////    [self requestDidSucceedWithRequest:request];
////    } else {
////    [self requestDidFailWithRequest:request error:requestError];
////    }
////
////    dispatch_async(dispatch_get_main_queue(), ^{
////    [self removeRequestFromRecord:request];
////    [request clearCompletionBlock];
////    });
////    }
//
    func sessionTaskForRequest(request: BKBaseRequest, error: inout NSError) -> URLSessionTask {
        let requestMethod = request.requestMethod()
        let url = buildRequestUrl(request: request)
        var params = request.requestArgument()
        params = request.requestArgumentCustomProcess(requestArgument: params) as! [String : Any]
//        _manager.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)

//        switch requestMethod {
//        case .BKRequestMethodGet:
//            <#code#>
//        default:
//            <#code#>
//        }

        return URLSessionTask()


    }
//
//    func requestSerializerForRequest(request: BKBaseRequest) -> AFHTTPRequestSerializer? {
//        var requestSerializer: AFHTTPRequestSerializer? = nil
//        if request.requestSerializerType() == .BKRequestSerializerTypeHTTP {
//            requestSerializer = AFHTTPRequestSerializer()
//        } else if request.requestSerializerType() == .BKRequestSerializerTypeJSON {
//            requestSerializer = AFJSONRequestSerializer()
//        }
////        if let serializerBlock = request.queryStringSerializationBlock  {
////            requestSerializer?.setQueryStringSerializationWith(serializerBlock)
////        }
//        requestSerializer?.timeoutInterval = request.requestTimeoutInterval()
//        requestSerializer?.allowsCellularAccess = request.allowsCellularAccess()
//        if let authorizationHeaderFieldArray = request.requestAuthorizationHeaderFieldArray() {
//            requestSerializer?.setAuthorizationHeaderFieldWithUsername(authorizationHeaderFieldArray.first!, password: authorizationHeaderFieldArray.last!)
//        }
//        if let headerFieldValueDictionary = request.requestHeaderFieldValueDictionary() {
//            for (key , value) in headerFieldValueDictionary {
//                requestSerializer?.setValue(value, forHTTPHeaderField: key)
//            }
//        }
//        return requestSerializer;
//    }
//
//
}
