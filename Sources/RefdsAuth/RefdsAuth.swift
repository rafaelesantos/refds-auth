import SwiftUI
import RefdsShared
import LocalAuthentication

public final class RefdsAuth: ObservableObject {
    @Published public var error: RefdsAuthError?
    
    public init() {}
    
    func requestAuthentication(completion: @escaping () -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) {
            let reason: String = .refdsLocalizable(by: .lockScreenRequestAuthReason)
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            ) { success, _ in
                guard success else { return DispatchQueue.main.async {
                    self.error = .authenticationFailed
                } }
                completion()
            }
        } else {
            DispatchQueue.main.async {
                self.error = .noBiometrics
            }
        }
    }
}
