//
//  Created by Mihlali Mazomba on 2023/10/26.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import MovieAppList

final class MovieAppListUITests: XCTestCase {

    func testDefaultMovieListController() {
        let sut = MovieListViewController()
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testDefaultAppearanceMoviePosterCard () {
        let contentView = MoviePosterCard(movie: Movie.stubbedMovie)
        assertSnapshot(matching: contentView.toVC(), as: .image)
    }
    
    func testDefaultAppearanceMovieBackDropCard () {
        let contentView = MovieBackDropCard(movie: Movie.stubbedMovieList[1])
        assertSnapshot(matching: contentView.toVC(), as: .image )
    }
    
    func testDefaultAppearanceMovieDetailsView () {
        let contentView = MovieBackDropCard(movie: Movie.stubbedMovie)
        assertSnapshot(matching: contentView.toVC(), as: .image)
    }
}

extension SwiftUI.View {
        func toVC() -> UIViewController {
            let viewController = UIHostingController(rootView: self)
            viewController.view.frame = UIScreen.main.bounds
            return viewController
        }
}
