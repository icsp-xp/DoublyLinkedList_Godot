# Implementation of a doubly linked list in godot 4

Usage example

```python
# creates a list by initializing it with 1, 2, 3, 4, 5, 6, 7, 8, 9
var list : List2 = List2.new([1, 2, 3, 4, 5, 6, 7, 8, 9])

print(list.back()) # output: 9
list.pop_back()
print(list.back()) # output: 8

# createas an empty list
var list2 : List2 = List2.new()

list2.push_back(false)
print(list2.front()) # output: false
list2.push_front("pizza")
print(list2.front()) # output: pizza
```

## How to iterate the list?
To scroll the list from the first element to the last element you must create an iterator that points to the first element in the list using the `begin()` method. To scroll the list from the last element to the first element you must create an iterator that points to the last element of the list using the `end()` method. 
For example:
```python
var list : List2 = List2.new([1, "str", true, Vector2.ZERO])

# creates an iterator that points to the first element in the list (in this case 1)
var it : List2.List2Iterator = list.begin()

# it is important to check if the iterator is valid before using it
while it.is_valid(): 
	print(it.value()) # output: 1 str true (0, 0)
	it.next()
	
# creates an iterator that points to the last element in the list (in this case Vector2.ZERO)
var it2 : List2.List2Iterator = list.end()
while it2.is_valid():
	print(it2.value()) # output: (0, 0) true str 1
	it2.prev()
```

## Constructor

`_init(elems : Array = []) -> void` Initializes a new instance of the List2 class. If an array is passed, the list is initialized with the elements of the array.

## Methods

- `begin() -> List2Iterator` Returns an iterator that points to the first element in the list.
- `end() -> List2Iterator` Returns an iterator that points to the last element in the list.
- `push_back(val) -> void` Adds a value to the end of the list.
- `push_front(val) -> void` Adds a value to the beginning of the list.
- `pop_front() -> void` Deletes the first element in the list.
- `pop_back() -> void` Deletes the last element in the list.
- `front() -> Variant` Returns the first element in the list. If the list is empty, it returns null.
- `back() -> Variant` Returns the last element in the list. If the list is empty, it returns null.
- `empty() -> bool` Returns true if the list is empty, false otherwise.
- `size() -> int` Returns the total number of elements in the list.
- `remove(it : List2Iterator) -> void` Removes the element pointed to by the iterator from the list.
- `find(val : Variant) -> List2Iterator` Returns the iterator pointing to the first occurrence of ‘val’. If ‘val’ is not found, it returns null.
- `rfind(val : Variant) -> List2Iterator` Returns the iterator pointing to the last occurrence of ‘val’. If ‘val’ is not found, it returns null.
