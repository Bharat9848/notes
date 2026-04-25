----
# Activation Functions
## Rectified Linear Unit(ReLU)
 - Pass the vector components as 1 only if they are positive. And send 0 for negative components.
 - function : `ReLU(x) = max(0,x)` where x is component

## Softmax
 - return the probability of different possible outcomes.
 - `softmax(x) = exp(x)/sumAll(i= 1 to V) exp(xi)` where x is the component of vector of size V. 


# Loss function
1. Cross Entropy Loss Function:
 - usually get used in classification model.
 - log loss function in logistic regression is also a type of cross entropy fn.
 - `J = - sumAll((i=1 to V)(yi * log(Predyi)))` where y is the expected output vector of size V and predy is the predicted output from the model. 