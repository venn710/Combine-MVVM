//
//  Subscribers.Completion+Ext.swift
//  Combine+MVVM
//
//  Created by Venkatesham Boddula on 27/07/24.
//

import Combine

extension Subscribers.Completion {
    var error: Failure? {
        return switch self {
        case .failure(let failure2):
            failure2
        default:
            nil
        }
    }
}
