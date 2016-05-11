function J = computeCostMulti(X, y, theta)
%COMPUTECOSTMULTI Compute cost for linear regression with multiple variables
%   J = COMPUTECOSTMULTI(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta
%               You should set J to the cost.

% h = theta(1) + theta(2)*X(:,2); % other method
h = X * theta; % matrix multiplication method

J = (1/(2*m))*sum((h-y).^2); % Matlab implementation of function to minimize cost function

% =========================================================================

end