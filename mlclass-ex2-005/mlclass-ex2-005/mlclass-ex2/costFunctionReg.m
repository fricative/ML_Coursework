function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples
n=length(theta);
% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));
grad1=zeros(size(grad));
grad2=lambda/m*theta;
grad2(1,1)=0;
% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
sum1 =0, sum2=0;

for i = 1:m
    sum1= sum1+(-y(i)*log(sigmoid(X(i,:)*theta))-(1-y(i))*log(1-sigmoid(X(i,:)*theta)));
    grad1(i)=sigmoid(X(i,:)*theta)-y(i); 
end
for j=2:n
    sum2 = sum2+ theta(j)*theta(j)
end
J = sum1/m+sum2*lambda/(2*m);
grad1 = X'*grad1
grad=grad2+grad1/m;
% =============================================================

end
