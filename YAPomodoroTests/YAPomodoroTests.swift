//
//  YAPomodoroTests.swift
//  YAPomodoroTests
//
//  Created by Takashi Hatakeyama on 2016/02/08.
//  Copyright © 2016年 chikuwaprog. All rights reserved.
//

import XCTest
@testable import YAPomodoro

class YAPomodoroTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMinutesAndSeconds() {
        let minutes = 20
        let seconds = 30
        let pomodoro = Pomodoro(counter: minutes * 60 + seconds)
        
        XCTAssertEqual(20, pomodoro.minutes)
        XCTAssertEqual(30, pomodoro.seconds)
    }
    
    func testCounter() {
        let pomodoro = Pomodoro(counter: 1)
        
        // コンストラクタで指定した counter が返る
        XCTAssertEqual(1, pomodoro.counter)
        
        pomodoro.decrement()
        
        // 1減った counter が返る
        XCTAssertEqual(0, pomodoro.counter)
        
        pomodoro.decrement()
        
        // 0より小さくはならない
        XCTAssertEqual(0, pomodoro.counter)
    }
}
