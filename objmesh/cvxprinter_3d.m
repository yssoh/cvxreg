function [  ] = cvxprinter_3d( A )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if ndims(A) == 2        % Polyhedral
    K = convhull(A(1,:)',A(2,:)',A(3,:)');
    trisurf(K,A(1,:)',A(2,:)',A(3,:)','FaceAlpha',0.5);
    
elseif ndims(A) == 3    % Semidefinite
    % Regular grid of the sphere
    [V,~] = icosphere(3);
    V = V';
    [~,n] = size(V);
    
    % Creating the vertices
    hu_mat = zeros(size(V));
    
    % Adding vertices
    n_ctr = floor(n/10);
    fprintf('\n Generating figure')
    for i = 1 : n
        % Compute support function value
        u  = V(:,i);

        % Compute the distance of the surface to the center
        h = cvopt_fs_cvx(A,u);
        hu_mat(:,i) = u * h;
        
        % Progress bar
        if mod(i,n_ctr) == 0
            fprintf('.')
        end
    end
    fprintf('\n')
    K = convhull(hu_mat(1,:)',hu_mat(2,:)',hu_mat(3,:)');
    trisurf(K,hu_mat(1,:)',hu_mat(2,:)',hu_mat(3,:)','FaceAlpha',0.5);

end

end

