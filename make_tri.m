function [  ] = make_tri( p,opts )
params = struct;
params.dsw.zb = p.tri.zb; % break height (cm)
params.dsw.A  = p.tri.A;  % area jumb ratio
params.dsw.U  = p.tri.U;  % velocity scale (cm/min)
params.dsw.tb = params.dsw.zb/params.dsw.U/2;
params.rw.zb  = p.tri.w;  % break height (cm) [note this is an inv. dsw so pic appropriate zb]
params.rw.A   = p.tri.A;  % area jumb ratio
params.rw.U   = p.tri.U;  % velocity scale (cm/min)
params.rw.tb  = params.rw.zb/params.rw.U/2;

z = struct;
t = struct;



[z.dsw,t.dsw] = lineFill2(NaN,NaN,params.dsw,opts.dsw,'dsw');

z_pre = [z.dsw(1,1),z.dsw(1,2),z.dsw(1,2),z.dsw(1,1)];
t_pre = [t.dsw(1,1),t.dsw(1,2),t.dsw(1,1),t.dsw(1,1)];
[z.pre,t.pre] = lineFill2(z_pre,t_pre,params.dsw,opts.pre,'parallel');

[z.rw,t.rw] = lineFill2(NaN,NaN,params.rw,opts.rw,'rw');
t.rw = t.rw + max(t.dsw(:,1)); % shift rw up
if max(z.dsw(:,2)) > max(z.rw(:,2)) % extend rw characteristics
    for ii = 1:opts.rw.N
        t.rw(ii,2) = interp1(z.rw(ii,:),t.rw(ii,:),z.dsw(ii,2),'linear','extrap');
        z.rw(ii,2) = z.dsw(ii,2);
    end
    
%     t_tmp = interp2(z.rw,t.rw,z.dsw,'extrap');
end


z_post = [min(z.rw(:,1)),max(z.rw(:,2)),min(z.rw(:,1)),min(z.rw(:,1))];
t_post = [max(t.rw(:,1)),max(t.rw(:,2)),max(t.rw(:,2)),max(t.rw(:,1))];
[z.post,t.post] = lineFill2(z_post,t_post,params.rw,opts.post,'parallel');


figure; hold on;
    % pre dsw
    for ii = 1:opts.pre.N
        plot(z.pre(ii,:),t.pre(ii,:),...
               'linewidth',opts.pre.lw,...
               'linestyle',opts.pre.ls,...
               'color',opts.pre.color)
    end
    % dsw
    for ii = 1:opts.dsw.N
        plot(z.dsw(ii,:),t.dsw(ii,:),...
               'linewidth',opts.dsw.lw,...
               'linestyle',opts.dsw.ls,...
               'color',opts.dsw.color)
    end
     % rw
    for ii = 1:opts.rw.N
        plot(z.rw(ii,:),t.rw(ii,:),...
               'linewidth',opts.rw.lw,...
               'linestyle',opts.rw.ls,...
               'color',opts.rw.color)
    end
    % post rw
    for ii = 1:opts.post.N
        plot(z.post(ii,:),t.post(ii,:),...
               'linewidth',opts.post.lw,...
               'linestyle',opts.post.ls,...
               'color',opts.post.color)
    end
    % rw boundary
%     plot([z.rw(1,1),z.rw(1,1)  ,z.rw(1,2)  ,z.rw(1,2),z.rw(1,1)],...
%          [t.rw(1,1),t.rw(end,1),t.rw(end,2),t.rw(1,2),t.rw(1,1)],...
%                'linewidth',opts.rw.lw_bnd,...
%                'linestyle',opts.rw.ls_bnd,...
%                'color',opts.rw.color_bnd)
           
    zmin = 0; zmax = max(max([z.rw;z.pre;z.post]));
    tmin = 0; tmax = max(max([t.rw;t.pre;t.post]));
    axis([zmin,zmax,tmin,tmax])
    box on
    xlabel('z (cm)','interpreter',opts.interp,'fontsize',opts.fs)
    ylabel('t (min)','interpreter',opts.interp,'fontsize',opts.fs)
    set(gca,'ticklabelinterpreter',opts.interp,'fontsize',opts.fs)
end



