# Tensorflow
## Variable
1. tf.Variable(initialValue, dtype = tf.float32)
## Optimizer
 - tf.keras.optimizers.Adam(learning_rate)
 - `optimizer.apply_gradient(grad, trainable_variables)` 
 - `optimizer.minimize(cost_function, training_variable_list)` runs the one cycle of gradient descent
## Vectors 
 - `tf.Tensor` are generator by nature. We need to explicit iterate over it to inspect elements in a tensor
 - `TensorSliceDataset` have `element_spec` property which have shape and dtype information.

## Operations
 -  `tf.keras.initializers.GlorotNormal(seed=<>)` generate a random generator with mean 0 and some stddev
 - `tf.add()` for matrix add operation
 - `tf.linalg.matmul()` for matrix multiplication
## Activation
 - `tf.cast(, tf.float32)`
 - `tf.keras.activations.sigmoid()`
 - `tf.keras.activations.relu()`
## calculate gradient
 - ```python
    with tf.GradientTape() as tape:
    	cost = some equation
    trainable_variables = [var1, var2]	
    gradient = tape.gradient(tape, trainable_variables)
 	```
## Modules
 1. **tf.keras.Sequential**
 2. **tf.keras.layers.Embedding**
 3. **tf.keras.layers.GlobalAveragePolling1D**
 4. **tf.keras.layers.Dense**

## References
- [intro gradient](https://www.tensorflow.org/api_docs/python/tf/GradientTape)
- [Gradient tape](https://www.tensorflow.org/api_docs/python/tf/GradientTape)
- [logits](https://lucasdavid.github.io/blog/machine-learning/crossentropy-and-logits/)