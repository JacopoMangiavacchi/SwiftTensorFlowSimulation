import Foundation

//protocol GraphNodeProtocol {
//    associatedtype T
//
//    var result: T { get set }
//    var edges: [Self] { get set }
//
//    mutating func add(edge: inout Self, undirected: Bool)
//    mutating func run() -> T
//}
//
//extension GraphNodeProtocol {
//    mutating func add(edge: inout Self, undirected: Bool = false) {
//        edges.append(edge)
//        if undirected {
//            edge.edges.append(self)
//        }
//    }
//}
//
//final class Constant<V> : GraphNodeProtocol {
//    typealias T = V
//
//    var result: V  //    private(set) var result: T
//    var edges: [GraphNodeProtocol]
//
//    init(_ value: T) {
//        self.result = value
//        edges = [GraphNodeProtocol]()
//    }
//
//    func run() -> V {
//        return result
//    }
//}


class Node {
    fileprivate(set) var result: Float?
    fileprivate(set) var edges: [Node]
    
    init(_ value: Float? = nil) {
        edges = [Node]()
        self.result = value
    }
    
    func add(edge: inout Node, undirected: Bool = false) {
        edges.append(edge)
        if undirected {
            edge.edges.append(self)
        }
    }
    
    func run() -> Float? {
        return result
    }
}

class TwoOperandNode : Node {
    init(_ node1: Node, _ node2: Node) {
        super.init()
        self.edges.append(node1)
        self.edges.append(node2)
    }
}

final class Constant : Node {
}


final class Add : TwoOperandNode {
    override func run() -> Float? {
        guard self.edges.count == 2 else { return nil }
        return self.edges[0].run()! + self.edges[1].run()!
    }
}

final class Subtract : TwoOperandNode {
    override func run() -> Float? {
        guard self.edges.count == 2 else { return nil }
        return self.edges[0].run()! - self.edges[1].run()!
    }
}

final class Multiply : TwoOperandNode {
    override func run() -> Float? {
        guard self.edges.count == 2 else { return nil }
        return self.edges[0].run()! * self.edges[1].run()!
    }
}

final class Divide : TwoOperandNode {
    override func run() -> Float? {
        guard self.edges.count == 2 else { return nil }
        return self.edges[0].run()! / self.edges[1].run()!
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

//sess = tf.Session()
//outs = sess.run(f)
//sess.close()

tf.run(f)


/// ++ NumPy

/// with Swift Python already available


