/*
 
    Author: Akash Sen
    Singleton Design Pattern
 */

import Foundation

final class Singleton { 
    public static let shared = Singleton()
    private init() {}
}


let concurrentGroup = DispatchGroup()
let concurrentQueue = DispatchQueue(label: "concurrent.access.singleton", attributes: .concurrent)

concurrentQueue.async(group: concurrentGroup) {
    let singletonObject1 = Singleton.shared
}

concurrentQueue.async(group: concurrentGroup) {
    let singletonObject2 = Singleton.shared
}

