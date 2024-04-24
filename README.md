# Implementation of a doubly linked list in godot 4
To use the list place the doubly_linked_list.gd script in the project file system. Usage example:

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
## How to copy the list?
### Shallow copy
```python
var list : List2 = List2.new([{"1": 1, "2": 2}, 4, 5, 7, 2, 100, 1])
var new_list1 : List2 = list # makes a shallow copy of the list

list.pop_back()

var v = new_list1.front()

v["1"] = "lorem ipsum"
new_list1.set_back(false)
new_list1.find(5).set_value("str")

var it : List2.List2Iterator = list.begin()

while it.is_valid():
	print(it.value())  # output: { "1": "lorem ipsum", "2": 2 } 4 str 7 2 false
	it.next()
```
### Deep copy
```python
var list : List2 = List2.new([{"1": 1, "2": 2}, 4, 5, 7, 2, 100, 1])
var new_list1 : List2 = list.dcopy()

new_list1.pop_back()

var v = new_list1.front()

v["1"] = "lorem ipsum"
new_list1.set_back(false)
new_list1.find(5).set_value("str")

var it1 : List2.List2Iterator = list.begin()

while it1.is_valid():
	print(it1.value()) # output: { "1": 1, "2": 2 } 4 5 7 2 100 1
	it1.next()
```

## Documentation for the List2 class
### Constructor

- `_init(elems : Array = []) -> void` Initializes a new instance of the List2 class. If an array is passed, the list is initialized with the elements of the array.

### Methods

- `begin() -> List2Iterator` Returns an iterator that points to the first element in the list.
- `end() -> List2Iterator` Returns an iterator that points to the last element in the list.
- `push_back(val) -> void` Adds a value to the end of the list.
- `push_front(val) -> void` Adds a value to the beginning of the list.
- `pop_front() -> void` Deletes the first element in the list.
- `pop_back() -> void` Deletes the last element in the list.
- `front() -> Variant` Returns the first element in the list. If the list is empty, it returns null.
- `set_front(val : Variant) -> void` Set the first element of the list with 'val'.
- `back() -> Variant` Returns the last element in the list. If the list is empty, it returns null.
- `set_back(val : Variant) -> void` Set the last element of the list with 'val'.
- `empty() -> bool` Returns true if the list is empty, false otherwise.
- `size() -> int` Returns the total number of elements in the list.
- `find(val : Variant) -> List2Iterator` Returns the iterator pointing to the first occurrence of 'val'. If 'val' is not found, it returns null. (scrolls through the list from beginning to end until it finds the item)
- `rfind(val : Variant) -> List2Iterator` Returns the iterator pointing to the last occurrence of 'val'. If 'val' is not found, it returns null. (scrolls the list from the end to the beginning until it finds the item)
- `dcopy(inner : bool = false, flags : Node.DuplicateFlags = 15) -> List2` Returns a deep copy of the list. If 'inner' is true, inner Dictionary and Array keys and values are also copied, recursively. In the case where there is an element within the list that inherits from Node you can specify by which mode to duplicate the element, for more details see: https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-duplicate

## Documentation for the List2.List2Iterator class
### Methods
- `next() -> void` Moves the iterator to the next element in the list.
- `prev() -> void` Moves the iterator to the previous element in the list.
- `value() -> Variant` Returns the value of the element the iterator is pointing to.
- `is_valid() -> bool` Returns true if the iterator is valid, false otherwise.
- `set_value(val : Variant) -> void` Sets the list element currently pointed to by the iterator.
- `remove() -> void` Removes the element pointed to by the iterator from the list.
- `insert(val : Variant) -> void` Insert the new element where the iterator points, at the end of the insertion the iterator will point to the inserted element.