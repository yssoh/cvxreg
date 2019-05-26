%% L1-ball in R3, Noisy measurements
clear; close all; clc; addpath('codes'); addpath('objmesh')
fprintf('################################################################\n')
fprintf('#Reconstructing the L1-ball in R^3 from noisy support fn evals.#\n')
fprintf('################################################################\n\n')
rng(626)

%% Problem Parameters

n = 200;
d = 3;
sigma = 0.1;
[u_mat_all, h_vec_all] = gen_cvxsupp('octa',n);
h_vec_all = h_vec_all + sigma * randn(size(h_vec_all));

%% Fit using AM Algorithm

q = 6;

for kk = 1 : 3

switch kk
    case 1
        n = 20;
    case 2
        n = 50;
    case 3
        n = 200;
end

h_vec = h_vec_all(:,1:n);
u_mat = u_mat_all(:,1:n);
    
%% Complexity Constrained Regression
fprintf('AM implementation. Number of measurements: %d\n',n)
A_am = vertexfit_lp(u_mat,h_vec,q);
cvxprinter_master(A_am,struct('savepath',strcat('figures/Exp_F1a_s01_AMpoly_n',int2str(n))));

end

%% Fit using AM Algorithm

q = 6;

for kk = 1 : 3

switch kk
    case 1
        n = 20;
    case 2
        n = 50;
    case 3
        n = 200;
end

fprintf('Number of measurements: %d\n',n)
h_vec = h_vec_all(:,1:n);
u_mat = u_mat_all(:,1:n);
    
%% Least Squares Estimate
fprintf('Least Squares Regression. Number of measurements: %d\n',n)
A_LS = vertexfit_LSE( u_mat, h_vec );
cvxprinter_master(A_LS,struct('savepath',strcat('figures/Exp_F1a_s01_LS_n',int2str(n))));

end