import Foundation

public enum IOUtils {
    // MARK: Public

    /// A description
    /// - Parameters:
    ///   - string: contents of the file to write
    ///   - urlToWrite: where to write the file
    ///   - createMissingDirectories: create directories if they do not exist, default to true
    ///
    /// - Throws: Data error if the URL cannot be read
    public static func writeStringToFile(
        _ string: String,
        toURL urlToWrite: URL,
        createMissingDirectories: Bool = true
    ) throws {
        let fileManager = FileManager.default
        let directory = urlToWrite.deletingLastPathComponent()
        try fileManager.createDirectory(
            at: directory,
            withIntermediateDirectories: createMissingDirectories
        )
    }

    /// A description
    /// - Parameter fileUrl: url for file to write
    /// - Throws: Data error if the url cannot be read
    /// - Returns: String?
    public static func readStringFromFile(at fileUrl: URL) throws -> String? {
        String(data: try Data(contentsOf: fileUrl), encoding: .utf8)
    }

    // MARK: Private

    /// A description
    /// - Parameters:
    ///   - string: Contents of the file
    ///   - to: the url of file
    ///
    /// - Throws: when the file fails to write
    private static func writeString(_ string: String, to: URL) throws {
        try string.write(to: to, atomically: true, encoding: .utf8)
    }
}
