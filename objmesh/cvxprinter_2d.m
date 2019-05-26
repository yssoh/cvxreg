function [  ] = cvxprinter_2d( A, varargin )
%Prints a mesh of the projection of the Simplex under A

if ndims(A) == 2        % Polyhedral
    K = convhull(A(1,:)',A(2,:)');
    x = A(1,:)'; y = A(2,:)';
    plot(x(K),y(K),'LineWidth',2);
    
elseif ndims(A) == 3    % Semidefinite
    
    [d,q,~] = size(A);
    A_flat = reshape(A,[d,q*q]);
    
    % Extract the number of points to print to screen
    if nargin > 1
        n = varargin{1};
    else
        n = 180; % 180
    end
    
    % These are the atoms
    ctr = 2 * pi * (1:1:n) / n;
    V = [ cos(ctr) ; sin(ctr) ];
    
    % Creating the vertices
    hu_mat = zeros(size(V));
    
    % Adding vertices
    n_ctr = floor(n/10);
    fprintf('\n Generating figure')
    for i = 1 : n
        % Compute support function value
        u  = V(:,i);

        % Compute the distance of the surface to the center
        cvx_begin quiet
            variables X(q,q) h
            minimize(h)
            subject to
                A_flat * X(:) == - h * u
                trace(X) == 1
                X == semidefinite(q)
        cvx_end

        hu_mat(:,i) = V(:,i) * (-h);
        
        % Progress bar
        if mod(i,n_ctr) == 0
            fprintf('.')
        end

    end
    fprintf('\n')
    hu_mat = [hu_mat hu_mat(:,1)]; % Close the loop
    
    plot(hu_mat(1,:)',hu_mat(2,:)','LineWidth',2)
end

end

