//
//  ResultCallback.swift
//  pano_rtc
//
//  Copyright © 2020 Pano. All rights reserved.
//

import Foundation
import PanoRtc

class ResultCallback: NSObject, Callback {
    private var result: FlutterResult?

    init(_ result: FlutterResult?) {
        self.result = result
    }

    func success(_ data: Any?) {
        result?(data)
    }

    func failure(_ code: String) {
        result?(FlutterError.init(code: code, message: nil, details: nil))
    }
}
