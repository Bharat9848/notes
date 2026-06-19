# Neural Network
 - Neuron: is a linear function of (noOfInput, 1) then its output goes through a activation function.
 - Weights can't be initialized to zero and it should be initialized to very low random number.  
 - Input layer: Each neuron take input from all the features of input.
 - hidden layers:
    1. Dense layer
    2. ReLU layer
    3. Or Dense layer with ReLU activation
  - Embedding layer: each word is translated into n dimension which represent its hidden meaning.
  - Mean layer: followed by embedding layer it takes mean of each embedding dimension to reduce the size of embedding layer. 

## Forward Propagation
 1. First input layer is also called the zero layer. `a(superscript[0]) = X`. It have dimensions of (features, examples) where each example represent column.
 2. For each hidden layer 
   - Weights for hidden layer of size (nInput, noOfNeuron)
  	-`z(superscript[i]) = W(superscript[i]) * a(superscript[i-1]) + b(superscript[i])` 
  	-`a(superscript[i]) = g(superscript[i])(z(sperscript[i])`
   (Notations: superscript with square bracket means layer number subscript without bracket are node number in the layer. Superscript with parenthesis bracket means the number assigned to sample from the training example and subsript means the feature number denoted to a particular sample)
 3. Output layer  
 
----
# Activation Functions
 - It is majorly chosen on how it will affect the training speed of the NN.
 
## Rectified Linear Unit(ReLU)
 - Pass the vector components as 1 only if they are positive. And send 0 for negative components.
 - function : `ReLU(z) = max(0,z)` where z is component. Derivative `d(g(z))/dz = 0 when z < 0 OR 1 when z >=0`
## Tanh 
 - `tanh(z) = (e(z) - e(-z))/ (e(z) + e(-z))` it is shifted version of sigmoid function. derivative `d(g(z)/dz = 1-(tanh(z))^2`
 - In hidden layers tanh function is preferred over sigmoid as it centered the data because of its range [-1, 1] as compare to sigmoid [0, 1]
## Sigmoid 
 - It is chosen to be activation unit of outer layer if the output should be in between [0, 1].
 - used in mapping of binary classification 
 - Formula `g(z)= 1/(1+e^(-z))` derivative `d(g(z))/dz = g(z)(1-g(z))`

## Leaky ReLU
- formula `a = max(0.01*z, z)` derivative `d(g(z))/dz = 0.01 when z < 0 OR 1 when z >= 0`
----

## Softmax
 - return the probability of different possible outcomes.
 - `softmax(x) = exp(x)/sumAll(i= 1 to V) exp(xi)` where x is the component of vector of size V. 


# Loss function
1. Cross Entropy Loss Function:
 - usually get used in classification model.
 - log loss function in logistic regression is also a type of cross entropy fn.
 - `J = - sumAll((i=1 to V)(yi * log(Predyi)))` where y is the expected output vector of size V and predy is the predicted output from the model. 

 ## Applied Neural Network
 1. Sentiment analysis
 	- input -> embedding layer -> hidden layer with RELU activation -> output layer with softmax
 	- Each word in a sentance is assigned a unique key from the vocabulary. Then tweet is sent to input layer with padding if number of words in tweet is less than input vector size.
    - multi tweets are represented using matrix to make the process faster.

## Recurrent neural network
- send information from begining to end.
- Weight is get updated recurrently.
- Architecture based on number of input to output.
1. One-to-one one input to one output.
2. one-to-many one input to many output.
3. Many-to-one Many input to single output.
4. Many-to-Many Many input to many output 

### problems
 - exploding gradient descent: large gredient exponentially increase due to recurrence
 - vanishing gradient descent: small gradient shrink to zero due to recurrence which leads to long term memory loss.
 - process each word sequentially
### Long Short-Term Memory(LSTM)
- Add more memory cell to tackle the long term memory loss
- process each word sequentially


## Convolution neural network
- Image data, or time series data

# NLP
 -- see elasticsearch notes
