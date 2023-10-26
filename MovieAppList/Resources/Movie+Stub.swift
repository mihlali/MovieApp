//
//  Created by Mihlali Mazomba on 2023/10/24.
//

import Foundation

extension Movie {
    
    static var stubbedMovieList: [Movie] {
        let response: APIMovieResponse? = try? Bundle.main.loadJSON(fileName: "movie_list")
        return response?.results ?? []
    }
    
    static var stubbedMovie: Movie {
        return stubbedMovieList[0]
    }
}

extension Bundle {
    
    func loadJSON<T: Decodable>(fileName: String) throws -> T? {
        guard let url = self.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        let data = try Data(contentsOf: url)
        let decoder = Utils.jsonDecoder
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}
