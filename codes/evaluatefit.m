function [ err ] = evaluatefit( V, u_mat, h_vec, liftingset )
%Evaluate the fit of a set wrt to the support function measurements

[~,n] = size(h_vec);

% Simplex
if strcmp(liftingset,'simplex') == 1
    vu = V' * u_mat;
    diff = max(vu) - h_vec;
    err = norm(diff,2)^2 / n;
% Free Spectrahedron
elseif strcmp(liftingset,'freespectrahedron') == 1
    [d,q,~] = size(V);
    vu = reshape(reshape(V,[d,q*q])' * u_mat, [q,q,n]);
    diff = zeros(size(h_vec));
    for i = 1 : n
        [lmax,~] = matrix_supp(vu(:,:,i));
        diff(1,i) = lmax - h_vec(1,i);
    end
    err = norm(diff,2)^2 / n;
end

end

