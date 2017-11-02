function [ ] = lineFill_Spread( X,Y,x0,y0,options)
% =========================================================================
% INPUTS
%       X : shape x-vector
%       Y : shape y-vector
%    opts : plot options
%
% =========================================================================
% figure(plot_options.figure_number);clf
% 
% if length(X) ~= length(Y)
%     fprintf('INPUT ERROR: shape vectores (X,Y) must be the same length\n')
%     return
% end
% if options.slope == 0 || options.slope == inf
%     fprintf('INPUT ERROR: line slopes must be non-zero and finite\n')
%     return
% end


[x_vec,y_vec] = getInterPoints(X,Y,x0,y0,options);



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



function [x_vec,y_vec,options] = getInterPoints(X,Y,x0,y0,options)

ind = find(X == x0 & Y == y0);
[theta,r] = cart2pol(X-x0,Y-y0);
theta(theta<=0) = theta(theta<=0) + 2*pi;
theta(ind) = NaN;
theta_min = min(theta);
theta_max = max(theta);
r_max  = max(r)+10;
theta_vec = linspace(theta_min,theta_max,options.N_lines+2);
r_vec = r_max*ones(size(theta_vec));

[x,y] = pol2cart(theta_vec,r_vec);


x_vec = [];
y_vec = [];

for ii = 2:length(r_vec)-1
    [xi,yi] = polyxpoly(X,Y,[x0,x(ii)],[y0,y(ii)]);
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


