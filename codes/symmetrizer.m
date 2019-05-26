function [ A ] = symmetrizer( A )
%Projections the linear functionals of A to the space of symmetric matrices
[d,~,~] = size(A);
A2 = permute(A,[2,3,1]);
for i = 1 : d
    A2(:,:,i) = (A2(:,:,i) + A2(:,:,i)')/2;
end
A = permute(A2,[3,1,2]);

end

