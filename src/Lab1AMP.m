clear; clc; close all;
tic

% Parameters for process

eta = 0.27; % Process efficiency (calibrated for measured width "w_meas")
P = 1600*10^-3; % Irradiation in Watts
v = 800/60*10^-3; % Speed of source m/s
N=1; % Number of passes
cz=10; % Geometrical correction factor
T0 = 25; % Initial material temperature

% Material properties (resin)

rho = 1450; % Material density kg/m3
cp=2500; % Specific heat J/kgK
k = 0.3; % Thermal conductivity W/mK
Tvap = 300;% Vaporization temperature C
Abs = 0.3;  % Absorption coefficient
thicc = 20*10^-6; % Thickness in um
alpha=k/(rho*cp); % Thermal diffusivity m2/s

% Domain (in micrometers)

delta=1;
ymin=-200;
ymax=200;
xmin=-1000;
xmax=50;
zmin=0;
zmax=20;
x=linspace(xmin,xmax,(xmax-xmin)/delta)*10^-6; % to meters
y=linspace(ymin,ymax,(ymax-ymin)/(delta))*10^-6;
z=linspace(zmin,zmax,(zmax-zmin)/delta)*10^-6;
nx=length(x);
ny=length(y);
nz=length(z);

Tmat=zeros(nx,ny,nz);

%Experimental data

m = [172 163 177 177 165]; % width measures in black resin ablation
w_meas = mean(m);

%Calculation

for ii=1:nx
    for jj=1:ny
        for kk=1:nz
            r=sqrt(x(ii)^2+y(jj)^2+(cz*z(kk))^2);
            Tmat(ii,jj,kk)=T0+eta*(P/(2*pi*k*r))*exp(-v/(2*alpha)*(x(ii)+r));
            if Tmat(ii,jj,kk)>Tvap
                Tmat(ii,jj,kk)=Tvap;
            else
                % TmatLim(ii,jj,kk)=Tmat(ii,jj,kk);
            end
        end
    end

end

figure

[X,Y]=meshgrid(x*10^6,y*10^6);
pcolor(X,Y,transpose(Tmat(:,:,1)),EdgeColor="none")
grid off
title('Tlim(\xi,y)')
xlim([xmin xmax]);
ylim([ymin ymax]);
xlabel('\xi[\mum]')
ylabel('y[\mum]')
ax = gca;
ax.FontSize = 13;
c = colorbar;
clim([25 300])
c.Label.String = 'T[°C]';
pbaspect([xmax-xmin ymax-ymin zmax-zmin])

figure

[X,Y]=meshgrid(x*10^6,y*10^6);
[M,C]=contour(X,Y,transpose(Tmat(:,:,1)),[300 300],'ShowText','on','LabelSpacing',500);
M(:,1)=[];
xcords=M(1,:);
ycords=M(2,:);
width0=min(ycords);
width1=max(ycords);
width=round(width1-width0);
xlim([xmin xmax]);
ylim([ymin ymax]);
xlabel('\xi[\mum]')
ylabel('y[\mum]')
ax = gca;
ax.FontSize = 13;
title(['Tlim(\xi,y) VAP width: ',num2str(width),'\mum'])
pbaspect([xmax-xmin ymax-ymin zmax-zmin])
hold on
x1=xcords(1);
x2=xcords(size(xcords,2));
xp = [x1 x2];
yp = [width0 width1];
plot(xp,yp)
legend('VAP contour','VAP w_{sim}')

figure

[X,Z]=meshgrid(x*10^6,z*10^6);
pcolor(X,Z,transpose(squeeze(Tmat(:,ny/2,:))),EdgeColor="none")
title('Tlim(\xi,z)')
xlim([xmin xmax]);
ylim([zmin zmax]);
xlabel('\xi[\mum]')
ylabel('z[\mum]')
ax = gca;
ax.FontSize = 13;
c = colorbar;
clim([25 300])
c.Label.String = 'T[°C]';

figure

[X,Z]=meshgrid(x*10^6,z*10^6);
[M,C]=contour(X,Z,transpose(squeeze(Tmat(:,ny/2,:))),[300 300],'ShowText','on','LabelSpacing',500);
M(:,1)=[];
xcords=M(1,:);
zcords=M(2,:);
depth=max(zcords);
xlim([xmin xmax]);
ylim([zmin zmax]);
xlabel('\xi[\mum]')
ylabel('z[\mum]')
ax = gca;
ax.FontSize = 13;
title(['Tlim(\xi,z) VAP depth: ',num2str(depth),'\mum'])
hold on
xp = [x1 x2];
yp = [0 depth];
plot(xp,yp)
legend('VAP contour','VAP depth')


figure

yzslice=find(x==x1*10^-6);
[Y,Z]=meshgrid(y*10^6,z*10^6);
pcolor(Y,Z,transpose(squeeze(Tmat(yzslice,:,:))),EdgeColor="none")
title('Tlim(y,z)')
xlim([ymin ymax]);
ylim([zmin zmax]);
xlabel('y[\mum]')
ylabel('z[\mum]')
ax = gca;
ax.FontSize = 13;
c = colorbar;
clim([25 300])
c.Label.String = 'T[°C]';

figure

[Y,Z]=meshgrid(y*10^6,z*10^6);
[M,C]=contour(Y,Z,transpose(squeeze(Tmat(yzslice,:,:))),[300 300],'ShowText','on','LabelSpacing',500);
xlabel('y[\mum]')
ylabel('z[\mum]')
xlim([ymin ymax]);
ylim([zmin zmax]);
ax = gca;
ax.FontSize = 13;
title(['Tlim(y,z) VAP depth: ',num2str(depth),'\mum'])
hold on
xp = [0 0];
yp = [0 depth];
plot(xp,yp)
legend('VAP contour','VAP depth')

% figure
% 
% [X,Y]=meshgrid(x*10^6,y*10^6);
% contour(X,Y,transpose(Tmat(:,:,1)),'ShowText','on');
% pbaspect([xmax-xmin ymax-ymin zmax-zmin])
% title('Tlim(\xi,y)')
% xlim([xmin xmax]);
% ylim([ymin ymax]);
% xlabel('\xi[\mum]')
% ylabel('y[\mum]')
% ax = gca;
% ax.FontSize = 13;
 
% toc