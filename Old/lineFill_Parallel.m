function [ ] = lineFill_Parallel( X,Y,options,plot_options )
% =========================================================================
% INPUTS
%       X : shape x-vector
%       Y : shape y-vector
%    opts : plot options
%
% =========================================================================
figure(plot_options.figure_number);clf
if length(X) ~= length(Y)
    fprintf('INPUT ERROR: shape vectores (X,Y) must be the same length\n')
    return
end
if options.slope == 0 || options.slope == inf
    fprintf('INPUT ERROR: line slopes must be non-zero and finite\n')
    return
end

[x_vec,y_vec] = getInterPoints(X,Y,options);

figure(plot_options.figure_number); hold on
    for ii = 1:2:length(x_vec)-1
        plot(x_vec(ii:ii+1),y_vec(ii:ii+1),...
                 'linewidth',plot_options.lwidth,...
                 'LineStyle' ,plot_options.lstyle,...
                 'Color'    ,plot_options.color)
    end
    plot(X,Y,'linewidth',plot_options.lwidth,...
             'LineStyle',plot_options.lspec,...
             'Color'    ,plot_options.color)
end



function [x_vec,y_vec,options] = getInterPoints(X,Y,options)
m = options.slope;
b = Y - m*X;
bmax = max(b);
bmin = min(b);
bvec = linspace(bmin,bmax,options.N_lines+2); % top bottom lines are tangent
x_vec = [];
y_vec = [];
xline = linspace(min(X)-1,max(X)+1,2);

for ii = 2:length(bvec)-1
    yline = m*xline + bvec(ii);
    [xi,yi] = polyxpoly(X,Y,xline,yline);
    
    N = length(xi);
    N_lines = floor(N/2);
    options.N_lines = options.N_lines + N_lines -1; % incase 
    if mod(N,2) ~= 0 
        xi = xi(1:end-1); % last one redundant?
        yi = yi(1:end-1);
    end
    
    x_vec = [x_vec;xi];
    y_vec = [y_vec;yi];
end
    
end


