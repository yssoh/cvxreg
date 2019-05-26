function [ u_mat, h_vec ] = gen_cvxsupp( shape, n_pts )
% Generates instance of a convex set with support function evaluations
%   shape: string. Supported shapes are
%   (2D) circle, square
%   (3D) sphere, octahedron
%   n_pts: integer specifying number of points

n = n_pts;

if strcmp(shape,'square') == 1
    
    d = 2;
    u_mat = zeros(d,n);
    h_vec = zeros(1,n);
    vertex_set = [1,1; 1,-1; -1,1; -1,-1];
    % Directions are uniform
    for i = 1 : n
        arg = 2 * pi * i / n;
        u = [cos(arg); sin(arg)];
        u_mat(:,i) = u;
        h_vec(:,i) = max(vertex_set * u);
    end
    
elseif strcmp(shape,'diamond') == 1
    
    d = 2;
    u_mat = zeros(d,n);
    h_vec = zeros(1,n);
    vertex_set = [0,1; 0,-1; -1,0; 1,0];
    % Directions are uniform
    for i = 1 : n
        arg = 2 * pi * i / n;
        u = [cos(arg); sin(arg)];
        u_mat(:,i) = u;
        h_vec(:,i) = max(vertex_set * u);
    end
    
elseif strcmp(shape,'circle') == 1
    
    d = 2;
    u_mat = zeros(d,n);
    % Directions are uniform
    for i = 1 : n
        arg = 2 * pi * i / n;
        u_mat(:,i) = [cos(arg); sin(arg)];
    end
    h_vec = ones(1,n);
    
elseif strcmp(shape,'octa') == 1
    
    d = 3;
    % Directions are random
    u_mat = randn(d,n);
    h_vec = zeros(1,n);
    vertex_set = [0,0,1; 0,0,-1; 0,1,0; 0,-1,0; 1,0,0; -1,0,0];
    for i = 1 : n
        u = u_mat(:,i) / norm(u_mat(:,i),2);
        u_mat(:,i) = u;
        h_vec(:,i) = max(vertex_set * u);
    end
    
elseif strcmp(shape,'ellipsoid') == 1
    
    d = 3;
    % Directions are random
    u_mat = randn(d,n);
    for i = 1 : n
        u = u_mat(:,i) / norm(u_mat(:,i),2);
        u_mat(:,i) = u;
    end
    h_vec = ones(1,n);
    
elseif strcmp(shape,'trapezium') == 1
    
    d = 2;
    u_mat = zeros(d,n);
    h_vec = zeros(1,n);
    eps = 0.1;
    vertex_set = [1+eps,1; 1-eps,-1; -1-eps,1; -1+eps,-1];
    % Directions are uniform
    for i = 1 : n
        arg = 2 * pi * i / n;
        u = [cos(arg); sin(arg)];
        u_mat(:,i) = u;
        h_vec(:,i) = max(vertex_set * u);
    end
    
elseif strcmp(shape,'cube') == 1
    
    d = 3;
    % Directions are random
    u_mat = randn(d,n);
    h_vec = zeros(1,n);
    vertex_set = [1,1,1;   1,1,-1;  1,-1,1;  1,-1,-1; ...
                  -1,1,1; -1,1,-1; -1,-1,1; -1,-1,-1];
    for i = 1 : n
        u = u_mat(:,i) / norm(u_mat(:,i),2);
        u_mat(:,i) = u;
        h_vec(:,i) = max(vertex_set * u);
    end
elseif strcmp(shape,'racetrack') == 1
    d = 2;
    % Directions are uniform
    u_mat = zeros(d,n);
    h_vec = zeros(1,n);
    for i = 1 : n
        arg = 2 * pi * i / n;
        u_mat(:,i) = [cos(arg); sin(arg)];
        if arg > pi/2 && arg < 3*pi/2 % Equivalent to reflecting the circular track
            arg = pi - arg;
        end
        bet = atan(sin(arg));
        if abs(arg)<0.01
            h_vec(:,i) = 2;
        else
            h_vec(:,i) = sin(arg+bet)/sin(bet);
        end
    end
    
else
    fprintf('Shape not supported!\n')
end

end

