import Foundation

public enum JSONUtils {
    /// A description
    /// - Parameters:
    ///   - type: `Decodable.Type` to decode JSON to
    ///   - data: `Data` for the decoder to process
    ///   - keyDecodingStrategy: `JSONDecoder.KeyDecodingStrategy` - how to transform the result, default: `.convertFromSnakeCase`
    ///
    /// - Throws: `DecodingError.dataCorrupted`
    /// - Returns: Decodable
    public static func decode<T: Decodable>(
        _ type: T.Type,
        from data: Data,
        keyDecodingStrategy: JSONDecoder
            .KeyDecodingStrategy = .convertFromSnakeCase
    ) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        return try decoder.decode(type, from: data)
    }
}
