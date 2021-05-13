//
//  APIHelper.swift
//  MovieAPP2_demo
//
//  Created by ngoc son on 18/04/2021.
//

import Foundation
class FetchData {
    
    public static let shared = FetchData()
    
    func getDataPopular(url : String, completed: @escaping (Popular?, Bool, Error?)->Void){
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 120
            
            URLSession.shared.dataTask(with: url) { (data, reponse, error) in
                
                guard let data =  data else {return}
                
                do{
                    
                    let postsData = try JSONDecoder().decode(Popular.self,from: data)
                    DispatchQueue.main.async {
                        completed(postsData, true, nil)
                    }
                    
                    
                }catch{
                    completed(nil, false, error)
                }
            }.resume()
        }
    }
    func getDataNowPlaying(url : String, completed: @escaping (NowPlaying?, Bool, Error?)->Void){
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 120
            
            URLSession.shared.dataTask(with: url) { (data, reponse, error) in
                
                guard let data =  data else {return}
                
                do{
                    
                    let postsData = try JSONDecoder().decode(NowPlaying.self,from: data)
                    DispatchQueue.main.async {
                        completed(postsData, true, nil)
                    }
                    
                }catch{
                    completed(nil, false, error)
                    
                }
            }.resume()
        }
    }
    func getDataListGenre(url : String, completed: @escaping (ListGenre?, Bool, Error?)->Void){
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 120
            
            URLSession.shared.dataTask(with: url) { (data, reponse, error) in
                
                guard let data =  data else {return}
                
                do{
                    
                    let postsData = try JSONDecoder().decode(ListGenre.self,from: data)
                    DispatchQueue.main.async {
                        completed(postsData, true, nil)
                    }
                    
                }catch{
                    completed(nil, false, error)
                    
                }
            }.resume()
        }
    }
    func getDataDetail(url : String, completed: @escaping (MovieDetail?, Bool, Error?)->Void){
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 120
            
            URLSession.shared.dataTask(with: url) { (data, reponse, error) in
                
                guard let data =  data else {return}
                
                do{
                    
                    let postsData = try JSONDecoder().decode(MovieDetail.self,from: data)
                    DispatchQueue.main.async {
                        completed(postsData, true, nil)
                    }
                    
                    
                }catch{
                    completed(nil, false, error)
                }
            }.resume()
        }
    }
    func getDataDetail2(url : String, completed: @escaping (MovieDetails?, Bool, Error?)->Void){
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 120
            
            URLSession.shared.dataTask(with: url) { (data, reponse, error) in
                
                guard let data =  data else {return}
                
                do{
                    
                    let postsData = try JSONDecoder().decode(MovieDetails.self,from: data)
                    DispatchQueue.main.async {
                        completed(postsData, true, nil)
                    }
                    
                    
                }catch{
                    completed(nil, false, error)
                }
            }.resume()
        }
    }
}

