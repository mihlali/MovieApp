//
//  Created by Mihlali Mazomba on 2023/10/26.
//

import Foundation
import Combine

@testable import MovieAppList

final class MockCreditService: MovieListService {
    
    var result = Result<APIMovieResponse, MovieServiceError>.success(APIMovieResponse(results: Movie.stubbedMovieList))
    
    func fetchMovieList(from endpoint: MovieCategoryType) async throws -> APIMovieResponse {
        let results = try result.get()
        return results
    }
    
    func fetchMovie(id: Int) async throws -> Movie {
        return try result.get().results[1]
    }
}
