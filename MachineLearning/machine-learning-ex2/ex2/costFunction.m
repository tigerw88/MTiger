function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.
%
% INPUT
%   theta -> [n-by-1] ...
%   X -> [m-by-n] matrix of training data (includes first column of zeros
%   for intercept]
%   y -> [m-by-1] vector of results or values
%
% OUTPUT
%   J -> [1-by-1] ...
%   grad -> [n-by-1] ...

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
%
% Note: grad should have the same dimensions as theta
%

    % hpothesis is defined as g(theta' * x), where g is known as the
    % sigmoid function
h = sigmoid( theta' * X' ); % -> [1-by-m]

    % Cost function in logistic regression:
J = -(1/m) * ( y' * log(h') + (1-y')*log(1-h') ); % -> [1-by-1] ...

    % gradient vector of cost function:
grad = (1/m) * ((h-y') * X)'; % -> [n-by-1]
% grad = theta - (1/m) * ((h-y') * X)'; % -> [n-by-1]


% =============================================================

end
