// swift-tools-version: 5.9
//
//  Package.swift
//
//
//  Created by 서지완 on 5/16/24.
//

import PackageDescription

let package = Package(
    name: "PlacePackage",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.1"),
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
        .package(url: "https://github.com/devxoul/Then", from: "2.0.0"),
        .package(url: "https://github.com/GSM-MSG/GAuthSignin-Swift", from: "0.0.3"),
        .package(url: "https://github.com/dmrschmidt/QRCode", from: "1.0.0"),
        .package(url: "https://github.com/yannickl/QRCodeReader.swift.git", from: "10.1.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.5.0")
    ]
)
