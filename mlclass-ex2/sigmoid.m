function g = sigmoid(z)
%SIGMOID Compute sigmoid functoon
%   J = SIGMOID(z) computes the sigmoid of z.

% You need to return the following variables correctly 
g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the sigmoid of each value of z (z can be a matrix,
%               vector or scalar).

[maxRow, maxCol] = size(z);

for row = 1:maxRow
  for col = 1:maxCol
    g(row, col) = 1/(1 + exp(-1*z(row,col)));
  end
end

% =============================================================

end
