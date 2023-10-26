//
//  Created by Mihlali Mazomba on 2023/10/26.
//

import Foundation
import UIKit

extension MovieListViewController {
    
    func showFailureMessage(withError error: MovieServiceError) {
        var errorMessage = error.localisedDescription
         
        let message = UIAlertController(title: "Error" , message: errorMessage, preferredStyle: .alert)
        
        let OkAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if error == .apiError  {
                self?.viewModel.fetchMoviesList()
            }
        }
        message.addAction(OkAction)
        self.present(message, animated: true, completion: nil)
    }
}
