import SwiftUI

public extension View {
    func refdsAuth(
        isAuthenticated: Binding<Bool>,
        applicationIcon: Image,
        isAutomaticRequest: Bool = true
    ) -> some View {
        self.modifier(
            RefdsRequestBiometryViewModifier(
                isAuthenticated: isAuthenticated,
                applicationIcon: applicationIcon,
                isAutomaticRequest: isAutomaticRequest
            )
        )
    }
}
