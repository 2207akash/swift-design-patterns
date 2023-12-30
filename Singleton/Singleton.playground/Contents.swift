/*
 
    Author: Akash Sen
    Singleton Design Pattern
    (With double lock check and handling multi-threading environment)
 */

import Foundation

class Singleton {
    
    private static var shared: Singleton!
    private static let semaphore = DispatchSemaphore(value: 1)  // To handle case for multithreading
    
    static var count = 0
    
    // MARK: Private methods
    private init() {
        Singleton.count += 1
        print("Object count = \(Singleton.count)")
    }
    
    // MARK: Public methods
    static func getInstance() -> Singleton {
        if shared == nil {  // No need to put lock if instance is already created
            semaphore.wait()    // To avoid multiple threads to access critical section
            if shared == nil {
                shared = Singleton()
            }
            semaphore.signal()
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
