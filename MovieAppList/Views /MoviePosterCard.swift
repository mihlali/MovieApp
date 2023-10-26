//
//  Created by Mihlali Mazomba on 2023/10/25.
//

import SwiftUI
import Kingfisher

struct MoviePosterCard: View {
    
    let movie: Movie
    
    var body: some View {
            ZStack {
                RemoteImageLoaderView(url: movie.posterURL, placeholderName: "Placeholder")
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }.frame(width: 204, height: 306)
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.stubbedMovie)
    }
}
