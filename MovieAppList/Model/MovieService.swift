//
//  Created by Mihlali Mazomba on 2023/10/24.
//

import Foundation

enum MovieCategoryType: String, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case topRated = "top_rated"
    
    var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top Rated"
        }
    }
}


enum MovieServiceError: Error {
    case apiError
    case invalidResponse
    case badURL
    case badRequest
    case decodingError
    case genericError
    
    var localisedDescription: String {
        switch self {
        case .apiError: return "Data Fetching Failed"
        case .badRequest: return "Request is invalid"
        case .badURL: return "URL is invalid"
        case .decodingError: return "Failed to decode data"
        case .invalidResponse: return "Response is invalid"
        case .genericError: return "Something went wrong, please try again later"
        
        }
    }
}

protocol MovieListService {
    func fetchMovieList(from endpoint: MovieCategoryType) async throws -> APIMovieResponse
    func fetchMovie(id: Int) async throws -> Movie
}


