import Foundation
import numsw

class Node {
    var tf: TensorFlow?
    var edges: [Node]

    init(tf: TensorFlow? = nil) {
        self.tf = tf
        self.edges = [Node]()
    }

    func run() ->  NDArray<Float>? {
        return nil
    }

    static func +(left: Node, right: Node) -> Node {
        let x = Add(left, right)
        left.tf?.nodes.append(x)
        return x
    }

    static func -(left: Node, right: Node) -> Node {
        let x = Subtract(left, right)
        left.tf?.nodes.append(x)
        return x
    }

    static func *(left: Node, right: Node) -> Node {
        let x = Multiply(left, right)
        left.tf?.nodes.append(x)
        return x
    }

    static func /(left: Node, right: Node) -> Node {
        let x = Divide(left, right)
        left.tf?.nodes.append(x)
        return x
    }
}

class Constant : Node {
    var result:  NDArray<Float>?

    init(_ value:  NDArray<Float>, tf: TensorFlow? = nil) {
        self.result = value
        super.init(tf: tf)
    }

    override func run() ->  NDArray<Float>? {
        return result
    }
}

class TwoOperandNode : Node {
    var result:  NDArray<Float>?

    init(_ node1: Node, _ node2: Node, tf: TensorFlow? = nil) {
        super.init(tf: tf)
        self.edges.append(node1)
        self.edges.append(node2)
    }
}

class Add : TwoOperandNode {
    override func run() ->  NDArray<Float>? {
        guard self.edges.count == 2, let a = self.edges[0].run(), let b = self.edges[1].run() else { return nil }
        return a + b
    }
}

class Subtract : TwoOperandNode {
    override func run() ->  NDArray<Float>? {
        guard self.edges.count == 2, let a = self.edges[0].run(), let b = self.edges[1].run() else { return nil }
        return a - b
    }
}

class Multiply : TwoOperandNode {
    override func run() ->  NDArray<Float>? {
        guard self.edges.count == 2, let a = self.edges[0].run(), let b = self.edges[1].run() else { return nil }
        return a * b
    }
}

class Divide : TwoOperandNode {
    override func run() ->  NDArray<Float>? {
        guard self.edges.count == 2, let a = self.edges[0].run(), let b = self.edges[1].run() else { return nil }
        return a / b
    }
}


class TensorFlow {
    var nodes = [Node]()

    func constant(_ v:  NDArray<Float>) -> Node {
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

    func run(_ n: Node) ->  NDArray<Float>? {
        return n.run()
    }
}

var tf = TensorFlow()

let a = tf.constant(NDArray<Float>(shape: [3], elements: [5, 7, 10]))
let b = tf.constant(NDArray<Float>(shape: [3], elements: [2, 3, 21]))
let c = tf.constant(NDArray<Float>(shape: [3], elements: [3, 5, 7]))

//var d = tf.multiply(a,b)
//var e = tf.add(c,b)
//var f = tf.subtract(d,e)

var d = a * b
var e = c + b
var f = d - e

print("result: \(tf.run(f)!)") 

