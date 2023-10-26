//
//  Created by Mihlali Mazomba on 2023/10/26.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie : Movie
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8)  {
                RemoteImageLoaderView(url: movie.imageURL, placeholderName: "Placeholder")
                    .aspectRatio(16/9, contentMode: .fit)
                HStack() {
                    if !movie.ratingString.isEmpty {
                        Text(movie.ratingString)
                    }
                }.padding()
                
                Text(movie.overview)
                    .padding()
                Spacer(minLength: 4)
            }
            
        }.navigationBarTitle(movie.title)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailsView(movie: Movie.stubbedMovieList[1])
        }
    }
}
