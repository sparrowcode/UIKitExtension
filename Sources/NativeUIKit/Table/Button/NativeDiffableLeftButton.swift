// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(UIKit) && (os(iOS))
import UIKit
import SparrowKit
import SPDiffable

@available(iOS 13.0, *)
open class NativeDiffableLeftButton: SPDiffableTableRow {
    
    open var textColor: UIColor
    open var detailColor: UIColor
    open var higlightStyle: SPTableViewCell.HiglightStyle
    
    public init(
        id: String? = nil,
        text: String,
        textColor: UIColor = .label,
        detail: String? = nil,
        detailColor: UIColor = .secondaryLabel,
        icon: UIImage? = nil,
        accessoryType: UITableViewCell.AccessoryType = .none,
        higlightStyle: SPTableViewCell.HiglightStyle = .content,
        action: SPDiffableTableRow.Action? = nil
    ) {
        self.textColor = textColor
        self.detailColor = detailColor
        self.higlightStyle = higlightStyle
        
        super.init(
            id: id,
            text: text,
            detail: detail,
            icon: icon,
            accessoryType: accessoryType,
            action: action
        )
    }
}
#endif
