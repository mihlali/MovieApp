//
//  Created by Mihlali Mazomba on 2023/10/25.
//

import UIKit
import SwiftUI

class HeaderView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
      let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBInspectable var headerTitle: String = "" {
        didSet {
            headerLabel.text = headerTitle
        }
    }
    
    private func configureView() {
        addSubview(headerLabel)
        NSLayoutConstraint.activate([headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                                     headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                                     headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
                                     headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)])
    }
}


struct HeaderViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> HeaderView {
        let header = HeaderView()
        header.headerTitle = "Header View"
 
        return header
    }
    
    func updateUIView(_ uiView: HeaderView, context: Context) {}
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderViewRepresentable()
            .frame(height: 100)
    }
}
