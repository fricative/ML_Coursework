function g = sigmoid(z)
%SIGMOID Compute sigmoid functoon
%   J = SIGMOID(z) computes the sigmoid of z.

% You need to return the following variables correctly 
g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the sigmoid of each value of z (z can be a matrix,
%               vector or scalar).
z=z*-1;
i = size(z,1);
j = size(z,2);
if (i==1 && j==1)
   g = 1/(1+exp(z)); 
elseif j~=1
    disp(z);
   for iter = 1:i
       for iter1 = 1: j
          g(iter,iter1)=1/(1+exp(z(iter,iter1)));
       end
   end  
else
    i = size(z,1);
    for iter =1:i
        g(iter,1)=1/(1+exp(z(iter,1)));
    end
end


% =============================================================

end
