




import Foundation

func dTJBVqGBfCPRQL<T: Sendable>(
    _ operation: @escaping @Sendable () async throws -> T
) async -> Result<T, Error> {
    await Task {
        do {
            return .success(try await operation())
        } catch {
            return .failure(error)
        }
    }.value
}

