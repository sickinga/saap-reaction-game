//
//  Timer.swift
//  ReactionGame
//
//  Created by Benedikt Kaiser on 03.11.22.
//

import Foundation
class StopWatchManager {
    
    var secondsElapsed = 0.0
    var timer = Timer()
    
    func start() {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.secondsElapsed += 0.1
            }
        }
    
    func stop() -> Double {
        let time = secondsElapsed
        secondsElapsed = 0.0
        return time
    }
}
