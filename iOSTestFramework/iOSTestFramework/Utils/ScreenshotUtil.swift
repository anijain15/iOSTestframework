//
//  ScreenshotUtil.swift
//  WynkMusicUITests
//
//  Created by B0209134 on 21/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation
import XCTest
class ScreenshotUtil {
    
    private let screen = XCUIScreen.main
    
    /// Saves the Screenshot as a png image to the folder named "Screenshots" inside the Project folder
    ///
    /// - Parameter screenShotName: The name of the screenshot
    func saveScreenshot(screenShotName: String){
        let fileManager = FileManager.default
        
        let fullscreenshot = screen.screenshot()
        let fileName = getScreenshotFolderPath().appendingPathComponent(screenShotName+".png")
        
        do {
            if fileManager.fileExists(atPath: fileName.absoluteString) {
                try fileManager.removeItem(atPath: fileName.absoluteString)
            }
        }
        catch let error as NSError {
            print("ScreenShot File Error: \(error)")
        }
        try? fullscreenshot.image.pngData()?.write(to: fileName, options: .atomic)
    }
    
    
    static func saveScreenshot(screenShotName: String, screenshotPath: URL){
        let fileManager = FileManager.default
        let screen = XCUIScreen.main
        let fullscreenshot = screen.screenshot()
        let fileName = screenshotPath.appendingPathComponent(screenShotName+".png")
        
        do {
            if fileManager.fileExists(atPath: fileName.absoluteString) {
                try fileManager.removeItem(atPath: fileName.absoluteString)
            }
        }
        catch let error as NSError {
            print("ScreenShot File Error: \(error)")
        }
        try? fullscreenshot.image.pngData()?.write(to: fileName, options: .atomic)
    }
    
    
    /// Creates the Screenshots folder
    ///
    /// - Returns: returns the path to Screenshots folder
    func getScreenshotFolderPath() -> URL{
        var filePath = ""
        let fileManager = FileManager.default
        var path = Bundle.main.builtInPlugInsPath!
        path.append("/WynkMusicUITests.xctest/Info.plist")
        let dictRoot = NSDictionary(contentsOfFile: path)
        if let dict = dictRoot {
            filePath = dict["ProjectPath"] as! String
        }
        
        let screenshotsDirPath = NSURL(fileURLWithPath:filePath).appendingPathComponent("Screenshots")
        do {
            try fileManager.createDirectory(atPath: screenshotsDirPath!.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("Unable to create the ScreenShots directory \(error.debugDescription)")
        }
        return screenshotsDirPath!
    }
    
}

