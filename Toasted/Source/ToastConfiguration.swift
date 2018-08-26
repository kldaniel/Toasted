//
//  ToastConfiguration.swift
//  Toasted
//
//  Created by Daniel Kiss on 2018. 08. 25..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import Foundation

public struct ToastConfiguration {

    /// How long (in seconds) the Toast will be visible on the screen before it starts to fade out.
    /// Default 3.0 seconds.
    ///
    /// If duration is set to zero, the toast wont be faded automatically, only by calling the
    /// hide() method on the toast or dismissing the view the ToastView was added to.
    ///
    /// - Warning:
    /// Setting this property after the show() method was called has no effect at all!
    let duration: TimeInterval = Toasted.defaultDuration

    let textColor: UIColor = Toasted.defaultTextColor

    let backgroundColor: UIColor = Toasted.defaultBackgroundColor

    let textAlignment: NSTextAlignment = Toasted.defaultTextAlignment

    let font: UIFont = UIFont.systemFont(
        ofSize: 13,
        weight: .regular
    )

}
