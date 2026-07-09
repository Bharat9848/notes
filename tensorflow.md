# Tensorflow
## Variable
1. tf.Variable(initialValue, dtype = tf.float32)
## Optimizer
 - tf.keras.optimizers.Adam(learning_rate)
 - `optimizer.apply_gradient(grad, trainable_variables)` 
 - `optimizer.minimize(cost_function, training_variable_list)` runs the one cycle of gradient descent
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