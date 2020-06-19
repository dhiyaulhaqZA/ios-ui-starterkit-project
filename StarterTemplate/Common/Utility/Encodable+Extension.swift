//
//  Encodable+Extension.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 24/10/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            print("<Encodable>.toDictionary(): JSONEncoder error")
            return [String: Any]()
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }!
    }
    
    func toJson() -> String? {
        var jsonString: String?
        do {
            let jsonData = try JSONEncoder().encode(self)
            jsonString = String(data: jsonData, encoding: .utf8)
        } catch {
            print("\(error.localizedDescription)")
        }
        return jsonString
    }
}
