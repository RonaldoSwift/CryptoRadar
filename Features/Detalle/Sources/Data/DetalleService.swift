//
//  DetalleService.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 5/06/26.
//

import Foundation
import NetworkKit

public final class DetalleService {
    
    private let apiClient = ApiClient()
    private var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey:"BASE_URL_LIST_CRYPTO") as? String ?? ""
    }
    
    public init() {}
    
    public func getCryptoDetail(id: String) async throws -> CryptoDetailResponse {
        try await apiClient.request(
            baseURL: baseURL,
            endpoint: "/coins/\(id)"
        )
    }
}
