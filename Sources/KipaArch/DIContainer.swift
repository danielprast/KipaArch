//
//  DIContainer.swift
//
//
//  Created by Daniel Prastiwa on 20/02/22.
//

import Foundation

public typealias FactoryClosure = (DICProtocol) -> AnyObject

public protocol DICProtocol {
    func register<S>(type: S.Type, factoryClosure: @escaping FactoryClosure)
    func resolve<S>(type: S.Type) -> S?
}

// Dependency Injection Container
public final class DIC: DICProtocol {
    public static let shared = DIC()
    
    private init() {}
    
    public private(set) var services = Dictionary<String, FactoryClosure>()
    
    public func register<S>(type: S.Type, factoryClosure: @escaping FactoryClosure) {
        services["\(type)"] = factoryClosure
    }
    
    public func resolve<S>(type: S.Type) -> S? {
        return services["\(type)"]?(self) as? S
    }
}
