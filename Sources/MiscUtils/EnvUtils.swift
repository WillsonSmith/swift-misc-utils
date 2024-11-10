import Foundation
public enum EnvUtils {
    /// A description
    /// - Parameter variable: String of the env variable to fetch
    /// - Returns: String? Some string if the variable exists
    public static func env(for variable: String) -> String? {
        ProcessInfo.processInfo.environment[variable]
    }
}
