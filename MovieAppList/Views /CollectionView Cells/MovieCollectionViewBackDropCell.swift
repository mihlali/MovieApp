//
//  Created by Mihlali Mazomba on 2023/10/25.
//

import UIKit
import SwiftUI

class MovieCollectionViewBackDropCell: CollectionViewSwiftUICell<MovieBackDropCard> {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with movie: Movie, parent: UIViewController) {
        embed(in: parent, withView: MovieBackDropCard(movie: movie))
        hostingViewController?.view.frame = self.contentView.bounds
    }
}

struct MovieCollectionViewCellRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> MovieCollectionViewBackDropCell{
        let cell = MovieCollectionViewBackDropCell()
        return cell
    }
    
    func updateUIView(_ uiView: MovieCollectionViewBackDropCell, context: Context) {}
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCollectionViewCellRepresentable()
            .frame(width: 250, height: 200)
    }
}
