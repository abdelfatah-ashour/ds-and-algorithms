"use strict";
class Stack {
    constructor() {
        this.list = [];
        this.top = -1;
    }
    push(value) {
        this.list[this.top + 1] = value;
        this.top++;
    }
    pop() {
        this.top--;
    }
    peekTop() {
        if (this.isEmpty())
            return;
        return this.list[this.top];
    }
    isEmpty() {
        return this.top === -1;
    }
    clear() {
        this.list = [];
        this.top = -1;
    }
}
const stack = new Stack();
stack.isEmpty();
stack.push(1);
stack.push(2);
stack.pop();
stack.peekTop();
stack.push(3);
stack.peekTop();
//# sourceMappingURL=stack.js.map