//
//  ViewState.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 20/03/23.
//

import Foundation

enum ViewState<T> {
  case initiate
  case loading
  case empty
  case error(error: Error)
  case success(data: T)

  var value: T? {
    get {
      if case .success(let data) = self {
        return data
      }
      return nil
    }

    set {
      if newValue is Bool {
        self = .success(data: newValue!)
      }
    }
  }

  var isLoading: Bool {
    get {
      if case .loading = self {
        return true
      }
      return false
    }
    set {
      if newValue {
        self = .loading
      }
    }
  }

  var error: Error {
    get {
      if case .error(let error) = self {
        return error
      }
      return NSError()
    }

    set {
      self = .error(error: newValue)
    }
  }
}

extension ViewState: Equatable {
  static func == (lhs: ViewState<T>, rhs: ViewState<T>) -> Bool {
    switch (lhs, rhs) {
    case (.initiate, .initiate), (.empty, .empty), (.success, .success), (.loading, .loading), (.error, .error):
      return true
    default:
      return false
    }
  }
}
