close all;clc;clear

params = struct;
IC = 'tri';

switch IC
    case 'dsw'
        % ----- parametes -----
        params.dsw.zb = 15; % break height (cm)
        params.dsw.A  = 3;  % area jumb ratio
        params.dsw.U  = 1;  % velocity scale (cm/min)
        
        % ----- plot specifications -----
        % dsw
        opts.dsw.N         = 10;   % N contours 
        opts.dsw.lw        = 1;    % linewidth
        opts.dsw.ls        = '-';  % linespec
        opts.dsw.color     = 'r';  % color
        opts.dsw.lw_bnd    = 2;    % boundary linewidth
        opts.dsw.ls_bnd    = '-';  % boundary linespec
        opts.dsw.color_bnd = 'k';  % boundary color
        % pre-dsw
        opts.pre.N         = 5;    % N contours 
        opts.pre.lw        = 1;    % linewidth
        opts.pre.ls        = '-';  % linespec
        opts.pre.color     = 'k';  % color
        % post-dsw
        opts.post.N         = 3;   % N contours 
        opts.post.lw        = 1;   % linewidth
        opts.post.ls        = '-'; % linespec
        opts.post.color     = 'k'; % color
        
        opts.fs = 12;
        opts.interp = 'latex';
       
        make_dsw(params,opts)

    case 'rw'
        params.rw.zb = 15; % break height (cm) [note this is an inv. dsw so pic appropriate zb
        params.rw.A  = 3;  % area jumb ratio
        params.rw.U  = 1;  % velocity scale (cm/min)
        % ----- plot specifications -----
        % rw 
        opts.rw.N         = 10;   % N contours 
        opts.rw.lw        = 1;    % linewidth
        opts.rw.ls        = '-';  % linespec
        opts.rw.color     = 'r';  % color
        opts.rw.lw_bnd    = 2;    % boundary linewidth
        opts.rw.ls_bnd    = '-'; % boundary linespec
        opts.rw.color_bnd = 'k';  % boundary color
        % pre-rw
        opts.pre.N         = 3;   % N contours 
        opts.pre.lw        = 1;    % linewidth
        opts.pre.ls        = '-';  % linespec
        opts.pre.color     = 'k';  % color
        % post-rw
        opts.post.N         = 4;   % N contours 
        opts.post.lw        = 1;    % linewidth
        opts.post.ls        = '-';  % linespec
        opts.post.color     = 'k';  % color
        
        opts.fs = 12;
        opts.interp = 'latex';
       
        make_rw(params,opts)
    case 'tri'
        params.tri.zb = 20; % break height (cm)
        params.tri.A  = 2;  % area jump ratio
        params.tri.w  = 10; % trangle width (cm)
        params.tri.U  = 1;  % velocity scale (cm/min)
        
        % ----- plot specifications -----
        % dsw (leading face)
        opts.dsw.N         = 10;   % N contours 
        opts.dsw.lw        = 1;    % linewidth
        opts.dsw.ls        = '-';  % linespec
        opts.dsw.color     = 'r';  % color
        opts.dsw.lw_bnd    = 2;    % boundary linewidth
        opts.dsw.ls_bnd    = '-';  % boundary linespec
        opts.dsw.color_bnd = 'k';  % boundary color
        % rw (trialing face)
        opts.rw.N         = 10;   % N contours 
        opts.rw.lw        = 1;    % linewidth
        opts.rw.ls        = '-';  % linespec
        opts.rw.color     = 'b';  % color
        opts.rw.lw_bnd    = 2;    % boundary linewidth
        opts.rw.ls_bnd    = '-'; % boundary linespec
        opts.rw.color_bnd = 'k';  % boundary color
        % pre-dsw
        opts.pre.N         = 3;   % N contours 
        opts.pre.lw        = 1;    % linewidth
        opts.pre.ls        = '-';  % linespec
        opts.pre.color     = 'k';  % color
        % post-rw
        opts.post.N         = 4;   % N contours 
        opts.post.lw        = 1;    % linewidth
        opts.post.ls        = '-';  % linespec
        opts.post.color     = 'k';  % color
        
        opts.fs = 12;
        opts.interp = 'latex';
       
        make_tri(params,opts)
    case 'N'
        params.N.zb = 15;  % break height (cm)
        params.N.A  = 3;   % lead area jump ratio
        params.N.a  = 0.5; % trail area jump ratio
        params.N.U  = 1;   % velocity scale (cm/min)
        params.N.w  = 10; % trangle width (cm)
       
        % ----- plot specifications -----
        % dsw (leading face)
        opts.dsw.N         = 10;   % N contours 
        opts.dsw.lw        = 1;    % linewidth
        opts.dsw.ls        = '-';  % linespec
        opts.dsw.color     = 'r';  % color
        opts.dsw.lw_bnd    = 2;    % boundary linewidth
        opts.dsw.ls_bnd    = '-';  % boundary linespec
        opts.dsw.color_bnd = 'k';  % boundary color
        % rw (trialing face)
        opts.rw.N         = 10;   % N contours 
        opts.rw.lw        = 1;    % linewidth
        opts.rw.ls        = '-';  % linespec
        opts.rw.color     = 'b';  % color
        opts.rw.lw_bnd    = 2;    % boundary linewidth
        opts.rw.ls_bnd    = '-'; % boundary linespec
        opts.rw.color_bnd = 'k';  % boundary color
        % pre-dsw
        opts.pre.N         = 3;   % N contours 
        opts.pre.lw        = 1;    % linewidth
        opts.pre.ls        = '-';  % linespec
        opts.pre.color     = 'k';  % color
        % post-rw
        opts.post.N         = 4;   % N contours 
        opts.post.lw        = 1;    % linewidth
        opts.post.ls        = '-';  % linespec
        opts.post.color     = 'k';  % color
        
        opts.fs = 12;
        opts.interp = 'latex';
       
        make_tri(params,opts)
    case 'box'
        params.box.zb = 15; % break height (cm)
        params.box.A  = 3;  % area jump ratio
        params.box.U  = 1;  % velocity scale (cm/min)
        params.box.w  = 10; % trangle width (cm)
end