//
//  Created by Mihlali Mazomba on 2023/10/24.
//

import SwiftUI
import Kingfisher

struct RemoteImageLoaderView: View {

    let url: URL?
    let placeholderName: String

    var body: some View {
        KFImage(url)
            .fade(duration: 0.3)
            .placeholder {
                Image(placeholderName)
                    .resizable()
                    .scaledToFill()
            }
            .resizable()
            .scaledToFill()
    }
}
