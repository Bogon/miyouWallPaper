// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let previewHome7I4 = ImageAsset(name: "preview_home7_i4")
  internal static let previewHome7I5 = ImageAsset(name: "preview_home7_i5")
  internal static let previewHome7I6 = ImageAsset(name: "preview_home7_i6")
  internal static let previewHome7I6p = ImageAsset(name: "preview_home7_i6p")
  internal static let previewHome7Ixp = ImageAsset(name: "preview_home7_ixp")
  internal static let previewLock7I4 = ImageAsset(name: "preview_lock7_i4")
  internal static let previewLock7I5 = ImageAsset(name: "preview_lock7_i5")
  internal static let previewLock7I6 = ImageAsset(name: "preview_lock7_i6")
  internal static let previewLock7I6p = ImageAsset(name: "preview_lock7_i6p")
  internal static let previewLock7Ixp = ImageAsset(name: "preview_lock7_ixp")
  internal static let arrow = ImageAsset(name: "arrow")
  internal static let arrowSetting = ImageAsset(name: "arrow_setting")
  internal static let avatarDefault = ImageAsset(name: "avatar_default")
  internal static let back = ImageAsset(name: "back")
  internal static let bottom = ImageAsset(name: "bottom")
  internal static let clearCache = ImageAsset(name: "clear_cache")
  internal static let cover = ImageAsset(name: "cover")
  internal static let download = ImageAsset(name: "download")
  internal static let homeSelected = ImageAsset(name: "home_selected")
  internal static let livePreview = ImageAsset(name: "live_preview")
  internal static let liveSave = ImageAsset(name: "live_save")
  internal static let pBack = ImageAsset(name: "p_back")
  internal static let ph1 = ImageAsset(name: "p_h_1")
  internal static let preDynamic = ImageAsset(name: "pre_dynamic")
  internal static let preview = ImageAsset(name: "preview")
  internal static let privacy = ImageAsset(name: "privacy")
  internal static let `protocol` = ImageAsset(name: "protocol")
  internal static let setting = ImageAsset(name: "setting")
  internal static let share = ImageAsset(name: "share")
  internal static let titleView = ImageAsset(name: "title_view")
  internal static let versionUpdate = ImageAsset(name: "version_update")
  internal static let xiala = ImageAsset(name: "xiala")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
