"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.StackNode = exports.StackLinkedList = void 0;
class StackNode {
    constructor(value) {
        this.value = value;
        this.next = null;
    }
}
exports.StackNode = StackNode;
class StackLinkedList {
    constructor() {
        this.size = 0;
        this.top = null;
        this.size = 0;
    }
    push(value) {
        const newNode = new StackNode(value);
        newNode.next = this.top;
        this.top = newNode;
        this.size++;
    }
    pop() {
        if (this.isEmpty())
            return;
        this.top = this.top.next;
        this.size--;
    }
    peekTop() {
        if (this.isEmpty())
            return null;
        return this.top.value;
    }
    isEmpty() {
        return !this.size;
    }
    clear() {
        this.top = null;
        this.size = 0;
    }
}
exports.StackLinkedList = StackLinkedList;
const stackLinkedList = new StackLinkedList();
stackLinkedList.push(10);
stackLinkedList.push(20);
stackLinkedList.push(30);
console.log(stackLinkedList.peekTop()); // 30
stackLinkedList.pop();
console.log(stackLinkedList.peekTop()); // 20
console.log(stackLinkedList.isEmpty()); // false
stackLinkedList.clear();
console.log(stackLinkedList.isEmpty()); // true
//# sourceMappingURL=stack-linked-list.js.map