# Swift TensorFlow Simulation

Use a Swift NumPy equivalent class (https://github.com/sonsongithub/numsw) and create a simulated TensorFlow Graph in Swift to demostrate how TensorFlow Graph building and deferred execution works with code like this:

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

  tf.run(f)



