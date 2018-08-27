//
//  MockService.swift
//  Demo
//
//  Created by Daniel Kiss on 2018. 08. 27..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import Foundation
import Toasted

final class MockService {

    // This method represents a custom service operation that has no information about the currect controller presented.
    // You can use toasts even here without referencing which controller (or view) the toast will be presented on.
    static func doSmthg() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            Toast(title: "Mock operation finished after  5.0 second.").show()
        }

    }

}
