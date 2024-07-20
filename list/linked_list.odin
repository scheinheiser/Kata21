package main

import "core:fmt"

Node :: struct {
	value : string,
	child_node : ^Node,
}

new_list:: proc(head_value : string) -> Node {
	return Node{value = head_value, child_node = nil}
}

add :: proc(head : ^Node, data : string) {
    iter := head

    for iter.child_node != nil {
        iter = iter.child_node
    }

    iter.child_node = new(Node)
    iter.child_node.value = data
}

find :: proc(head : ^Node, target : string) -> Node {
	iter := head

	for true {
		iter = iter.child_node

		if iter == nil {
			fmt.eprint("The value doesn't exist.")
			return Node{}
		}
		else if iter.value == target {
			break
		}
	}

	return iter^
}

find_all :: proc(head : ^Node) -> (values : [dynamic]string) {
	iter := head
	append(&values, iter.value)

	for iter.child_node != nil {
		iter = iter.child_node

		if iter.value == "" {
			break
		}

		append(&values, iter.value)
	}

	return values
}

delete :: proc(head : ^Node, target : string) {
	iter := head

	for true {
		iter = iter.child_node

		if iter == nil {
			fmt.eprint("The value doesn't exist.")
			return
		}
		else if iter.value == target {
			break
		}
	}

	free(iter)
	fmt.println("Successfully deleted.")
}

main :: proc() {
	test_head := new_list("head")

	add(&test_head, "fred")
	add(&test_head, "wilma")
	add(&test_head, "betty")
	add(&test_head, "barney")

	fmt.println(find_all(&test_head))
	fmt.println(find(&test_head, "betty"))
	delete(&test_head, "barney")
	fmt.println(find_all(&test_head))
}
