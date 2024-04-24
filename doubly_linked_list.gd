## implementation of a doubly linked list
class_name List2
extends RefCounted


class Elem extends RefCounted:
	var _previous_elem : Elem
	var _next_elem : Elem
	var _value : Variant
	
	
	func _init(__value : Variant) -> void:
		_previous_elem = null
		_next_elem = null
		_value = __value
	
	
	func get_value() -> Variant:
		return _value
	
	
	func set_value(val : Variant) -> void:
		_value = val
	
	
	func get_previous_elem() -> Elem:
		return _previous_elem
	
	
	func set_previous_elem(elem : Elem) -> void:
		_previous_elem = elem
	
	
	func get_next_elem() -> Elem:
		return _next_elem
	
	
	func set_next_elem(elem : Elem) -> void:
		_next_elem = elem



# ----------------------------------------------------------------------------

## implementation of iterator for List2
class List2Iterator extends RefCounted:
	const ERROR_ITERATOR_INVALID : String = "Invalid List2Iterator"
	
	var _curr : Elem
	
	
	func _init(__curr : Elem) -> void:
		_curr = __curr
	
	
	## moves the iterator to the next element in the list
	func next() -> void:
		assert(is_valid(), ERROR_ITERATOR_INVALID)
		_curr = _curr.get_next_elem()
	
	
	## moves the iterator to the previous element in the list
	func prev() -> void:
		assert(is_valid(), ERROR_ITERATOR_INVALID)
		_curr = _curr.get_previous_elem()
	
	
	## returns the value of the element the iterator is pointing to
	func value() -> Variant:
		assert(is_valid(), ERROR_ITERATOR_INVALID)
		return _curr.get_value()
	
	
	## sets the list element currently pointed to by the iterator
	func set_value(val : Variant) -> void:
		assert(is_valid(), ERROR_ITERATOR_INVALID)
		_curr.set_value(val)
	
	
	## returns true if the iterator is valid, false otherwise
	func is_valid() -> bool:
		return _curr != null
	
	
	# returns the element pointed to by the iterator
	func _get_curr() -> Elem:
		assert(is_valid(), ERROR_ITERATOR_INVALID) # the returned iterator must be valid
		return _curr
	
	
	# sets the element pointed to by the iterator
	func _set_curr(__curr : Elem) -> void:
		_curr = __curr
		assert(is_valid(), ERROR_ITERATOR_INVALID) # the returned iterator must be valid



# ----------------------------------------------------------------------------

const ERROR_IS_EMPTY : String = "the list is empty"

var _first : Elem
var _last : Elem
var _size : int


func _init(elems : Array = []) -> void:
	_first = null
	_last = null
	_size = 0
	
	for val in elems:
		push_back(val)


## returns an iterator that points to the first element in the list
func begin() -> List2Iterator:
	assert(_first != null, "iterator cannot be created because the first element is null")
	return List2Iterator.new(_first)


## returns an iterator that points to the last element in the list
func end() -> List2Iterator:
	assert(_last != null, "iterator cannot be created because the last element is null")
	return List2Iterator.new(_last)


## adds 'val' to the end of the list
func push_back(val) -> void:
	var elem : Elem = Elem.new(val)
	
	if empty():
		_last = elem
		_first = _last
	else:
		_last.set_next_elem(elem)
		elem.set_previous_elem(_last)
		_last = elem
	
	_size += 1


## adds 'val' to the beginning of the list
func push_front(val) -> void:
	var elem : Elem = Elem.new(val)
	
	if empty():
		_first = elem
		_last = _first
	else:
		_first.set_previous_elem(elem)
		elem.set_next_elem(_first)
		_first = elem
	
	_size += 1


## deletes the first element in the list
func pop_front() -> void:
	assert(not empty(), ERROR_IS_EMPTY)
	
	var tmp : Elem = _first
	
	if _last == _first:
		_last = null
		_first = null
	else:
		_first.get_next_elem().set_previous_elem(null)
		_first = _first.get_next_elem()
		tmp.set_next_elem(null)
		
	while tmp.get_reference_count() > 0:
		tmp.unreference()
	
	_size -= 1


## deletes the last element in the list
func pop_back() -> void:
	assert(not empty(), ERROR_IS_EMPTY)
	
	var tmp : Elem = _last
	
	if _last == _first:
		_last = null
		_first = null
	else:
		_last.get_previous_elem().set_next_elem(null)
		_last = _last.get_previous_elem()
		tmp.set_previous_elem(null)
		
	while tmp.get_reference_count() > 0:
		tmp.unreference()
	
	_size -= 1


## set the first element of the list with 'val'
func set_front(val : Variant) -> void:
	assert(_first != null, "iterator cannot be created because the first element is null")
	_first.set_value(val)


## returns the first element in the list
func front() -> Variant:
	return _first.get_value() if not empty() else null


## set the last element of the list with 'val'
func set_back(val : Variant) -> void:
	assert(_last != null, "iterator cannot be created because the last element is null")
	_last.set_value(val)


## returns the last element in the list
func back() -> Variant:
	return _last.get_value() if not empty() else null


## returns true if the list is empty false otherwise
func empty() -> bool:
	return _size == 0


## returns the number of total elements
func size() -> int:
	return _size


## removes the pointed element from the iterator
func remove(it : List2Iterator) -> void:
	assert(not empty(), ERROR_IS_EMPTY)
	
	var curr : Elem = it._get_curr()
	
	if curr == _first:
		pop_front()
		it._set_curr(_first)
	elif curr == _last:
		pop_back()
		it._set_curr(_last)
	else:
		curr.get_previous_elem().set_next_elem(curr.get_next_elem())
		curr.get_next_elem().set_previous_elem(curr.get_previous_elem())
		it._set_curr(curr.get_next_elem())
		curr.free()


## returns the iterator pointing to the first occurrence of 'val'. 
## If 'val' is not found it returns null
func find(val : Variant) -> List2Iterator:
	var it : List2Iterator = self.begin()
	
	while it.is_valid():
		var value : Variant = it.value()
		
		if typeof(value) == typeof(val) and value == val:
			return it
			
		it.next()
	
	return null


## returns the iterator pointing to the last occurrence of 'val'. 
## If 'val' is not found it returns null
func rfind(val : Variant) -> List2Iterator:
	var it : List2Iterator = self.end()
	
	while it.is_valid():
		var value : Variant = it.value()
		
		if typeof(value) == typeof(val) and value == val:
			return it
			
		it.prev()
	
	return null


## returns a deep copy of the list. If 'inner' is true, inner Dictionary and 
## Array keys and values are also copied, recursively. In the case where there  
## is an element within the list that inherits from Node you can specify by 
## which mode to duplicate the element, for more details see:
## https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-duplicate
func dcopy(inner : bool = false, flags : Node.DuplicateFlags = 15) -> List2:
	var value : Variant = null
	var new_list : List2 = List2.new()
	var it : List2Iterator = self.begin()
	
	while it.is_valid():
		value = it.value()
		
		if value is Object and value is Node and value.has_method("duplicate"):
			value = value.duplicate(flags)
		else:
			match typeof(value):
				TYPE_DICTIONARY:
					value = value.duplicate(inner)
				TYPE_ARRAY:
					value = value.duplicate(inner)
				TYPE_PACKED_BYTE_ARRAY:
					value = value.duplicate()
				TYPE_PACKED_INT32_ARRAY:
					value = value.duplicate()
				TYPE_PACKED_INT64_ARRAY:
					value = value.duplicate()
				TYPE_PACKED_FLOAT32_ARRAY:
					value = value.duplicate()
				TYPE_PACKED_FLOAT64_ARRAY:
					value = value.duplicate()
				TYPE_PACKED_STRING_ARRAY:
					value = value.duplicate()
				TYPE_PACKED_VECTOR2_ARRAY:
					value = value.duplicate()
				TYPE_PACKED_VECTOR3_ARRAY:
					value = value.duplicate()
				TYPE_PACKED_COLOR_ARRAY:
					value = value.duplicate()
					
		new_list.push_back(value)
		it.next()
	
	return new_list
