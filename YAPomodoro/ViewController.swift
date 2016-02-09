//
//  ViewController.swift
//  YAPomodoro
//
//  Created by Takashi Hatakeyama on 2016/02/08.
//  Copyright © 2016年 chikuwaprog. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, PomodoroDelegate, NSUserNotificationCenterDelegate {
    
    @IBOutlet weak var clockFaceLabel: NSTextField!
    @IBOutlet weak var suspendButton: NSButton!
    
    var timer: NSTimer? = nil
    var pomodoro: Pomodoro? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self
    }
    
    // MARK: Actions
    
    @IBAction func workDidPress(sender: AnyObject) {
        let seconds = 25 * 60
        startTimer(seconds)
    }
    
    @IBAction func restDidPress(sender: AnyObject) {
        let seconds = 5 * 60
        startTimer(seconds)
    }
    
    @IBAction func stopDidPress(sender: AnyObject) {
        guard let timer = self.timer else {
            return
        }
        
        if timer.valid {
            suspendTimer()
        } else {
            resumeTimer()
        }
    }
    
    // MARK: Timer tick
    
    func tick(timer: NSTimer) -> Void {
        pomodoro?.decrement()
    }
    
    // MARK: Pomodoro Delegate
    
    func counterChanged(pomodoro: Pomodoro) {
        showClockface()
    }
    
    func pomodoroFinished(pomodoro: Pomodoro) {
        // 通知して
        let notification = NSUserNotification()
        notification.title = "Pomodoro Finished 🍅"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
        
        // タイマーを止める
        timer?.invalidate()
    }
    
    // MARK: NSUserNotificationCenterDelegate
    
    func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
        
        // アプリがフォアグラウンドに表示されていてもプッシュ通知は表示すること
        return true
    }
    
    // MARK: Private
    
    func startTimer(seconds: Int) {
        // 稼働中のタイマがあったら止める
        if let _timer = timer {
            _timer.invalidate()
        }
        
        // 一時停止ボタンのラベルを初期化
        self.suspendButton.title = "🌙 一時停止"
        
        let pomodoro = Pomodoro(counter: seconds)
        pomodoro.delegate = self
        
        self.pomodoro = pomodoro
        
        // ラベルを初期化
        showClockface()
        
        // タイマー開始
        let interval = 1.0
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "tick:", userInfo:nil, repeats: true)
    }
    
    func suspendTimer() {
        guard let timer = self.timer else {
            return
        }
        
        // 一時停止 -> 再開
        self.suspendButton.title = "☀️ 再開"
        
        // タイマーを停止
        timer.invalidate()
    }
    
    func resumeTimer() {
        // 再開 -> 一時停止
        self.suspendButton.title = "🌙 一時停止"
        
        // タイマー再開
        let interval = 1.0
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "tick:", userInfo:nil, repeats: true)
    }
    
    func showClockface() {
        guard let pomodoro = self.pomodoro else {
            return
        }
        
        let label = String(format: "%02d:%02d", arguments: [pomodoro.minutes, pomodoro.seconds])
        self.clockFaceLabel.cell?.title = label
    }
    
    func clearClockface() {
        self.clockFaceLabel.cell?.title = "00:00"
    }
}
