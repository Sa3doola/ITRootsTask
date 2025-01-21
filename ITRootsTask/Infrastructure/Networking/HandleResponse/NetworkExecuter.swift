//
//  NetworkExecuter.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Foundation
import Combine

protocol NetworkExecuter {
    func execute(_ request: any Requestable, progress progressHandler: ((_ progress: Int)-> Void)?) -> AnyPublisher<Data, ResponseError>
}


