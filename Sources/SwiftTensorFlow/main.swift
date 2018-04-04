import Foundation

public protocol Node {
    func run() -> Float?
}

open class Constant : Node {
    internal var result: Float?
    internal var edges: [Node]

    public init(_ value: Float) {
        self.edges = [Node]()
        self.result = value
    }

    public func run() -> Float? {
        return result
    }
}

open class TwoOperandNode : Node {
    internal var result: Float?
    internal var edges: [Node]

    init(_ node1: Node, _ node2: Node) {
        self.edges = [Node]()
        self.edges.append(node1)
        self.edges.append(node2)
    }
    
    public func run() -> Float? {
        return result
    }
}

open class Add : TwoOperandNode {
    public override func run() -> Float? {
        guard self.edges.count == 2, let a = self.edges[0].run(), let b = self.edges[1].run() else { return nil }
        return a + b
    }
}

open class Subtract : TwoOperandNode {
    public override func run() -> Float? {
        guard self.edges.count == 2, let a = self.edges[0].run(), let b = self.edges[1].run() else { return nil }
        return a - b
    }
}

open class Multiply : TwoOperandNode {
    public override func run() -> Float? {
        guard self.edges.count == 2, let a = self.edges[0].run(), let b = self.edges[1].run() else { return nil }
        return a * b
    }
}

open class Divide : TwoOperandNode {
    public override func run() -> Float? {
        guard self.edges.count == 2, let a = self.edges[0].run(), let b = self.edges[1].run() else { return nil }
        return a / b
    }
}


class TensorFlow {
    var nodes = [Node]()

    func constant(_ v: Float) -> Node {
        let x = Constant(v)
        nodes.append(x)
        return x
    }

    func add(_ n1: Node, _ n2: Node) -> Node {
        let x = Add(n1, n2)
        nodes.append(x)
        return x
    }

    func subtract(_ n1: Node, _ n2: Node) -> Node {
        let x = Subtract(n1, n2)
        nodes.append(x)
        return x
    }

    func multiply(_ n1: Node, _ n2: Node) -> Node {
        let x = Multiply(n1, n2)
        nodes.append(x)
        return x
    }

    func divide(_ n1: Node, _ n2: Node) -> Node {
        let x = Divide(n1, n2)
        nodes.append(x)
        return x
    }

    func run(_ n: Node) -> Float? {
        return n.run()
    }
}

var tf = TensorFlow()

let a = tf.constant(5)
let b = tf.constant(2)
let c = tf.constant(3)
var d = tf.multiply(a,b)
var e = tf.add(c,b)
var f = tf.subtract(d,e)

print("result: \(tf.run(f)!)") 
