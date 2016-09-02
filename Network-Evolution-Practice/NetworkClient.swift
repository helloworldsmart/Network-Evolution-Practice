//
//  NetworkClient.swift
//  Network-Evolution-Practice
//
//  Created by David on 2016/9/2.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkClientType {
	func makeRequest<Response: JSONDecodable>(url: String,
	                        params: [String : AnyObject],
	                        callback: (Response?, ErrorType?) -> Void)
}

struct NetworkClient: NetworkClientType {
	
	func makeRequest<Response : JSONDecodable>(url: String,
	                 params: [String : AnyObject],
	                 callback: (Response?, ErrorType?) -> Void) {
		request(.POST, url, parameters: params).response { _, _, data, error in
			if let jsonData = data where error == nil {
				let json = JSON(data: jsonData)
				let response = Response(json: json)
				callback(response, nil)
			} else {
				callback(nil, error)
			}
		}
	}
	
}