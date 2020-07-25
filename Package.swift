// swift-tools-version:5.2
import PackageDescription
let package = Package(
	name: "DiffTableDirector",
	platforms: [
		.iOS(.v11),
	],
	products: [
		.library(name: "DiffTableDirector", targets: ["DiffTableDirector"])
	],
	dependencies: [
		.package(url: "https://github.com/onmyway133/DeepDiff.git", .upToNextMajor(from: "2.3.0")),
	],
	targets: [
		.target(name: "DiffTableDirector", dependencies: ["DeepDiff"], path: "DiffTableDirector")
	]
)
