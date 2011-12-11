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
%

a1 = [ones(m, 1) X];
z2=a1 *Theta1';
a2=sigmoid(z2); 
a2 = [ones(size(a2,1),1) a2];
z3=a2 * Theta2'; 
h=sigmoid(z3); 

yy=eye(num_labels)(y,:);

left = -1*yy.*log(h);
right = (1-yy).*log(1-h);

J = (1.0/m)*sum(sum(left - right));

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

Delt1=zeros(size(Theta1_grad)); 
Delt2=zeros(size(Theta2_grad)); 

m = size(X, 1); 
y1 = eye(num_labels)(y,:); 

for t=1:m 
  a_1=X(t,:); 
  a_1= [1; a_1']; 
  z_2=Theta1*a_1; 
  a_2=sigmoid(z_2); 
  a_2=[1; a_2]; 
  a_3=sigmoid(Theta2*a_2); 
  delta_3=a_3-y1(t,:)'; 
  z_2=[1; z_2]; 
  delta_2=(Theta2'*delta_3).*(sigmoidGradient(z_2)); 
  delta_2=delta_2(2:end); 
  Delt1=Delt1+delta_2*(a_1)'; 
  Delt2=Delt2+delta_3*(a_2)'; 
end 
Theta1_grad=Delt1/m; 
Theta2_grad=Delt2/m;

%
% Regularization of gradient
%
% Theta1_grad
%
[i_max,j_max] = size(Theta1_grad);
for i=1:i_max
    for j=2:j_max
	Theta1_grad(i,j) = Theta1_grad(i,j) + (lambda/m)*Theta1(i,j);
    endfor
endfor
%
% Theta2_grad
%
[i_max,j_max] = size(Theta2_grad);
for i=1:i_max
    for j=2:j_max
	Theta2_grad(i,j) = Theta2_grad(i,j) + (lambda/m)*Theta2(i,j);
    endfor
endfor

% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

reg1 = 0;
reg2 = 0;

tempTh1 = Theta1; tempTh2 = Theta2;

tempTh1(:,1) = tempTh1(:,1) .* 0;
tempTh2(:,1) = tempTh2(:,1) .* 0;

reg1=sum(sumsq(tempTh1));
reg2=sum(sumsq(tempTh2));

reg = lambda/(2*m)*( reg1 + reg2 );

J = J + reg;

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
