function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m

X1=[ones(m,1) X];
fprintf('X dimension is %d  %d \n',size(X,1), size(X,2));
fprintf('X dimension is %d  %d \n',size(X1,1), size(X1,2));
% fprintf('X dimension is %d  %d \n',size(Theta1,1), size(Theta1,2));
% fprintf('X dimension is %d  %d \n',size(Theta2,1), size(Theta2,2));


for i = 1:m
   output_vector=sigmoid(Theta2*[1 ; sigmoid(Theta1*X1(i,:)')]);
   vectorized_y=zeros(num_labels,1);
   vectorized_y(y(i))=1;
   J=J+( -1*vectorized_y'*log(output_vector)+(-1)*(1-vectorized_y)'*log(1-output_vector));
end
J=J/m;
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%

summation=0;
theta1=Theta1;
theta1(:,1)=[];
theta1=theta1.^2;
summation=sum(sum(theta1));

theta2=Theta2;
theta2(:,1)=[];
theta2=theta2.^2;
summation=summation+sum(sum(theta2));
J=J+lambda/(2*m)*summation;

for i =1:m
    z2=Theta1*X1(i,:)';
    a2=[1; sigmoid(z2)];
    z3=Theta2*a2;
    a3=sigmoid(z3);
    vectorized_y=zeros(num_labels,1);
    vectorized_y(y(i))=1;
    delta3=(a3-vectorized_y);
    delta2=Theta2'*delta3;
    delta2=delta2(2:end,1).*sigmoidGradient(z2);
    
    Theta2_grad = Theta2_grad+delta3*a2';
    Theta1_grad = Theta1_grad+delta2*X1(i,:);
end

Theta2_grad=Theta2_grad/m;
Theta1_grad=Theta1_grad/m;

% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% -------------------------------------------------------------

% =========================================================================

captheta1=Theta1;
captheta1(:,1)=[];
captheta1=[zeros(size(Theta1,1),1) captheta1*lambda/m];
Theta1_grad=Theta1_grad+captheta1;

captheta2=Theta2;
captheta2(:,1)=[];
captheta2=[zeros(size(Theta2,1),1) captheta2*lambda/m];
Theta2_grad=Theta2_grad+captheta2;


% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
