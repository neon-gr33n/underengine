//
//
///@description		check out ArrayClass.gml for docs

randomize();


function __Array_test() {
	show_debug_message("#### STARTING TESTS ####")
	
	
	// Creating
	var array = new Array(0)
	
	
	// Use these if you have fps issues due to garbage collection
	// v F1 or Middle Click v
	//gc_enable(false)
	//gc_collect()
	
	
	// Adding new stuff
	array.append(1, 2, 3)
	show_debug_message(array)
	
	
	// the most useful function
	show_debug_message("#### FOREACH ####")
	array.forEach(function(num, pos) {
		if num == 3 {
			show_debug_message(string(pos) + ") " + string(num) + " is for suckers")
			ARRAY_LOOP = false
			// break out of forEach()
		}
		
		if num % 2 == 0 {
			show_debug_message(string(pos) + ") " + string(num) + " (even)")
		}
		else {
			show_debug_message(string(pos) + ") " + string(num) + " (odd)")
		}
		
		
		// Please don't delete stuff inside .forEach(), use .filter() or .where() instead
	})
	show_debug_message(array)
	
	
	
	// Concatenating regular arrays
	show_debug_message("#### CONCAT ####")
	array.concat(["string", 1, -pi])
	show_debug_message(array)
	
	
	
	// Chaining methods
	show_debug_message("#### CHAINING METHODS ####")
	
	array = new Array(1, "string", pi)
	
	array = array.insert(0, "first")
				 .insert(1, "second")
				 .append("last", "last2")
	show_debug_message(array)
	
	
	
	// Careful: some methods don't return the array
	show_debug_message("#### CHAINING METHODS 2 ####")
	var m = array.clear()
				 //.concat(new Range(1, 4, 1))
				 //.concat(new Range(3, 1, -1))
				 .append(1, 2, 3, 4)
				 .append(3, 2, 1)
				 ._max()
	
	//.add(1) would throw an error, as it would apply .add() to a number
	show_debug_message(array)
	show_debug_message(m)
	
	
	
	
	// getting/setting
	show_debug_message("#### GET/SET ####")
	var first = array.get(0)
	var second = array.get(1)
	var last = array.get(array.size-1)
	show_debug_message(array)
	show_debug_message("First: "+string(first))
	show_debug_message("Second: "+string(second))
	show_debug_message("Last: "+string(last))

	array.set(0, "first")
	array.set(1, "second")
	array.set(array.size-1, "last")
	show_debug_message(array)
	
	
	
	// Modifying contents by hand
	show_debug_message("#### MANUAL MODIFYING ####")
	array.content = [4, 2, 1, 3, 8, 7, 6, 5]
	// Note that size will not automatically update this way
	array.size = 8
	show_debug_message(array)
	
	
	
	
	// Swap
	show_debug_message("#### SWAP ####")
	array.swap(0, array.size-1)
	show_debug_message(array)
	
	
	
	
	// Slice
	show_debug_message("#### SLICE ####")
	var array_slice = array.slice(0, 4)
	show_debug_message("Sliced 0-4. Result: "+string(array_slice))
	
	
	// Joining
	show_debug_message("#### PRINTING (JOINING) ####")
	show_debug_message(array.join("|"))
	
	
	// sorting (slow, don't do every frame)
	show_debug_message("#### SORTING ####")
	
	var t = new SpeedTimer();
	
	array.sort(function(a, b) {
		return a > b // Descending
	}, 0, 4) // from 0 to 3
	
	array.sort(function(a, b) {
		return a < b // Ascending
	}, 4) // from 4 to end
	
	show_debug_message(array)
	
	
	
	// .sorted() and .reversed(), as well as .filter() don't modify the original array
	show_debug_message("#### CLEAN FUNCTIONS ####")
	var myarray = array.sorted(SORT_ASCENDING, 0, array.size).reversed()
	show_debug_message(myarray)
	show_debug_message(array)
	
	
	
	
	// Useful to delete several elements based on some parameter
	show_debug_message("#### FILTER ####")
	array = array.filter(function(num) {
		return num % 2 == 0
	}).concat(array.copy()) // Repeat the array. Note how the copy still has the odd numbers
	show_debug_message(array)
	
	
	
	
	// find() / findAll()
	show_debug_message("#### SEARCHING ####")
	var idx = array.find(2)
	show_debug_message("First 2 is found at "+string(idx))
	
	var arr = array.findAll(2)
	// yep, you can string() arrays!
	show_debug_message("All 2's positions: " + string(arr))
	var num = array.number(2)
	show_debug_message("Total amount of 2's: " + string(num))
	
	var uniq = array.unique() // like array but without duplicates
	var num = uniq.number(2)
	show_debug_message(uniq)
	show_debug_message("Total amount of 2's: " + string(num))
	
	
	
	
	// adding up the whole array
	show_debug_message("#### ADDING UP ####")
	var sum = array.sum()
	show_debug_message(sum)
	
	// Strings are summable too
	array = array.clear().append("Hello", ", ", "World", "!")
	show_debug_message(array.sum())
	
	
	
	
	// shuffle!
	show_debug_message("#### SHUFFLING ####")
	array = new Array(1, 2, 3, 4, 5, 6, 7, 8) // array.clear().append() is the most stupid thing you could ever do...
	show_debug_message(array.shuffled())
	array.shuffle()
	show_debug_message(array)
	
	
	
	
	// iterators
	show_debug_message("#### ITERATORS (EXPERIMENTAL) ####")
	
	var iter = new Iterator(array)
	while !is_undefined(iter.next()) {
		var it = iter.get()
		show_debug_message("Current iteration: "+string(it))
	}
	
	
	// convertation
	show_debug_message("#### CONVERSION ####")
	
	var arr = ["Lowercase", "a"]
	var Arr = new Array("Uppercase", "A")
	
	var list = ds_list_create()
	ds_list_add(list, "ds", "list")
	
	
	var a_to_A = array_to_Array(arr)
	var a_to_l = array_to_ds_list(arr)
	var A_to_a = Array_to_array(Arr)
	var A_to_l = Array_to_ds_list(Arr)
	var l_to_a = ds_list_to_array(list)
	var l_to_A = ds_list_to_Array(list)
	
	show_debug_message("From regular array:")
	show_debug_message(a_to_A)
	show_debug_message(a_to_l)
	
	show_debug_message("From Array Class:")
	show_debug_message(A_to_a)
	show_debug_message(A_to_l)
	
	show_debug_message("From ds_list:")
	show_debug_message(l_to_a)
	show_debug_message(l_to_A)
	
	
	ds_list_destroy(a_to_l)
	ds_list_destroy(A_to_l)
	
	
	// DIFFERENT SORTING ALGORITHMS
	show_debug_message("#### SORTING ALGORITHMS ####")
    var t = new SpeedTimer();
    
	
	show_debug_message("randomly generated array:")
	// generate dataset
	var array = new RandomArray(20, 1000)
	if array.size <= 100
		show_debug_message(array)
	
	
	
	// radix sort
	show_debug_message("#### RADIX SORT ####");
	var arr = array.copy(); t.split(); // ignore array allocation time
	
	arr.radixSort(4); // 2875
	show_debug_message(arr);
	
	var time = string(t.split());
	show_debug_message("RadixSorted in: "+time);
	
	
	
	// merge sort
	show_debug_message("#### MERGESORT ####");
 	var arr = array.copy(); t.split(); // ignore array allocation time
	
	arr.mergeSort();
	show_debug_message(arr);
	
 	var time = string(t.split());
 	show_debug_message("MergeSorted in: "+time);
	show_debug_message("AS YOU CAN SEE, MERGE SORT DOESN'T WORK...");
	
	
	
	// bubble sort
	show_debug_message("#### BUBBLESORT ####");
	var arr = array.copy(); t.split(); // ignore array allocation time
	
	arr.sort();
	show_debug_message(arr);
	
	var time = string(t.split());
	show_debug_message("BubbleSorted in: "+time);
	
	
	
	// quick sort
	show_debug_message("#### QUICKSORT ####");
	var arr = array.copy(); t.split(); // ignore array allocation time
	
	arr.quickSort();
	
	var time = string(t.split());
	show_debug_message("QuickSorted in: "+time);
	
	show_debug_message(arr)
	
	
	//// bogosort (OMEGALUL)
 	//show_debug_message("#### BOGOSORT (OMG) ####");
	
 	//var arr = array.copy(); t.split();
	
	//arr.bogosort();
	
 	//var time = string(t.split());
 	//show_debug_message("BogoSorted in: "+time+"("+string(time / 1000000)+"s)");
}