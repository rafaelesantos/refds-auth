import SwiftUI
import RefdsShared
import LocalAuthentication

@MainActor
public class RefdsAuth: ObservableObject {
    @Published public var error: RefdsAuthError?
    
    public init() {}
    
    func requestAuthentication() async -> Bool {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) {
            let reason: String = .refdsLocalizable(by: .lockScreenRequestAuthReason)

            do {
                let _ = try await context.evaluatePolicy(
                    .deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: reason
                )
                return true
            } catch {
                self.error = .authenticationFailed
            }
        } else {
            self.error = .noBiometrics
        }
        
        return false
    }
}
