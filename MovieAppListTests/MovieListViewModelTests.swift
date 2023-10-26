//
//  Created by Mihlali Mazomba on 2023/10/26.
//

import Combine
import Foundation
import XCTest

@testable import MovieAppList

class MovieListViewModelTests: XCTestCase {
    
    private var movie: Movie!
    private var service : MockCreditService!
    private var viewModel: MovieListViewModel!
    private var disposable = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        service = MockCreditService()
        viewModel = MovieListViewModel(movieService: service)
    }
    
    override func tearDown() {
        service = nil
        viewModel = nil
        super.tearDown()
    }
  
    func testRefreshScreenWithSuccess() {

        let expectation = self.expectation(description: "successful")
        viewModel
            .refreshViewPublisher
            .receive(on: DispatchQueue.main)
            .sink { _ in
 
            } receiveValue: { refresh in
                expectation.fulfill()
            }.store(in: &disposable)
        
        
         viewModel.fetchMoviesList()
        
        waitForExpectations(timeout: 10)
    }
    
    func testRefreshScreenWithFailure() {
        var screenRefreshed = false
        let expectation = self.expectation(description: "Failure")
        viewModel
            .refreshViewPublisher
            .receive(on: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { _ in
            }.store(in: &disposable)
        
        service.result = .failure(.badRequest)
        viewModel.fetchMoviesList()
        
        waitForExpectations(timeout: 10)
    }
    
    
    func testRefreshScreenWithData() {

        let expectation = self.expectation(description: "successful")
        viewModel
            .refreshViewPublisher
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { refresh in
                expectation.fulfill()
            }.store(in: &disposable)
        
         viewModel.fetchMoviesList()
        
        
        waitForExpectations(timeout: 10)
        
        let firstMovie = viewModel.movieSections?.first?.movies.first
        
        XCTAssertEqual(firstMovie?.title, "Saw X")
        XCTAssertNotNil(firstMovie?.imageURL)
        XCTAssertEqual(firstMovie?.ratingString.count, 7)
        
    }
}
