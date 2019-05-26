%% Misspecification: Fitting L1-ball in R3 with Semidefinite rep.
clear; close all; clc; addpath('codes'); addpath('objmesh')
fprintf('###################################################################\n')
fprintf('#Approximating the L1-ball in R3 as image of a free spectrahedron.#\n')
fprintf('###################################################################\n\n')
rng(626)

%% Problem Parameters
[u_mat,~] = icosphere(4);
u_mat = u_mat';
[~,n] = size(u_mat);
h_vec = zeros(1,n);
A_true = [0,0,1; 0,0,-1; 0,1,0; 0,-1,0; 1,0,0; -1,0,0];
for i = 1 : n
    h_vec(:,i) = max(A_true * u_mat(:,i));
end

%% Loop begins here
for q = 3 : 6 % 3 - 6

    fprintf('Reconstruction as image of Free Spec of size %d times %d...',q,q)
    A_final = vertexfit_sdp(u_mat,h_vec,q);
    fprintf('Done\n')
    cvxprinter_master(A_final,struct('savepath',strcat('figures/Exp_F5_3d_q',int2str(q))));
    view([74,15])

end