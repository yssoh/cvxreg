%% Misspecification: Fitting L1-ball in R2 with Semidefinite rep.
clear; close all; clc; addpath('codes'); addpath('objmesh')
fprintf('###################################################################\n')
fprintf('#Approximating the L1-ball in R2 as image of a free spectrahedron.#\n')
fprintf('###################################################################\n\n')
rng(626)

%% Problem Parameters
n = 1000;
sigma = 0.0;
A_true = [0,1; 0,-1; -1,0; 1,0]';
[u_mat, h_vec] = gen_cvxsupp('diamond',n);
h_vec = h_vec + sigma * randn(size(h_vec));

%% Loop begins here
for q = 2 : 4 % 2,3,4

    fprintf('Reconstruction as image of Free Spec of size %d times %d...',q,q)
    A_am = vertexfit_sdp(u_mat,h_vec,q);
    fprintf('Done\n')
    cvxprinter_master(A_am,struct('savepath',strcat('figures/Exp_F5_2d_q',int2str(q))));

end