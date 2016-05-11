function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly
X_norm = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       

% normalize features of X, ...
% where X is a m-by-n matrix, ...
% where n (columns) are features, and ...
% m (rows) are a training sample

mu = mean(X); % computes the mean for each column, returns 1-by-n
sigma = std(X); % computes standard deviation for each column, returns 1-by-n
mu_mat = repmat(mu,size(X,1),1); % takes the 1-by-n matrix for mu and repeats it for m rows, returns m-by-n matrix
sigma_mat = repmat(sigma,size(X,1),1); % takes the 1-by-n matrix for sigma and repeats it for m rows, returns m-by-n matrix

X_norm = (X - mu_mat) ./ sigma_mat; % completes normalization for each column, returns m-by-n matrix

    % for the case where the first feature is all ones
    % the normalization practice would return NaNs, so replace it with the
    % original vector of ones
if sigma(1) == 0; X_norm(:,1) = X(:,1); end; 



% ============================================================

end
