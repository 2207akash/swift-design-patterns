/*
 
    Author: Akash Sen
    Singleton Design Pattern (Failure in multi-threading environment)
 */

import Foundation

class Singleton {
    
    private static var shared: Singleton!
    
    static var count = 0
    
    // MARK: Private methods
    private init() {
        Singleton.count += 1
        print("Object count = \(Singleton.count)")
    }
    
    // MARK: Public methods
    static func getInstance() -> Singleton {
        if shared == nil {
            shared = Singleton()
        }
        return shared
    }
}


let concurrentGroup = DispatchGroup()
let concurrentQueue = DispatchQueue(label: "concurrent.access.singleton", attributes: .concurrent)

concurrentQueue.async(group: concurrentGroup) {
    let singletonObject1 = Singleton.getInstance()
}

concurrentQueue.async(group: concurrentGroup) {
    let singletonObject2 = Singleton.getInstance()
}
