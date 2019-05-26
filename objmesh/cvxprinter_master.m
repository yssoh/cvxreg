function [ ] = cvxprinter_master( A, varargin )
%Prints figure of the fitted object.  

% Handle the optional arguments
if nargin > 1
    params = varargin{1};
else
    params = {};
end

if isfield(params,'limits') == 1
    limits = params.limits;
else
    limits = [-1.5 1.5];
end
if isfield(params,'savepath') == 1
    savefile = 1;
    savepath = params.savepath;
else
    savefile = 0;
end

figure;

if ndims(A) == 2
    [d,~] = size(A);
elseif ndims(A) == 3
    [d,~,~] = size(A);
end

% Switch between the 2D or the 3D printer
switch d
    case 2
        cvxprinter_2d(A)
        xlim(limits)
        ylim(limits)
        pbaspect([1,1,1])
    case 3
        cvxprinter_3d(A)
        xlim(limits)
        ylim(limits)
        zlim(limits)
        pbaspect([1,1,1])
end

% Printing Options
axis off

if savefile == 1
    print(savepath,'-dpdf')
end

end