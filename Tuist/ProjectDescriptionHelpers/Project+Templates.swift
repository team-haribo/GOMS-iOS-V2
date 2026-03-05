import ProjectDescription

public extension Project {
    static func makeModule(
        name: String,
        destinations: Destinations = .iOS,
        product: Product,
        organizationName: String = "HARIBO",
        packages: [Package] = [],
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default
    ) -> Project {
        let settings: Settings = .settings(
            base: [
                "OTHER_LDFLAGS": ["-all_load", "-ObjC"],
                "MARKETING_VERSION": "1.5.6",
                "CURRENT_PROJECT_VERSION": "6"
            ],
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ],
            defaultSettings: .recommended
        )

        let appTarget: Target = .target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: "HARIBO.GOMS-iOS-V2",
            deploymentTargets: .iOS("16.0"),
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            settings: settings
        )

        let targets: [Target] = [appTarget]

        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets
        )
    }
}
