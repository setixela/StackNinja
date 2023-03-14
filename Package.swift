// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
   name: "StackNinja",
   platforms: [.iOS(.v14)],
   products: [
      // Products define the executables and libraries a package produces, and make them visible to other packages.
      .library(
         name: "StackNinja",
         targets: ["StackNinja"]
      ),
   ],
   dependencies: [
      // Dependencies declare other packages that this package depends on.
      .package(url: "https://github.com/setixela/ReactiveWorks.git", branch: "master"),
      .package(url: "https://github.com/setixela/Anchorage.git", branch: "main"),
      .package(url: "https://github.com/Alamofire/AlamofireImage.git", from: "4.0.0")
   ],
   targets: [
      // Targets are the basic building blocks of a package. A target can define a module or a test suite.
      // Targets can depend on other targets in this package, and on products in packages this package depends on.
      .target(
         name: "StackNinja",
         dependencies: ["ReactiveWorks", "Anchorage", "AlamofireImage"]
      ),
      .testTarget(
         name: "StackNinjaTests",
         dependencies: ["StackNinja"]
      ),
   ]
)
