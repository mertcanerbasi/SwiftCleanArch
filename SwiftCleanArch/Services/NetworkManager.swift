//
//  NetworkManager.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//

import Foundation
import SystemConfiguration


enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }

    func performRequest<T: Codable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }
            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
}
