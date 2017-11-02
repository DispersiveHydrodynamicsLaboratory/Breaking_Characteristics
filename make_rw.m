function [  ] = make_rw( params,opts )
z = struct;
t = struct;



params.rw.tb = params.rw.zb/params.rw.U/2;

[z.rw,t.rw] = lineFill2(NaN,NaN,params.rw,opts.rw,'rw');

z_pre = [z.rw(1,1),z.rw(1,2),z.rw(1,2),z.rw(1,1)];
t_pre = [min(t.rw(:,1)),min(t.rw(:,2)),min(t.rw(:,1)),min(t.rw(:,1))];
[z.pre,t.pre] = lineFill2(z_pre,t_pre,params.rw,opts.pre,'parallel');

z_post = [min(z.rw(:,1)),max(z.rw(:,2)),min(z.rw(:,1)),min(z.rw(:,1))];
t_post = [max(t.rw(:,1)),max(t.rw(:,2)),max(t.rw(:,2)),max(t.rw(:,1))];
[z.post,t.post] = lineFill2(z_post,t_post,params.rw,opts.post,'parallel');


figure; hold on;
    % pre rw
    for ii = 1:opts.pre.N
        plot(z.pre(ii,:),t.pre(ii,:),...
               'linewidth',opts.pre.lw,...
               'linestyle',opts.pre.ls,...
               'color',opts.pre.color)
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

