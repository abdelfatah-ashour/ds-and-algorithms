declare class StackNode<T> {
    value: T;
    next: StackNode<T> | null;
    constructor(value: T);
}
declare class StackLinkedList<T> {
    top: StackNode<T> | null;
    size: number;
    constructor();
    push(value: T): void;
    pop(): void;
    peekTop(): T | null;
    isEmpty(): boolean;
    clear(): void;
}
export { StackLinkedList, StackNode };
//# sourceMappingURL=stack-linked-list.d.ts.map