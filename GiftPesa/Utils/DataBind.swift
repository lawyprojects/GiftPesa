//
//  DataBind.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 19/01/2023.
//

import Foundation
final class DataBind<T> {
    typealias Listener = (T) -> Void
      var listener: Listener?
     
      var value: T {
        didSet {
          listener?(value)
        }
      }
     
      init(_ value: T) {
        self.value = value
      }
     
      func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
      }
}
