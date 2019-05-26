%% Uncomfortable Pillow
clear; close all; clc; addpath('codes'); addpath('objmesh')
fprintf('#############################################\n')
fprintf('#Reconstructing the ``Uncomfortable Pillow''#\n')
fprintf('#############################################\n\n')
rng(626)

%% Problem Parameters
[u_mat,~] = icosphere(2);
u_mat = u_mat';
[~,n] = size(u_mat);
h_vec = gen_upillow(u_mat);

q = 4;
A_final = vertexfit_sdp(u_mat,h_vec,q);

%% Print and Save the Figure in different configurations
figure
cvxprinter_master(A_final)
fprintf('Output reconstruction in different views..')
view([0,90])
pathname = strcat('figures/Exp_F6_q',int2str(q),'v1');
print(pathname,'-dpdf')
view([0,0])
pathname = strcat('figures/Exp_F6_q',int2str(q),'v2');
print(pathname,'-dpdf')
view([90,45])
pathname = strcat('figures/Exp_F6_q',int2str(q),'v3');
print(pathname,'-dpdf')
view([180,45])
pathname = strcat('figures/Exp_F6_q',int2str(q),'v4');
print(pathname,'-dpdf')
