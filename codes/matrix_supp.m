function [ lmax, E ] = matrix_supp( X )
% Compute largest eigenvalue and corresponding eigenvector

[q,~] = size(X);

[V,D] = eig(X);
[D,I] = sort(diag(D));
V = V(:, I);

lmax = D(q,1);
E = V(:,q) * V(:,q)';

end