//
//  Shaadi_com_AssignmentTests.swift
//  Shaadi.com AssignmentTests
//
//  Created by Aman on 29/01/21.
//

import XCTest
@testable import Shaadi_com_Assignment

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        
        do{
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }catch{
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        
    }
}

class Shaadi_com_AssignmentTests: XCTestCase {
    
    var urlSession: URLSession!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetList() throws {
        let viewModel = ListViewModel(urlSession: urlSession)
        if let path = Bundle.main.path(forResource: "Mock", ofType: "json"){
            let fileUrl = URL(fileURLWithPath: path)
            // Getting data from JSON file using the file URL
            let mockData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            let mockArr  = try JSONDecoder().decode([UserModel].self, from: mockData)
            MockURLProtocol.requestHandler = { request in
                return (HTTPURLResponse(), mockData)
            }
            let expectation = XCTestExpectation(description: "response")
            viewModel.getUsersFromServer { (userModelArray) in
                if let modelArr = userModelArray,
                   modelArr.count > 0{
                    XCTAssertEqual(mockArr, modelArr)
                    expectation.fulfill()
                }else{
                    XCTFail("Server returned empty data")
                }
            } errorHandler: { (error) in
                XCTFail("Server failed")
            }
            wait(for: [expectation], timeout: 5)
        }else{
            XCTFail("Operator failed")
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
