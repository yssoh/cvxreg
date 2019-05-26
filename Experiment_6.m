%% Misspecification: Fitting L2 Ball in R3 with polyhedral shapes
clear; close all; clc; addpath('codes'); addpath('objmesh')
fprintf('##########################################################\n')
fprintf('#Approximating the L2 ball as a polytope with k vertices.#\n')
fprintf('##########################################################\n\n')
rng(626)

%% Problem Parameters

[u_mat,~] = icosphere(4);
u_mat = u_mat';
[~,n] = size(u_mat);
h_vec = ones(1,n);

%% Use the following choices of parameters

%% Loop begins here
q_range = [4,5,6,7,8,9,10,11,12];
for q = q_range
    
    rng(626)

    fprintf('Fitting with k=%d vertices...',q);
    A_am = vertexfit_lp(u_mat,h_vec,q);
    cvxprinter_master(A_am,struct('savepath',strcat('figures/Exp_F4_3d_q',int2str(n))));
    fprintf('Done\n',q);
    
end