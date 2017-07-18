//
//  SurveyTests.swift
//  SurveyTests
//
//  Created by Teerawat Vanasapdamrong on 7/12/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import XCTest
@testable import Survey

let surveys = [
    Survey(id: "1", title: "survey 1", description: "test survey 1", coverImageURL: "url"),
    Survey(id: "2", title: "survey 2", description: "test survey 2", coverImageURL: nil),
    Survey(id: "3", title: "survey 3", description: "test survey 3", coverImageURL: nil)
]

class MockNetworkManager: NetworkManager {
    override func getSurveys(completion: @escaping ([Survey]?, Error?) -> Void) {
        completion(surveys, nil)
    }
    
//    override func getImage(imageURL: String, completion: @escaping (UIImage?) -> Void) {
//        if imageURL == "url" {
//            completion(UIImage())
//        } else {
//            completion(nil)
//        }
//    }
}

class SurveyTests: XCTestCase {
    
    var viewModel: SurveysViewModel?
    
    override func setUp() {
        super.setUp()
        viewModel = SurveysViewModel()
//        viewModel?.networkManager = MockNetworkManager()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetServeys() {
        viewModel?.getSurveys(){ flag in
            XCTAssertTrue(flag)
        }
    }
    
    func testGetCellImage() {
//        viewModel?.surveys = surveys
        
//        viewModel?.getCellImage(index: 0) { image in
//            XCTAssertNotNil(image)
//        }
        
//        viewModel?.getCellImage(index: 1) { image in
//            XCTAssertNil(image)
//        }
    }
    
}
