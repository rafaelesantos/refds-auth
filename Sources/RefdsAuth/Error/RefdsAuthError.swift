import Foundation
import RefdsShared

public enum RefdsAuthError: RefdsAlert, Error {
    case noBiometrics
    case authenticationFailed
    
    public var title: String? {
        switch self {
        case .noBiometrics: return .refdsLocalizable(by: .lockScreenAuthErrorNoBiometricsTitle)
        case .authenticationFailed: return .refdsLocalizable(by: .lockScreenAuthErrorTitle)
        }
    }
    
    public var message: String? {
        switch self {
        case .noBiometrics: return .refdsLocalizable(by: .lockScreenAuthErrorNoBiometricsDescription)
        case .authenticationFailed: return .refdsLocalizable(by: .lockScreenAuthErrorDescription)
        }
    }
}
