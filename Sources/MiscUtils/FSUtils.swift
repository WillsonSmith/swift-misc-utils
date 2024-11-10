import Foundation

public enum FSUtils {
    /// A description
    /// - Parameters:
    ///   - directory: URL to read contents from
    ///   - filter: ((String) -> Bool)? An optional filter function
    ///
    /// - Returns: [URL] An array of URLs for each entry in the directory
    @available(macOS 13.0, *)
    public static func listDirectoryContents(
        directory: URL,
        filter: ((String) -> Bool)? = nil
    )
        -> [URL] {
        guard let entries = try? FileManager.default
            .contentsOfDirectory(atPath: directory.path) else {
            return []
        }

        var entryURLs: [URL] = []
        for entry in entries {
            if let filter {
                guard filter(entry) else {
                    continue
                }
            }
            entryURLs.append(directory.appending(path: entry))
        }

        return entryURLs
    }

    /// A description
    /// - Parameters:
    ///   - url: URL to join with
    ///   - path: String to join the URL with
    ///
    /// - Returns: URL of the joined result
    @available(macOS 13.0, *)
    public static func joinWithURL(url: URL, with path: String) -> URL {
        url.appending(path: path)
    }

    public static func cwd() -> URL {
        URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    }
}
