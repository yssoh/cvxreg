function [ h_vec ] = gen_q1( u_mat )
%GEN_ELLIPTOPESLICE Summary of this function goes here
%   Detailed explanation goes here

[~,n] = size(u_mat);
h_vec = zeros(1,n);

A = zeros(3,4,4);
A(1,1,2) = 1; A(1,2,1) = 1;
A(2,2,3) = 1; A(2,3,2) = 1;
A(3,3,4) = 1; A(3,4,3) = 1;
A = reshape(A,[3,4*4]);

for i = 1 : n
    
    u = u_mat(:,i);
    
    E = reshape(A' * u, [4,4]);
    [~,V] = eig(E);
    
    h_vec(1,i) = max(diag(V));

end

end



