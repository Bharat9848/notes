# Neural Network
 - Neuron: is a linear function of (noOfInput, 1) then its output goes through a activation function.
 - Weights can't be initialized to zero and it should be initialized to very low random number of normal distribution. Also Weights should be initialized using **Xavier initialization** which scale the weight matrix of layer l by `sqrt(1/dimension of previous layer)`. Or you can use **he initialization** from paper (He et. al 2015) which scale the weight matrix of layer l by `sqrt(2/dimension of previous layer)`
 - Input layer: Each neuron take input from all the features of input.
 - hidden layers:
    1. Dense layer
    2. ReLU layer
    3. Or Dense layer with ReLU activation
  - Embedding layer: each word is translated into n dimension which represent its hidden meaning.
  - Mean layer: followed by embedding layer it takes mean of each embedding dimension to reduce the size of embedding layer. 
 - Debugging - Gradient Checking Technique
---
# Variance
## Regularization
 - **L2 regularization**: 
  - In neural networks,cost function have an additional term of `(lamdba/2m)*forallLayer(forbNorm(W))`. It also affect the `dW` in back propagation, it adds `(lambda/m)*Wi`. because of it is called weighted decay.
  - High lambda hyperparameter causes the weights to go smaller and make the neural network go linear across layer which makes it less fitting to the data. Hence increase the effect of regularization. Intution: L2-regularization relies on the assumption that a model with small weights is simpler than a model with large weights. Thus, by penalizing the square values of the weights in the cost function you drive all the weights to smaller values. It becomes too costly for the cost to have large weights! This leads to a smoother model in which the output changes more slowly as the input changes.

- **Dropout regularization**: 
   - We do coin toss for a unit to turn on/off for at each unit in hidden layers for each example.
   - used only in training time not in testing time. 
   - Implementation notes: 
    - For forward propagation, We create a coin toss boolean matrix of ASup(l) size and matrix multiply it with original ASup(l) matrix for each layer(l), we want to apply dropout technique. Then Divide 𝐴[1] by keep_prob. By doing this you are assuring that the result of the cost will still have the same expected value as without drop-out. (This technique is also called inverted dropout.)
    - For backward propagation, You had previously shut down some neurons during forward propagation, by applying a mask 𝐷[1] to A1. In backpropagation, you will have to shut down the same neurons, by reapplying the same mask 𝐷[1] to dA1.During forward propagation, you had divided A1 by keep_prob. In backpropagation, you'll therefore have to divide dA1 by keep_prob again (the calculus interpretation is that if 𝐴[1] is scaled by keep_prob, then its derivative 𝑑𝐴[1] is also scaled by the same keep_prob).

- Data Augmentation:
  - Image rotation/zoom in increase data size.
- Early Stopping
 - If you plot cost vs iteration, observe with more iteration training error will go towards zero. But validation set error might not follow the same trend. Validation set errors goes down till certain point and then start increasing again. Early stopping technique stops training at the point where cross-validation set error at minimum. 
---
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
-----
# Problems
 - Exploding Gradient Descent: In a very deep neural network, if weight are greater than identity matrix then over large number of layers weight increased exponentially due to recurrence which in turn increase in Yhat. It cause difficulty in training.
 - Vanishing Gradient Descent: It is opposite to exploding gradient descent. If weights are less than identity matrix then over large network small gradient shrink to zero due to recurrence which leads to long term memory loss.
 - Partial solution to Exploding/Vanishing gradient descent is by initializing the weights at each layer with variance of `2/nsup(l-1)` where nsub(l-1) is dimension of previous layer.
 `Wsup(L) = np.random.randn(nsup(L), nsup(L-1)) * np.sqrt(2/nsup(L-1))`

 - process each word sequentially
----- 
### Long Short-Term Memory(LSTM)
- Add more memory cell to tackle the long term memory loss
- process each word sequentially


## Convolution neural network
- Image data, or time series data

# NLP
 -- see elasticsearch notes


# Transfer Learning
- Use NN trained on one set of problem for problem for other set of problem. It make sense when both Task A and Task B have same input x. We have more dataset for task A than Task B. Low level features from A could be helpful for B as well.

1. Pretraining with finetuning: Pre-training on differnet set of data. Then do fine-tuning on different problem data. It will tune the all layer weights. 
2. Randomize the weight of new last layer and retune the weights
3. Have few extra last layers 

# Multitask Learning
- Tasks shares same low level features. 
- Tasks data is similar but some task have less data than the other.
- Single big NN to work on different tasks than have small NN each work on single task.

# End-to-End Deep Learning
- Remove all traditional ML pipelines use single end-to-end big NN.
- There is not much end-to-end data where end-to-end approach will not work. 
- It requires lot of data than having muliple subtask where each task requires different volume of data. 
- End-to-end NN may find different pattern to solve the data than dividing problem based on human understanding of the problem.