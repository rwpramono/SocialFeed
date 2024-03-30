//
//  HttpMethod.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

public enum HttpMethod: String {
  case options = "OPTIONS"
  case get = "GET"
  case head = "HEAD"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
  case trace = "TRACE"
  case connect = "CONNECT"
}
