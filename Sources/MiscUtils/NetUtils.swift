import Foundation

public enum NetUtils {
    /// A description
    /// - Parameters:
    ///   - url: String - url to fetch from
    ///   - headers: - `Dictionary<String, String>` - defaults to `[:]`
    ///   - cachePolicy: - `URLRequest.CachePolicy` - defaults to `.returnCacheDataElseLoad`
    ///
    /// - Throws: `URLError(.badURL)`, `URLError(.badServerResponse)`
    /// - Returns: `Data`
    @available(macOS 12.0, *)
    public static func fetchData(
        url: String,
        headers: [String: String] = [:],
        cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
    ) async throws -> Data {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(
            for: requestURLWithHeaders(
                url: url,
                cachePolicy: cachePolicy,
                headers: headers
            )
        )

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return data
    }

    /// A description
    /// - Parameters:
    ///   - url: `String` - url to fetch from
    ///   - headers: `Dictionary<String,String>` - defaults to `[:]`
    ///   - cachePolicy: `URLRequest.CachePolicy` - defaults to `.returnCacheDataElseLoad`
    ///   - decoder: `JSONDecoder`
    ///   - decodeType: `Decodable.Type` - struct to decode JSON into
    ///
    /// - Throws:
    /// - Returns:
    @available(macOS 12.0, *)
    public static func fetchJSON<T: Decodable>(
        url: String,
        headers: [String: String] = [:],
        cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad,
        decoder: JSONDecoder = JSONDecoder(),
        decodeType: T.Type
    ) async throws -> T {
        let data = try await fetchData(
            url: url,
            headers: headers,
            cachePolicy: cachePolicy
        )
        return try decoder.decode(decodeType, from: data)
    }

    /// A description
    /// - Parameters:
    ///   - url: `URL` to request from
    ///   - cachePolicy: `URLRequest.CachePolicy`
    ///   - headers: `[String:String]`
    ///
    /// - Returns: `URLRequest`
    public static func requestURLWithHeaders(
        url: URL,
        cachePolicy: URLRequest.CachePolicy,
        headers: [String: String] = [:]
    ) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy)
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
