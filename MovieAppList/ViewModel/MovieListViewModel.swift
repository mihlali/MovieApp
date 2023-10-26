//
//  Created by Mihlali Mazomba on 2023/10/25.
//

import Foundation
import Combine

struct MoviesSections {
    let categoryType: MovieCategoryType
    let movies: [Movie]
}

class MovieListViewModel {
    
    let refreshViewSubject = PassthroughSubject<Bool, MovieServiceError>()
    private let movieService: MovieListService
    private(set) var movieSections: [MoviesSections]?

    
    init(movieService: MovieListService) {
        self.movieService = movieService
    }
    
    var title: String {
        return "Movies"
    }
    
    var refreshViewPublisher: AnyPublisher<Bool, MovieServiceError> {
        return refreshViewSubject.eraseToAnyPublisher()
    }
    
    func fetchMoviesList() {
        let movieTypes: [MovieCategoryType] = MovieCategoryType.allCases
        Task {
            
            do {
                movieSections = try await withThrowingTaskGroup(of: (MovieCategoryType, [Movie])?.self,
                                                                returning: [MoviesSections].self,
                                                                body: { taskGroup in
                    
                    for type in movieTypes {
                        
                        taskGroup.addTask { [weak self] in
                            guard let self = self else { return nil }
                            let movieResponse = try await self.movieService.fetchMovieList(from: type)
                            return (type, movieResponse.results)
                        }
                    }
                    
                    var movies = [MoviesSections]()
                    
                    for try await (type, moviesResult) in taskGroup.compactMap({$0}) {
                        movies.append(MoviesSections(categoryType: type, movies: moviesResult))
                    }
                    return movies
                })
                
                refreshViewSubject.send(true)
            } catch let error {
                guard let error = error as? MovieServiceError  else {
                refreshViewSubject.send(completion: .failure(.genericError))
                    return
                }
                refreshViewSubject.send(completion: .failure(error))
            }
        }
    }
}
