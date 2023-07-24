//
//  Clean_MVVM_UIKit_Vanilla_StoreUITestsLaunchTests.swift
//  Clean-MVVM-UIKit-Vanilla-StoreUITests
//
//  Created by 원태영 on 2023/07/25.
//

import XCTest

final class Clean_MVVM_UIKit_Vanilla_StoreUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
