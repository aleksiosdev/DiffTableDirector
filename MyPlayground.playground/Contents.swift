import UIKit

protocol OperationErrorable: Operation {
	var error: Error? { get }
}

final class OperationA: Operation, OperationErrorable {
	var error: Error?
}

final class OperationB: Operation, OperationErrorable {
	var error: Error?

	override func start() {
		super.start()

		if let previousError = (dependencies.last as? OperationErrorable)?.error {
			self.error = previousError
			return
		}
	}
}

let operationA = OperationA()
let operationB = OperationB()
operationA.addDependency(operationB)


final class OperationC: Operation, OperationErrorable {
	var error: Error?
}

final class OperationD: Operation, OperationErrorable {
	private let _operationErrorable: OperationErrorable?

	var error: Error?

	init(operationErrorable: OperationErrorable? = nil) {
		_operationErrorable = operationErrorable
	}

	override func start() {
		super.start()

		if let error = _operationErrorable?.error {
			// Logic
		}
	}
}

let operationC = OperationC()
let operationD = OperationD(operationErrorable: operationC)

