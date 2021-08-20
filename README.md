# NativeUIKit

Mimicrated views and controls to native Apple appearance. If you have any ideas of what elements can be added, let me know. Here provided all elements which available, tap for open docs for it.

<p float="left" style="margin: 100px">
    <a href="#NativeAvatarView">
        <img src="https://github.com/ivanvorobei/NativeUIKit/blob/main/Assets/Readme/Elements/NativeAvatarView.svg">
    </a>
    &nbsp;
    <a href="#NativeLargeActionButton">
        <img src="https://github.com/ivanvorobei/NativeUIKit/blob/main/Assets/Readme/Elements/NativeLargeActionButton.svg">
    </a>
    &nbsp;
    <a href="#NativeSmallActionButton">
        <img src="https://github.com/ivanvorobei/NativeUIKit/blob/main/Assets/Readme/Elements/NativeSmallActionButton.svg">
    </a>
</p>

If you like the project, don't forget to `put star ★`<br>Check out my other libraries:

<p float="left">
    <a href="https://opensource.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/more-libraries.svg">
    </a>
</p>

## Navigate

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Manually](#manually)
- [Classes](#usage)
    - [NativeLargeActionButton](#NativeLargeActionButton)
    - [NativeSmallActionButton](#NativeSmallActionButton)
    - [NativeAvatarView](#NativeAvatarView)
- [Other Projects](#other-projects)
- [Russian Community](#russian-community)

## Installation

Ready for use on iOS 12+, tvOS 12+ & watchOS 6.0+. Works with Swift 5+. Required Xcode 12.0 and higher.

<img align="right" src="https://github.com/ivanvorobei/NativeUIKit/blob/main/Assets/Readme/spm-install-preview.png" width="520"/>

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate using Xcode 12, specify it in `File > Swift Packages > Add Package Dependency...`:

```ogdl
https://github.com/ivanvorobei/NativeUIKit
```

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'NativeUIKit'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/NativeUIKit` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Classes


### [NativeLargeActionButton](https://github.com/ivanvorobei/NativeUIKit/blob/main/Sources/NativeUIKit/NativeLargeActionButton.swift)

Usually used at the bottom of the screen. You can set an icon. You can set how to change the style when you click. Supports states `disabled` and `dimmed`.

<p float="left">
    <a href="https://opensource.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/NativeUIKit/blob/main/Assets/Readme/Elements/NativeLargeActionButton.svg">
    </a>
</p>

Next code for usage:

```swift
// Set Appearance and Content
let button = NativeLargeActionButton()
button.setImage(UIImage.init(systemName: "plus.circle.fill")!)
button.higlightStyle = .background
button.applyDefaultAppearance(with: .init(content: .custom(.white), background: .tint))

// or use Wrapper
button.set(
    title: "Large Action",
    icon: UIImage.init(systemName: "plus.circle.fill")!,
    colorise: .init(content: .custom(.white), background: .tint)
)
```

Button support system layouts by `sizeToFit()`. Next code allow you to layout button with cutom width:

```swift
button.sizeToFit()
button.frame = .init(x: 0, y: 0, width: 300, height: button.frame.height)
```

### [NativeSmallActionButton](https://github.com/ivanvorobei/NativeUIKit/blob/main/Sources/NativeUIKit/NativeSmallActionButton.swift)

You definitely saw this button in the AppStore. You can use it without the icon.<br>
Supports states `disabled` and `dimmed`.

<p float="left">
    <a href="https://opensource.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/NativeUIKit/blob/main/Assets/Readme/Elements/NativeSmallActionButton.svg">
    </a>
</p>

Next code for usage:

```swift
// Set Appearance and Content
let button = NativeSmallActionButton()
button.higlightStyle = .background
button.applyDefaultAppearance(with: .init(content: .custom(.white), background: .tint))

// or use Wrapper
button.set(
    title: "Edit",
    icon: nil,
    colorise: .init(content: .custom(.white), background: .tint)
)
```

Button support system layouts by `sizeToFit()`. Next code allow you to layout button:

```swift
button.sizeToFit()
```

### [NativeAvatarView](https://github.com/ivanvorobei/NativeUIKit/blob/main/Sources/NativeUIKit/NativeAvatarView.swift)

<a href="https://opensource.ivanvorobei.by">
    <img align="left" src="https://github.com/ivanvorobei/NativeUIKit/blob/main/Assets/Readme/Elements/NativeAvatarView.svg"/>
</a>

Avatar view is container with 3 buttons - placeholder, avatar and indicator. For change avatar set `avatarAppearance`. For show or hide edit button set `isEditable`.

Layout availbe by size to fit for content. In this case change placeholder size to valid SFSymbol for have correct fit. By default font side is 80 point. Or you can set fixed frame and ignore fitting size.

```swift
let avatarView = NativeAvatarView()

// You can set target, actions or even contex menu like usual button.
avatarView.placeholderButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
avatarView.avatarButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
avatarView.indicatorButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)

// For show edit button.
avatarView.isEditable = true

// Layout.
// For fit by images:
avatarView.sizeToFit()
// By custom frame:
avatarView.frame = .init(x: 0, y: 0, width: 60, height: 60)
```

## Other Projects

I love being helpful. Here I have provided a list of libraries that I keep up to date. For see `video previews` of libraries without install open [opensource.ivanvorobei.by](https://opensource.ivanvorobei.by) website.

<p float="left">
    <a href="https://opensource.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/more-libraries.svg">
    </a>
</p>

## Russian Community

Подписывайся в телеграмм-канал, если хочешь получать уведомления о новых туториалах.<br>
Со сложными и непонятными задачами помогут в чате.

<p float="left">
    <a href="https://sparrowcode.by/telegram/channel">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/russian-community-tutorials.svg">
    </a>
    <a href="https://sparrowcode.by/telegram/libs">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/russian-community-libraries.svg">
    </a>
    <a href="https://sparrowcode.by/telegram/chat">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/russian-community-chat.svg">
    </a>
</p>

Видео-туториалы выклыдываю на [YouTube](https://sparrowcode.by/youtube):

[![Tutorials on YouTube](https://cdn.ivanvorobei.by/github/readme/youtube-preview.jpg)](https://sparrowcode.by/youtube)
