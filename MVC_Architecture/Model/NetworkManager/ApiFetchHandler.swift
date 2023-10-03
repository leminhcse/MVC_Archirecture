//
//  ApiFetchHandler.swift
//  MVC_Architecture
//
//  Created by mac on 17/09/2023.
//

import Foundation
import Alamofire

class ApiFetchHandler {
    static let sharedInstance = ApiFetchHandler()
    
    func fetchAPIData() {
        let url = "https://minhdev2006.com/PHP_API/getMovies.php"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode([Movie].self, from: data!)
                        var movies: [Movie] = Utilities.shared.importMovieList(movies: jsonData)
                        let list = ["movie": movies]
                        NotificationCenter.default.post(name: Notification.Name(rawValue: Utilities.GetMoviesSuccessNotification), object: nil, userInfo: list)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

    }
}
