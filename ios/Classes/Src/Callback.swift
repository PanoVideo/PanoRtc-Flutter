//
//  Callback.swift
//  pano_rtc
//
//  Copyright © 2021 Pano. All rights reserved.
//

import Foundation
import PanoRtc

@objc
protocol Callback: class {
    func success(_ data: Any?)

    func failure(_ code: String)
}

extension Callback {
    func code(_ code: PanoResult?) {
        guard let `code` = code else {
            let newCode = PanoResult.notInitialized.rawValue
            failure(String(newCode))
            return
        }
        success(code.rawValue)
    }

    func resolve<T>(_ source: T?, _ runnable: (T) -> Any?) {
        guard let `source` = source else {
            let code = PanoResult.notInitialized.rawValue
            failure(String(code))
            return
        }

        let res = runnable(source)
        if res is Void {
            success(nil)
        } else {
            success(res)
        }
    }
}
