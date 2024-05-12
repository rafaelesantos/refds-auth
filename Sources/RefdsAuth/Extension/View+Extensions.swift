import SwiftUI

public extension View {
    func refdsAuth(
        autheticated: Binding<Bool>,
        applicationIcon: Image,
        isAutomaticRequest: Bool = true
    ) -> some View {
        self.modifier(
            RefdsRequestBiometryViewModifier(
                isAuthenticated: autheticated,
                applicationIcon: applicationIcon,
                isAutomaticRequest: isAutomaticRequest
            )
        )
    }
}
