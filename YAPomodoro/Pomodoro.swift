//
//  Pomodoro.swift
//  MyPomodoro
//
//  Created by Takashi Hatakeyama on 2016/02/08.
//  Copyright © 2016年 chikuwaprog. All rights reserved.
//

protocol PomodoroDelegate {
    // counterの値が変更された場合に呼び出される
    func counterChanged(pomodoro: Pomodoro)
    
    // counterが0になった場合に呼び出される
    func pomodoroFinished(pomodoro: Pomodoro)
}

class Pomodoro {
    var counter: Int
    var delegate: PomodoroDelegate?
    
    var minutes: Int {
        get {
            return Int(counter / 60)
        }
    }
    
    var seconds: Int {
        get {
            return counter % 60
        }
    }
    
    init(counter: Int) {
        self.counter = counter
    }
    
    func decrement() {
        if counter == 0 {
            return
        }
        
        counter--
        
        if let delegate = self.delegate {
            // counterの変更を通知
            delegate.counterChanged(self)
            
            if counter == 0 {
                // pomodoroの終了を通知
                delegate.pomodoroFinished(self)
            }
        }
    }
}
