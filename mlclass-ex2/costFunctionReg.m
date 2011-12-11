function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

% Logistic regression cost function
%
% J(theta) = 1/m*sum[ Cost ] i = 1:m
%
% Cost = -y*log(h(x)) - (1-y)*log(1-h(x))
%

fact = eye(size(theta,1));
fact(1,1) = 0;
reg = lambda/(2*m)*sum(fact*theta.^2);
J = (1/m)*sum(-y.*log(sigmoid(X * theta)) - (1-y).*log(1-sigmoid(X * theta))) + reg;

%
% Grad
%

grad0 = (1/m).* X' * (sigmoid(X * theta) - y);     
grad = (1/m).* ( X' * (sigmoid(X * theta) - y) + lambda.*theta);

grad(1) = grad0(1);

% =============================================================

end
