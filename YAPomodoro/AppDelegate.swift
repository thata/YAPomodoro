//
//  AppDelegate.swift
//  YAPomodoro
//
//  Created by Takashi Hatakeyama on 2016/02/08.
//  Copyright © 2016年 chikuwaprog. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // ウインドウの位置やサイズを保存する
        let window = NSApp.windows.first
        window?.setFrameAutosaveName("mainWindow")
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        // ウインドウをすべて閉じたらアプリケーションを終了
        return true
    }
}

