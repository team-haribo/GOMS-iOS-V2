//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 새미 on 1/10/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "GOMS-iOS-V2",
    destinations: .iOS,
    product: .app,
    dependencies: [
        .project(target: "Feature", path: .relativeToRoot("Projects/Feature"))
    ],
    resources: [
        "Resources/**",
        "Support/GoogleService-Info.plist"
    ],
    infoPlist: .file(path: "Support/Info.plist")
)

