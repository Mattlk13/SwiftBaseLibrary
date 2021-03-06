﻿public postfix func !! <T> (b: T?) -> T {
	if let x = b {
		return x
	}
	#if JAVA
	__throw NullPointerException("Cannot force-unwrap reference")
	#elseif CLR || ISLAND
	__throw NullReferenceException("Cannot force-unwrap reference")
	#elseif COCOA
	__throw NSException(name: "Cannot force-unwrap reference", reason: "Cannot force-unwrap reference", userInfo: nil)
	#endif
}

//
//
// CAUTION: Magic function name.
// The compiler will use UnwrapOrDie<T> to provide the `!!` Unwrap-or-die operator (SE-0217)
//
//

public func UnwrapOrDie<T>(_ val: T?, _ error: NativeString) -> T {
	if let val = val {
		return val
	}
	throw Exception(error)
}