//
//  APIRequestService.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 07.02.2021.
//

import Foundation


class APIRequestService {
    
    private let apiErrors: [Int : String] = [
        200 : "OK",
        400 : "Bad request",
        401 : "Unauthorized",
        403 : "Forbidden",
        404 : "Not Found",
        500 : "Error on server",
        503 : "Error on server"
    ]
    
    /// This function requests random photos from the Unsplash API. If the response contains error, it is printed to the console.
    /// Then it passes the data to the model.
    /// - Parameter completion: Escaping closure with the data retrieved (optional).
    func requestPhotos(completion: @escaping (Data?) -> () ) {
        
        let api = "https://api.unsplash.com/photos/random?count=20&client_id=" + UnsplashKey.apiKey
        
        let session = URLSession.shared
        guard let apiUrl = URL(string: api) else {
            print("Invalid API URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode > 200 {
                    print("Response code: \(response.statusCode)")
                    print(self.apiErrors[response.statusCode] ?? "Unknown error")
                    return
                }
            }
            
            guard error == nil else {
                print("Something went wrong during the request")
                return
            }
            if let data = data {
                completion(data)
            } else {
                print("Couldn't complete data task successfully")
                completion(nil)
            }
        })
        dataTask.resume()
    }
}
