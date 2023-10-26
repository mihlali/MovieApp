//
//  Created by Mihlali Mazomba on 2023/10/25.
//

import UIKit
import SwiftUI

class MovieCollectionViewPosterCell: CollectionViewSwiftUICell<MoviePosterCard> {
    
    func configure(with movie: Movie, parent: UIViewController) {
        embed(in: parent, withView: MoviePosterCard(movie: movie))
        hostingViewController?.view.frame = self.contentView.bounds
    }
}

struct MovieCollectionViewPosterCellRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> MovieCollectionViewPosterCell {
        let cell = MovieCollectionViewPosterCell()
        return cell
    }
    
    func updateUIView(_ uiView: MovieCollectionViewPosterCell, context: Context) {}
}

struct MovieCollectionViewPosterCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCollectionViewPosterCellRepresentable()
            .frame(width: 250, height: 200)
    }
}
