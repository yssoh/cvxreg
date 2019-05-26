function [ t ] = cvopt_fs_cvx( A, u )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[d,q,~] = size(A);
A_flat = reshape(A,[d,q*q]);

cvx_begin quiet
    variables X(q,q) h
    minimize(h)
    subject to
        A_flat * X(:) == - h * u
        trace(X) == 1
        X == semidefinite(q)
cvx_end

t = -h;

end

