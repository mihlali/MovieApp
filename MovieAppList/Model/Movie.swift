//
//  Created by Mihlali Mazomba on 2023/10/24.
//

import Foundation

struct APIMovieResponse: Decodable {
    
    let results: [Movie]
}

struct Movie: Decodable, Hashable  {

    let id: Int
    let title: String
    let backdropPath: String
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runTime: Int?
    
    let genres: [MovieGenre]?
    
    var imageURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
    
    var posterURL: URL? {
       guard let posterStringURL = posterPath else { return nil }
       return URL(string: "https://image.tmdb.org/t/p/w500\(posterStringURL)")
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var ratingString : String  {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var score: String {
        guard !ratingString.isEmpty else {
            return "n/a"
        }
        return "\(ratingString.count)/ 10"
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id ==  rhs.id && lhs.title == rhs.title
    }
}

struct MovieGenre: Decodable {
    let name: String
}
