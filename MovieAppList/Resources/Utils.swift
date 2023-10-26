//
//  Created by Mihlali Mazomba on 2023/10/24.
//

import Foundation

class Utils {
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-mm-dd"
        return formatter
    }()
    
    static let jsonDecoder: JSONDecoder = {
      let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        return jsonDecoder
    }()
}
