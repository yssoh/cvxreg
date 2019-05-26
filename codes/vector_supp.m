function [ lmax, E ] = vector_supp( X )
% Compute largest eigenvalue and corresponding eigenvector

[q,~] = size(X);
[lmax,E_arg] = max(X);

E = zeros(q,1);
E(E_arg,1) = 1;

end