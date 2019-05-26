function [ A_BEST ] = vertexfit_sdp( u_mat, h_vec, lifting_dim, varargin )
%Fit a semidefinite representable set to support function measurements.  
%The output map defines the projection of the free spectrahedron.  In
%otherwords, the fitted set is the image of the free spectrahedron under
%A_BEST.
%   u_mat: Directions of support function measurements
%   h_vec: Support function measurements
%   lifting_dim: Scalar, dimension
%The code is based on the Alternating Minimization implementation, with a
%Tikhonov regularization parameter specified by REG (set at 0.5).
%   Optional input are specified via the struct `params'.  The struct
%   specifies 'InnerIterates' for the number of Alternating Minimization
%   iterations, as well as 'OuterIterates' for the number of random 
%   initializations.

% Initialize
if nargin > 3
    params = varargin{1};
else
    params = {};
end

% Optional parameters

% Number of inner iterations
if isfield(params,'InnerIterates') == 1
    nInnIter = params.InnerIterates;
else
    nInnIter = 20;
end
% Number of outer iterations
if isfield(params,'OuterIterates') == 1
    nOutIter = params.OuterIterates;
else
    nOutIter = 50;
end

REG = 0.5;

% Launch the solver

q = lifting_dim;
[d,n] = size(u_mat);
dqq = d*q*q;

ERR_BEST = -1;
A_BEST = zeros(d,q,q);

% Outerloop
for ii = 1 : nOutIter
    % Perform the AM algorithm
    
    % Initialize with a random A
    A = symmetrizer(randn(d,q,q));
    
    % Innerloop
    for jj = 1 : nInnIter
        % Construct the operator
        ope = REG*eye(dqq,dqq);
        vec = REG*reshape(A,[dqq,1]);
        Af = reshape(A,[d,q*q]);
        
        % Update the empirical cov matrix
        for kk = 1 : n
            u = u_mat(:,kk);
            [~,emax] = matrix_supp(reshape(Af'*u,[q,q]));
            E = emax(:);
            s1 = u*E';
            s2 = s1(:);
            vec = vec + s2*h_vec(1,kk);
            ope = ope + s2*s2';
        end
        
        % Solve
        A = symmetrizer(reshape(ope\vec,[d,q,q]));
    end
    
    % Compare with the best
    ERR_CURR = evaluatefit(A,u_mat,h_vec,'freespectrahedron');
    if ERR_CURR*ERR_BEST < ERR_BEST*ERR_BEST
        A_BEST = A;
        ERR_BEST = ERR_CURR;
    end

end


end

