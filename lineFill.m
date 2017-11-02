function [z,t,A0] = lineFill(z_shape,t_shape,N,fill,options)


if strcmp(fill,'parallel')
    [z,t]   = f_parallel(z_shape,t_shape,N);
elseif strcmp(fill,'dsw')
    [z,t,A0] = f_dsw(options.zb,options.tb,options.Ab,N);
elseif strcmp(fill,'rw')
    [z,t,A0] = f_rw(options.zb,options.tb,options.Ab,N);
else
    fprintf('ERROR: fill_type must be "parallel" or "dsw"\n')
    return
end

end

function [z,t] = f_parallel(Z,T,N)

[z,t] = getInterPoints(Z,T,N);
end

function [ z,t,A0 ] = f_dsw(zb,tb,Ab,N)
t_vec = linspace(0,tb,100);
A0_vec = 1                  .*(t_vec <= 0) + ...
         1./(1-2*t_vec./zb) .*(t_vec > 0 & t_vec < (Ab-1)/(2*Ab)*zb) + ...
         Ab                 .*(t_vec >= (Ab-1)/(2*Ab)*zb); A0_vec(end) = Ab;
ind = find(diff(A0_vec)~=0,1,'last')+1;
A0 = linspace(1,Ab,N);
t0 = interp1(A0_vec(1:ind),t_vec(1:ind),A0); % contours to be plotted

z = zeros(N,2);
m = zeros(N,1);
t = zeros(N,2);
for ii = 1:N
    z(ii,:) = [0,zb];
    m(ii) = 1/(2*A0(ii));
    t(ii,:) = m(ii)*(z(ii,:)-zb) + tb;
end
end

function [ z,t,A0 ] = f_rw(zb,tb,Ab,N)
t_vec = linspace(0,tb,100);
A0_vec = 1                  .*(t_vec <= 0) + ...
         1./(1-2*t_vec./zb) .*(t_vec > 0 & t_vec < (Ab-1)/(2*Ab)*zb) + ...
         Ab                 .*(t_vec >= (Ab-1)/(2*Ab)*zb); A0_vec(end) = Ab;
ind = find(diff(A0_vec)~=0,1,'last')+1;
A0 = linspace(Ab,1,N);
t0 = interp1(A0_vec(1:ind),t_vec(1:ind),fliplr(A0)); % contours to be plotted

z = zeros(N,2);
m = zeros(N,1);
t = zeros(N,2);
for ii = 1:N
    z(ii,:) = [0,zb];
    m(ii) = 1/(2*A0(ii));
    t(ii,:) = m(ii)*(z(ii,:)-0) + t0(ii);
end


end

function [z_vec,t_vec,N] = getInterPoints(Z,T,N)
    m = (T(2)-T(1))/(Z(2)-Z(1));
    b = T - m*Z;
    bmax = max(b);
    bmin = min(b);
    bvec = linspace(bmin,bmax,N+2); % top bottom lines are tangent
    z_vec = [];
    t_vec = [];
    zline = linspace(min(Z)-1,max(Z)+1,2);

    for ii = 2:length(bvec)-1
        tline = m*zline + bvec(ii);
        [zi,ti] = polyxpoly(Z,T,zline,tline);

        if length(zi) ~= 2 
            zi = zi(1:2); % least one redundant?
            ti = ti(1:2);
        end
        
        z_vec = [z_vec;zi'];
        t_vec = [t_vec;ti'];
    end
end


