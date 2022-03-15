//
//  GithubAPIUnitTest.swift
//  Boilerplate-iOSTests
//
//  Created by Tuan Tang on 15/03/2022.
//

import XCTest
import RxSwift
@testable import Boilerplate_iOS

class GithubAPIUnitTest: XCTestCase {
    
    private let disposeBag = DisposeBag()

    func test_GithubAPI_With_Get_Users() {
        
        let request = GithubRequest()
        request
            .getDetail(login: "2")
            .asObservable()
            .subscribe(onNext: { response in
                XCTAssertNotNil(response)
                XCTAssertNil(response.error)
                XCTAssertNotNil(response.data)
                XCTAssertNotNil(response.data?.name)
                XCTAssertNotNil(response.data?.followers)
                XCTAssertEqual("2", response.data?.name)
                XCTAssertEqual(2, response.data?.followers)
            }).disposed(by: disposeBag)
    }

}
