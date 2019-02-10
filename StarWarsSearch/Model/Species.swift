//
//  Species.swift
//  StarWarsSearch
//
//  Created by Zach Cervi on 2/9/19.
//  Copyright © 2019 Zach Cervi. All rights reserved.
//

import Foundation
import Alamofire

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

enum SpeciesFields: String {
    case Name = "name"
    case Classification = "classification"
    case Designation = "designation"
    case AverageHeight = "average_height"
    case SkinColors = "skin_colors"
    case HairColors = "hair_colors"
    case EyeColors = "eye_colors"
    case AverageLifespan = "average_lifespan"
    case Homeworld = "homeworld"
    case Language = "language"
    case People = "people"
    case Films = "films"
    case Created = "created"
    case Edited = "edited"
    case Url = "url"
}

class SpeciesWrapper {
    var species: [Species]?
    var count: Int?
    var next: String?
    var previous: String?
}

class Species {
    var idNumber: Int?
    var name: String?
    var classification: String?
    var designation: String?
    var averageHeight: Int?
    var skinColors: String?
    var hairColors: String? // TODO: parse into array
    var eyeColors: String? // TODO: array
    var averageLifespan: Int?
    var homeworld: String?
    var language: String?
    var people: [String]?
    var films: [String]?
    var created: Date?
    var edited: Date?
    var url: String?
    
    required init(json: [String: Any]) {
        self.name = json[SpeciesFields.Name.rawValue] as? String
        self.classification = json[SpeciesFields.Classification.rawValue] as? String
        self.designation = json[SpeciesFields.Designation.rawValue] as? String
        self.averageHeight = json[SpeciesFields.AverageHeight.rawValue] as? Int
        // TODO: more fields!
    }
    
//    // MARK: Endpoints
//    class func endpointForID(_ id: Int) -> String {
//        return "https://swapi.co/api/species/\(id)"
//    }

    
    // MARK: CRUD
    // GET / Read single species
//    class func speciesByID(_ id: Int, completionHandler: @escaping (Result<Species>) -> Void) {
//        let _ = Alamofire.request(Species.endpointForID(id))
//            .responseJSON { response in
//                if let error = response.result.error {
//                    completionHandler(.failure(error))
//                    return
//                }
//                let speciesResult = Species.speciesFromResponse(response)
//                completionHandler(speciesResult)
//        }
//    }
    
    // GET / Read all species
    fileprivate class func getSpeciesAtPath(_ path: String, completionHandler: @escaping (Result<SpeciesWrapper>) -> Void) {
        // make sure it's HTTPS because sometimes the API gives us HTTP URLs
        guard var urlComponents = URLComponents(string: path) else {
            let error = BackendError.urlError(reason: "Tried to load an invalid URL")
            completionHandler(.failure(error))
            return
        }
        urlComponents.scheme = "https"
        guard let url = try? urlComponents.asURL() else {
            let error = BackendError.urlError(reason: "Tried to load an invalid URL")
            completionHandler(.failure(error))
            return
        }
        let _ = Alamofire.request(url)
            .responseJSON { response in
                if let error = response.result.error {
                    completionHandler(.failure(error))
                    return
                }
                let speciesWrapperResult = Species.speciesArrayFromResponse(response)
                completionHandler(speciesWrapperResult)
        }
    }
    
    class func getSpecies(_ completionHandler: @escaping (Result<SpeciesWrapper>) -> Void) {
        getSpeciesAtPath(SPECIES_URL, completionHandler: completionHandler)
    }
    
    class func getMoreSpecies(_ wrapper: SpeciesWrapper?, completionHandler: @escaping (Result<SpeciesWrapper>) -> Void) {
        guard let nextURL = wrapper?.next else {
            let error = BackendError.objectSerialization(reason: "Did not get wrapper for more species")
            completionHandler(.failure(error))
            return
        }
        getSpeciesAtPath(nextURL, completionHandler: completionHandler)
    }
    
    private class func speciesFromResponse(_ response: DataResponse<Any>) -> Result<Species> {
        guard response.result.error == nil else {
            // got an error in getting the data, need to handle it
            print(response.result.error!)
            return .failure(response.result.error!)
        }
        
        // make sure we got JSON and it's a dictionary
        guard let json = response.result.value as? [String: Any] else {
            print("didn't get species object as JSON from API")
            return .failure(BackendError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        
        let species = Species(json: json)
        return .success(species)
    }
    
    private class func speciesArrayFromResponse(_ response: DataResponse<Any>) -> Result<SpeciesWrapper> {
        guard response.result.error == nil else {
            // got an error in getting the data, need to handle it
            print(response.result.error!)
            return .failure(response.result.error!)
        }
        
        // make sure we got JSON and it's a dictionary
        guard let json = response.result.value as? [String: Any] else {
            print("didn't get species object as JSON from API")
            return .failure(BackendError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        
        let wrapper:SpeciesWrapper = SpeciesWrapper()
        wrapper.next = json["next"] as? String
        wrapper.previous = json["previous"] as? String
        wrapper.count = json["count"] as? Int
        
        var allSpecies: [Species] = []
        if let results = json["results"] as? [[String: Any]] {
            for jsonSpecies in results {
                let species = Species(json: jsonSpecies)
                allSpecies.append(species)
            }
        }
        wrapper.species = allSpecies
        return .success(wrapper)
    }
}
