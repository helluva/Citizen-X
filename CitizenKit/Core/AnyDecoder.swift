//
//  AnyDecoder.swift
//  CitizenKit
//
//  Created by Cal Stephens on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import Foundation

// MARK: - AnyDecoder

public protocol AnyDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

public protocol DecoderProvider {
    static var preferredDecoder: AnyDecoder { get }
}

extension JSONDecoder: AnyDecoder { }
extension PropertyListDecoder: AnyDecoder { }
