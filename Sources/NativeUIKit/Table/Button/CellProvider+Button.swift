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
import SPDiffable

@available(iOS 13.0, *)
extension SPDiffableTableDataSource.CellProvider {
    
    public static var button: SPDiffableTableDataSource.CellProvider  {
        return SPDiffableTableDataSource.CellProvider() { (tableView, indexPath, item) -> UITableViewCell? in
            guard let item = item as? NativeDiffableLeftButton else { return nil }
            let cell = tableView.dequeueReusableCell(withClass: NativeLeftButtonTableViewCell.self, for: indexPath)
            cell.textLabel?.text = item.text
            cell.textLabel?.textColor = item.textColor
            cell.detailTextLabel?.text = item.detail
            cell.detailTextLabel?.textColor = item.detailColor
            cell.imageView?.image = item.icon
            cell.accessoryType = item.accessoryType
            cell.higlightStyle = item.higlightStyle
            return cell
        }
    }
}
#endif
