////////////////////////////////////////////////////////////////////////////
//
// Copyright 2016 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

extension NSAttributedString {

    func strikedAttributedString(fraction: Double = 1) -> NSAttributedString {
        let range = NSRange(0..<Int(fraction * Double(length)))
        return strike(with: .styleThick, range: range)
    }

    var unstrikedAttributedString: NSAttributedString {
        return strike(with: .styleNone)
    }

    private func strike(with style: NSUnderlineStyle, range: NSRange? = nil) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: self)
        let attributeName = NSStrikethroughStyleAttributeName
        let fullRange = NSRange(0..<length)
        mutableAttributedString.removeAttribute(attributeName, range: fullRange)
        mutableAttributedString.addAttribute(attributeName, value: style.rawValue, range: range ?? fullRange)

        return mutableAttributedString
    }

}

#if os(iOS)
    extension UITextView {

        func strike(fraction: Double = 1) {
            attributedText = attributedText?.strikedAttributedString(fraction: fraction)
        }

        func unstrike() {
            attributedText = attributedText?.unstrikedAttributedString
        }

    }
#elseif os(OSX)
    extension NSTextField {

        func strike(fraction: Double = 1) {
            attributedStringValue = attributedStringValue.strikedAttributedString(fraction: fraction)
        }

        func unstrike() {
            attributedStringValue = attributedStringValue.unstrikedAttributedString
        }

    }
#endif
