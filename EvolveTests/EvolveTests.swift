//
//  EvolveTests.swift
//  EvolveTests
//
//  Created by Liam Vinson on 08/04/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import XCTest
@testable import Evolve

class EvolveTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRandomPolygon() {
        let tests = [(3, 100), (7, 100), (5, 50)]
        
        for (pointLimit, imageSize) in tests {
            let result = Tools.randomPolygon(pointLimit: pointLimit, imageSize: imageSize)
            var pointCount = 0
            for point in result {
                XCTAssert(Int(point.x) <= imageSize)
                XCTAssert(Int(point.y) <= imageSize)
                XCTAssert(Int(point.x) >= 0)
                XCTAssert(Int(point.y) >= 0)
                pointCount += 1
            }
            XCTAssert(pointCount <= pointLimit)
            XCTAssert(pointCount >= 3)
        }
    }
    
    func testRandomRectangle() {
        let limit = 100
        for _ in 0...10 {
            let result = Tools.randomRectangle(imageSize: limit)
            XCTAssert(Int(result.origin.x) + Int(result.width) <= limit)
            XCTAssert(Int(result.origin.y) + Int(result.height) <= limit)
        }
    }
    
    func testGetPixelData() {
        let image = UIImage(named: "test")!
        let result = Tools.getPixelData(image: image, width: 200, height: 200)
        XCTAssert(result.count > 0)
    }
    
    func testMutatePoint() {
        let point = CGPoint(x: 50, y: 50)
        let result = Tools.mutatePoint(point: point, imageSize: 100, pointDeviation: 30)
        XCTAssert(result.x <= 100.0)
        XCTAssert(result.y >= 0.0)
        XCTAssert(result.x <= 100.0)
        XCTAssert(result.y >= 0.0)
    }
    
    func testMutateRectanglePosition() {
        let rectangle = CGRect(x: 50, y: 50, width: 20, height: 20)
        let result = Tools.mutateRectanglePosition(rect: rectangle, imageSize: 100, deviation: 30)
        XCTAssert(result.origin.x <= 100.0)
        XCTAssert(result.origin.y >= 0.0)
        XCTAssert(result.origin.x <= 100.0)
        XCTAssert(result.origin.y >= 0.0)
        XCTAssert(result.height == 20)
        XCTAssert(result.width == 20)
    }
    
    func testMutateRectangleSize() {
        let rectangle = CGRect(x: 50, y: 50, width: 20, height: 20)
        let result = Tools.mutateRectangleSize(rect: rectangle, imageSize: 100)
        XCTAssert(result.origin.x == 50.0)
        XCTAssert(result.origin.y == 50.0)
        XCTAssert(result.height >= 0.0)
        XCTAssert(result.height <= 100.0)
        XCTAssert(result.width >= 0.0)
        XCTAssert(result.width <= 100.0)
    }

}
