//
//  RequestData.swift
//  Flickr Demo
//
//  Created by Jovial on 07/08/2021.
//

import Foundation
import Alamofire

class RequestData {
    static func getInstance() -> RequestData {
        return RequestData()
    }
    
    func getImages(tags: String, numberOfImages: Int, completionHandler:@escaping(Array<ImageModel>, String) -> Void) {
        var outputImages = Array<ImageModel>()
        if var urlBuilder = URLComponents(string: APIConstant.MAIN_URL + APIConstant.GET_IMAGES) {
            // Use query items instead of [String : Any] Object for params
            urlBuilder.queryItems = [
                URLQueryItem(name: "api_key", value: APIConstant.API_KEY),
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "tags", value: tags),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: String(true)),
                URLQueryItem(name: "extras", value: "media,url_sq,url_m"),
                URLQueryItem(name: "per_page", value: String(numberOfImages)),
                URLQueryItem(name: "page", value: String(1))
            ]
            
            if let inputURL = urlBuilder.url {
                // Start Request Image from Flick API
                AF.request(inputURL, method: .post, parameters: Dictionary<String, String>(), encoder: JSONParameterEncoder.default).validate().responseJSON {
                    response in
                    switch response.result {
                    // Success API Call
                    case .success(let data):
                        if let outputData = data as? [String : Any] {
                            if let status = outputData["stat"] as? String {
                                // Check Status equals "ok" & the response contains "photos"
                                if status.lowercased().compare("ok") == ComparisonResult.orderedSame && outputData.contains(where: { (key: String, value: Any) -> Bool in
                                    return key == "photos"
                                }) {
                                    // Convert & Loop the JSON Array of "photo" into ImageMOdel Class
                                    if let photos = outputData["photos"] as? [String : Any] {
                                        if let images = photos["photo"] as? [Any] {
                                            do {
                                                let decoder = JSONDecoder()
                                                for item in images {
                                                    let itemData = try JSONSerialization.data(withJSONObject: item)
                                                    let image = try decoder.decode(ImageModel.self, from: itemData)
                                                    outputImages.append(image)
                                                }

                                                completionHandler(outputImages, "")
                                                return
                                            } catch let convertError {
                                                print("getImages: Error on Conversion -> \(convertError)")
                                            }
                                        }
                                    }
                                }
                                
                                // Show empty result for Code 3
                                if let code = outputData["code"] as? Int, code == 3 {
                                    completionHandler(outputImages, "")
                                    return
                                }
                            }
                        }

                        completionHandler(outputImages, "100-Response Unable to Process Response")
                    // Fail API Call
                    case .failure(let error):
                        print("getImages: \(error)")
                        completionHandler(outputImages, "501-Error API Call")
                    }
                }
                return
            }
        }
        
        completionHandler(outputImages, "502-Error Building URL Request")
    }
}
