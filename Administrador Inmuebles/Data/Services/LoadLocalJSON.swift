//
//  LoadLocalJSON.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 30/10/26.
//

import Foundation

struct LoadLocalJSONService {
    static func loadJSON<T: Decodable>(filename: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Error: No se encontró el archivo \(filename).json en el Bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return decodedData
            
        } catch {
            print("Error al decodificar el JSON (\(filename)): \(error)")
            return nil
        }
    }
}
