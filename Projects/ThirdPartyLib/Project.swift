//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 새미 on 1/10/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ThirdPartyLib",
    product: .framework,
    packages: [],
    dependencies: [
        .external(name: "RxSwift"),
        .external(name: "SnapKit"),
        .external(name: "Then"),
        .external(name: "Moya"),
        .external(name: "Kingfisher"),
        .external(name: "GAuthSignin"),
        .external(name: "QRCode"),
        .external(name: "QRCodeReader")
    ]
)
