function [  ] = make_dsw( params,opts )
z = struct;
t = struct;

params.dsw.tb = params.dsw.zb/params.dsw.U/2;

[z.dsw,t.dsw] = lineFill2(NaN,NaN,params.dsw,opts.dsw,'dsw');

z_pre = [z.dsw(1,1),z.dsw(1,2),z.dsw(1,2),z.dsw(1,1)];
t_pre = [t.dsw(1,1),t.dsw(1,2),t.dsw(1,1),t.dsw(1,1)];
[z.pre,t.pre] = lineFill2(z_pre,t_pre,params.dsw,opts.pre,'parallel');

z_post = [z.dsw(1,1)  ,z.dsw(1,2)  ,z.dsw(1,1)  ,z.dsw(1,1)  ];
t_post = [t.dsw(end,1),t.dsw(end,2),t.dsw(end,2),t.dsw(end,1)];
[z.post,t.post] = lineFill2(z_post,t_post,params.dsw,opts.post,'parallel');


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
    % post dsw
    for ii = 1:opts.post.N
        plot(z.post(ii,:),t.post(ii,:),...
               'linewidth',opts.post.lw,...
               'linestyle',opts.post.ls,...
               'color',opts.post.color)
    end
    % dsw boundary
    plot([z.dsw(1,1),z.dsw(1,1)  ,z.dsw(1,2),z.dsw(1,1)],...
         [t.dsw(1,1),t.dsw(end,1),t.dsw(1,2),t.dsw(1,1)],...
               'linewidth',opts.dsw.lw_bnd,...
               'linestyle',opts.dsw.ls_bnd,...
               'color',opts.dsw.color_bnd)
           
    zmin = 0; zmax = max(max([z.dsw;z.pre;z.post]));
    tmin = 0; tmax = max(max([t.dsw;t.pre;t.post]));
    axis([zmin,zmax,tmin,tmax])
    box on
    xlabel('z (cm)','interpreter',opts.interp,'fontsize',opts.fs)
    ylabel('t (min)','interpreter',opts.interp,'fontsize',opts.fs)
    set(gca,'ticklabelinterpreter',opts.interp,'fontsize',opts.fs)
end

