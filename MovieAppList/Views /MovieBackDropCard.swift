//
//  Created by Mihlali Mazomba on 2023/10/24.
//

import SwiftUI

struct MovieBackDropCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            RemoteImageLoaderView(
                url: movie.imageURL,
                placeholderName: "Placeholder")
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
            .shadow(radius: 4)

            
            Text(movie.title)
                .font(.body)
        }.padding()
    }
}

struct Movie_Card_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackDropCard(movie: Movie.stubbedMovie)
    }
}
