function [ V ] = vertexfit_LSE( u_mat, h_vec )
%Compute LSE.  Gardner and Kiderlen.  Requires CVX

[d,n] = size(u_mat);

cvx_begin
    variable V(d,n)
    minimize ( norm( h_vec' - diag(V' * u_mat) ) )
    subject to
    for i = 1 : n
        for j = i + 1 : n
            (V(:,j) - V(:,i))' * u_mat(:,i) <= 0
            (V(:,i) - V(:,j))' * u_mat(:,j) <= 0
        end
    end
cvx_end

end

