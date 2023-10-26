//
//  Created by Mihlali Mazomba on 2023/10/24.
//

import Foundation

class MovieListServiceConcrete: MovieListService {
    
    private let apiKey = "202182e6bc354fae9236ec2b17864355"
    private let APIBaseURL = "https://api.themoviedb.org/3"
    private let decoder = Utils.jsonDecoder
    
    func fetchMovieList(from endpoint: MovieCategoryType) async throws -> APIMovieResponse {
        guard let url = URL(string: "\(APIBaseURL)/movie/\(endpoint.rawValue)") else { throw MovieServiceError.badURL }
        return try await fetchAndDecode(url: url)
    }
    
    func fetchMovie(id: Int) async throws -> Movie {
        guard let url = URL(string: "\(APIBaseURL)/movie/\(id)") else { throw MovieServiceError.badURL }
        return try await fetchAndDecode(
            url: url,
            parameters: ["append_to_response" : "videos,images"])
    }
    
    private func fetchAndDecode<T: Decodable>(url: URL, parameters: [String: String]? = nil ) async throws -> T {
        let baseURl = url
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        
        let url = baseURl.appending(queryItems: [apiKeyItem])
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            throw MovieServiceError.invalidResponse
        }
        
        do {
            let decodedData  = try decoder.decode(T.self, from: data)
            return decodedData
        } catch _ {
            throw MovieServiceError.decodingError
        }
    }
}
