﻿
#if COOPER
import java.util
#elseif ECHOES
import System.Collections.Generic
import System.Linq
#elseif NOUGAT
import Foundation
import RemObjects.Elements.Linq
#endif


#if NOUGAT
public class Array<T> /*: sequence of T mapped to Foundation.NSMutableArray where T is class*/ {
#elseif COOPER
public class Array<T> /*: mapped to java.util.ArrayList<T>*/ {
#elseif ECHOES
public class Array<T> /*: mapped to System.Collections.Generic.List<T>*/ {
#endif
	/*private
	method SetItem(&Index: Integer Value: T)
	method GetItem(&Index: Integer): T*/

	#if COOPER
	let mapped: java.util.ArrayList<T>!
	#elseif ECHOES
	let mapped: System.Collections.Generic.List<T>!
	#elseif NOUGAT
	let mapped: Foundation.NSMutableArray!
	#endif

	init() {
		//mapped to constructor()
	}
	
	init (items: Array<T>) { // [T]
	}
	
	init (array: T[]) { // Low-level arrays
	}
	
	#if COOPER
	//ToDo:
	#elseif ECHOES
	init (sequence: IEnumerable<T>) { // Sequence
	}
	#elseif NOUGAT
	init (sequence: Foundation.INSFastEnumeration<T>) { // Sequence
	}
	#endif

	/*init<S : SequenceType where T == T>(_ s: S) {
	}*/

	init(count: Int, repeatedValue: T) {
	}
	
	public var count: Int {
		#if COOPER
		return mapped.Size
		#elseif ECHOES
		return mapped.Count
		#elseif NOUGAT
		return mapped.count
		#endif
	}
	
	public var capacity: Int { 
		#if COOPER
		#elseif ECHOES
		return mapped.Capacity
		#elseif NOUGAT
		#endif
		return -1 // todo
	}

	public var isEmpty: Bool { 
		return count == 0 
	}

	public var first: T? { 
		if count > 0 {
			return mapped[0]
		}
		return nil
	}

	public var last: T? { 
		let c = count
		if c > 0 {
			return mapped[c-1]
		}
		return nil
	}

   /// Ensure the array has enough mutable contiguous storage to store
	/// minimumCapacity elements in.  Note: does not affect count.
	/// Complexity: O(N)
	public mutating func reserveCapacity(minimumCapacity: Int) {
	}

	/// Append newElement to the Array in O(1) (amortized)
	public mutating func append(newElement: T) {
	}

	/// Append elements from `sequence` to the Array
	/*public mutating func extend<S : SequenceType where T == T>(sequence: S) {
	}*/

	/// Remove an element from the end of the Array in O(1).
	/// Requires: count > 0
	public mutating func removeLast() -> T {
		let c = count
		if c > 0 {
			removeAtIndex(c-1)
		}		
	}

	/// Insert an element at index `i` in O(N).  Requires: `i` <=
	/// `count`
	public mutating func insert(newElement: T, atIndex i: Int) {
	}

	/// Remove the element at the given index.  Worst case complexity:
	/// O(N).  Requires: `index` < `count`
	public mutating func removeAtIndex(index: Int) -> T {
		#if COOPER
		mapped.remove(index)
		#elseif ECHOES
		mapped.RemoveAt(index)
		#elseif NOUGAT
		mapped.removeObjectAtIndex(index)
		#endif
	}

	/// Erase all the elements.  If `keepCapacity` is `true`, `capacity`
	/// will not change
	public /*mutating*/ func removeAll(keepCapacity: Bool = false /*default*/) {
		#if COOPER
		mapped.Clear()
		#elseif ECHOES
		mapped.Clear()
		#elseif NOUGAT
		mapped.RemoveAllObjects()
		#endif
	}

	/// Interpose `self` between each consecutive pair of `elements`,
	/// and concatenate the elements of the resulting sequence.  For
	/// example, `[-1, -2].join([[1, 2, 3], [4, 5, 6], [7, 8, 9]])`
	/// yields `[1, 2, 3, -1, -2, 4, 5, 6, -1, -2, 7, 8, 9]`
	/*public func join<S : SequenceType where [T] == [T]>(elements: S) -> [T] {
	}*/

	/// Return the result of repeatedly calling `combine` with an
	/// accumulated value initialized to `initial` and each element of
	/// `self`, in turn, i.e. return
	/// `combine(combine(...combine(combine(initial, self[0]),
	/// self[1]),...self[count-2]), self[count-1])`.
	public func reduce<U>(initial: U, combine: (U, T) -> U) -> U {
	}

	public mutating func sort(isOrderedBefore: (T, T) -> Bool) {
		#if COOPER
		//todo
		#elseif ECHOES
		//69820: Silver: can't call Sort() with block, on Echoes
		mapped.Sort({ (a: T, b: T) -> Boolean in // ToDo: check if this is the right order
			if isOrderedBefore(a,b) {
				return 1
			} else 
				return -1
			}
		})
		#elseif NOUGAT
		mapped.sortWithOptions(0, usingComparator: { a, b in // TODo: check if this is the right order
			if isOrderedBefore(a,b) {
				return NSOrderedAscending
			} else 
				return NSOrderedDescending
			}
		})
		#endif
	}

	public func sorted(isOrderedBefore: (T, T) -> Bool) -> Array<T> { // [T] {
		#if COOPER
		//todo
		#elseif ECHOES
		//69820: Silver: can't call Sort() with block, on Echoes
		var result = Array(items: self)
		result.Sort({ (a: T, b: T) -> Boolean in // ToDo: check if this is the right order
			if isOrderedBefore(a,b) {
				return 1
			} else 
				return -1
			}
		})
		return result
		#elseif NOUGAT
		mapped.sortedArrayWithOptions(0, usingComparator: { a, b in // TODo: check if this is the right order
			if isOrderedBefore(a,b) {
				return NSOrderedAscending
			} else 
				return NSOrderedDescending
			}
		})
		#endif
	}

	/// Return an Array containing the results of calling
	/// `transform(x)` on each element `x` of `self`
	public func map<U>(transform: (T) -> U) -> Array<U> { // [U] {
	}

	// consider nt implementing this,coz we have LINQ Reverse already
	public func reverse() -> Array<T> { // [T] {
		#if COOPER
		var result = Array(items: self)  
		Collections.reverse(result);
		#elseif ECHOES
		return mapped.Reverse.ToList()
		#elseif NOUGAT
		return Array(sequence: mapped.Reverse())
		#endif
	}

	/// Return an Array containing the elements `x` of `self` for which
	/// `includeElement(x)` is `true`
	public func filter(includeElement: (T) -> Bool) -> Array<T> { // [T] {
		return Array(sequence: self.Where(includeElement))
	}

	/// Construct a Array of `count` elements, each initialized to
	/// `repeatedValue`.
	
	/* Printable, DebugPrintable */
	
	/// Call body(p), where p is a pointer to the Array's contiguous storage
	/*func withUnsafeBufferPointer<R>(body: (UnsafeBufferPointer<T>) -> R) -> R {
	}
	
	mutating func withUnsafeMutableBufferPointer<R>(body: (inout UnsafeMutableBufferPointer<T>) -> R) -> R {
	}

	/// This function "seeds" the ArrayLiteralConvertible protocol
	static func convertFromHeapArray(base: Builtin.RawPointer, owner: Builtin.NativeObject, count: Builtin.Word) -> Array<T> { // [T] {
	}*/

	/*mutating func replaceRange<C : CollectionType where T == T>(subRange: Range<Int>, with newValues: C) {
	}
	mutating func splice<S : CollectionType where T == T>(s: S, atIndex i: Int) {
	}*/
	mutating func removeRange(subRange: Range<Int>) {
	}

	#if NOUGAT
	init(_fromCocoaArray source: _CocoaArrayType, noCopy: Bool = false/*default*/) {
	}
	#endif
	
}