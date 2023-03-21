//
//  CustomError.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import Foundation

enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable(URL)
  
  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    }
  }
}
