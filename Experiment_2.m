%% L2-ball in R3, Noiseless Measurements
clear; close all; clc; addpath('codes'); addpath('objmesh')
fprintf('####################################################################\n')
fprintf('#Reconstructing the unit-sphere in R^3 from support fn evaluations.#\n')
fprintf('####################################################################\n\n')
rng(626)

%% Problem Parameters
n = 200;
d = 3;
sigma = 0.0;
[u_mat_all, h_vec_all] = gen_cvxsupp('ellipsoid',n);
h_vec_all = h_vec_all + sigma * randn(size(h_vec_all));

%% Fit using AM Algorithm

q = 3;

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
fprintf('Apply the AM algorithm. Number of measurements = %d :\n',n)
A_am = vertexfit_sdp(u_mat,h_vec,q);
cvxprinter_master(A_am,struct('savepath',strcat('figures/Exp_F1b_s00_AMsd_n',int2str(n))));

end


%% Fit using LSE

q = 3;

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

%% Least Squares Estimate
fprintf('Apply LSE. Number of measurements: %d\n',n)
A_LS = vertexfit_LSE(u_mat,h_vec);
cvxprinter_master(A_LS,struct('savepath',strcat('figures/Exp_F1b_s00_LS_n',int2str(n))));

end
