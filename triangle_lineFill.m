clear;close all;clc
N_dsw = 10;
N_rw = 10;
N_trail = 3;
N_lead = 4;

options = struct;
options.zb = 15;
options.tb = options.zb/2;
options.Ab = 2;

[z_dsw,t_dsw,A0] = lineFill(NaN,NaN,N_dsw,'dsw',options);
figure(1);hold on
for ii = 1:N_dsw
    plot(z_dsw(ii,:),t_dsw(ii,:),'r')
end

[z_rw,t_rw,A0] = lineFill(NaN,NaN,N_rw,'rw',options);
t_rw = t_rw + max(t_dsw(:,1));
for ii = 1:N_rw
    plot(z_rw(ii,:),t_rw(ii,:),'b')
end

z_lead = [z_dsw(1,1),z_dsw(1,2),z_dsw(1,2),z_dsw(1,1)];
t_lead = [t_dsw(1,1),t_dsw(1,2),z_dsw(1,1),z_dsw(1,1)];

[z_lead,t_lead] = lineFill(z_lead,t_lead,N_lead,'parallel',options);
for ii = 1:N_lead
    plot(z_lead(ii,:),t_lead(ii,:),'k')
end

z_trail = [z_rw(1,1)  ,z_rw(1,2),z_rw(1,1),z_rw(1,1)];
t_trail = [t_rw(end,1),t_rw(end,2),t_rw(end,2),t_rw(end,1)];
[z_trail,t_trail] = lineFill(z_trail,t_trail,N_trail,'parallel',options);
for ii = 1:N_trail
    plot(z_trail(ii,:),t_trail(ii,:),'k')
end

plot([z_dsw(1,1),z_dsw(1,1),z_dsw(1,2),z_dsw(1,1)],...
     [t_dsw(1,1),t_dsw(end,1),t_dsw(1,2),t_dsw(1,1)],'r:','linewidth',2)
plot([z_rw(1,1),z_rw(1,1)  ,z_rw(1,2),z_rw(1,2),z_rw(1,1)],...
     [t_rw(1,1),t_rw(end,1),t_rw(end,2),t_rw(1,2),t_rw(1,1)],'b--','linewidth',2)
axis([z_dsw(1,1),z_dsw(1,2),t_dsw(1,1),t_rw(end,2)])
box on
xlabel('z_b (cm)')
ylabel('t_b (?)')