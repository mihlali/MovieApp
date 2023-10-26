//
//  Created by Mihlali Mazomba on 2023/10/25.
//

import SwiftUI
import UIKit


open class CollectionViewSwiftUICell<Content>: UICollectionViewCell where Content: View {
    

    private(set) var hostingViewController: UIHostingController<Content>?
    
   
    func embed(in parent: UIViewController, withView content: Content) {
        if let hostVC = self.hostingViewController {
            hostVC.rootView = content
            hostVC.view.layoutIfNeeded()
        } else {
            let hostVC = UIHostingController(rootView: content)
            
            parent.addChild(hostVC)
            hostVC.didMove(toParent: parent)
            self.contentView.addSubview(hostVC.view)
            self.hostingViewController = hostVC
        }
    }
    
    deinit {
        hostingViewController?.willMove(toParent: nil)
        hostingViewController?.view.removeFromSuperview()
        hostingViewController?.removeFromParent()
        hostingViewController = nil
    }
}
