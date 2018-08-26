//
//  ToastHelper.swift
//  Toasted
//
//  Created by Daniel Kiss on 2018. 08. 27..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import Foundation

final class ToastHelper {

    static func applicationWindow() -> UIWindow? {
        return UIApplication.shared.delegate?.window ?? nil
    }

}
