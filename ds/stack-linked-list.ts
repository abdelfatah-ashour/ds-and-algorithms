class StackNode<T> {
  value: T;
  next: StackNode<T> | null;

  constructor(value: T) {
    this.value = value;
    this.next = null;
  }
}

class StackLinkedList<T> {
  top: StackNode<T> | null;
  size: number = 0;

  constructor() {
    this.top = null;
    this.size = 0;
  }

  push(value: T): void {
    const newNode = new StackNode<T>(value);
    newNode.next = this.top;
    this.top = newNode;
    this.size++;
  }

  pop(): void {
    if (this.isEmpty()) return;
    this.top = this.top!.next;
    this.size--;
  }

  peekTop(): T | null {
    if (this.isEmpty()) return null;
    return this.top!.value;
  }

  isEmpty(): boolean {
    return !this.size;
  }

  clear(): void {
    this.top = null;
    this.size = 0;
  }
}

const stackLinkedList = new StackLinkedList<number>();
stackLinkedList.push(10);
stackLinkedList.push(20);
stackLinkedList.push(30);
console.log(stackLinkedList.peekTop()); // 30
stackLinkedList.pop();
console.log(stackLinkedList.peekTop()); // 20
console.log(stackLinkedList.isEmpty()); // false
stackLinkedList.clear();
console.log(stackLinkedList.isEmpty()); // true
export { StackLinkedList, StackNode };
