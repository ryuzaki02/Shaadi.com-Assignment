//
//  ListViewModel.swift
//  Shaadi.com Assignment
//
//  Created by Aman on 29/01/21.
//

import Foundation

struct ListViewModel {
    typealias CompletionHandler = (_ dataArray: [UserModel]?) -> Void
    typealias ErrorHandler = (_ error : Error) -> Void
    
    let session: URLSession!
    
    init(urlSession: URLSession = .shared) {
            self.session = urlSession
    }
    
    //MARK:- API methods
    func getUsersFromServer(completionHandler: CompletionHandler?, errorHandler: ErrorHandler?) {
        let request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/users")!)
        callDataTask(request: request, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    private func callDataTask(request: URLRequest, completionHandler: CompletionHandler?, errorHandler: ErrorHandler?){
        let dataTask : URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            DispatchQueue.main.sync {
                if let error = error{
                    errorHandler?(error)
                }else if let httpResponse = response as? HTTPURLResponse,
                    let tempData = data{
                    #if DEBUG
                    print(String(data: tempData, encoding: String.Encoding.utf8) ?? "")
                    #endif
                    if httpResponse.statusCode == 200{
                        let decoder = JSONDecoder()
                        do{
                            let arr  = try decoder.decode([UserModel].self, from: tempData)
                            completionHandler?(arr)
                        }
                        catch{
                            
                        }
                    }else{
                        //Handle error here
                    }
                }
            }
        })
        dataTask.resume()
    }
}
