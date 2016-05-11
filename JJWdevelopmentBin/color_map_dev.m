%%

F = figure
subplot(211)
scatter(lon,lat,log(Magnitude+min(Magnitude)+1)*15,DateTime)
title('My first attempt to create my own color map')


c = colorbar
colormap(F,'gray')

cmap = colormap(F)
cmap(:,:) = nan;

anchor = [0 12 24 36 48 64] % this is the last digit of the value that belongs to the set

cbott = 0.6

shading = linspace(cbott,1,anchor(2)-anchor(1))
cmap(anchor(1)+1:(anchor(2)),3) = shading;
cmap(anchor(1)+1:(anchor(2)),1) = shading;

shading = linspace(cbott,1,anchor(3)-anchor(2))
cmap(anchor(2)+1:(anchor(3)),3) = shading;

shading = linspace(cbott,1,anchor(4)-anchor(3))
cmap(anchor(3)+1:(anchor(4)),2) = shading;
cmap(anchor(3)+1:(anchor(4)),3) = shading;

shading = linspace(cbott,1,anchor(5)-anchor(4))
cmap(anchor(4)+1:(anchor(5)),2) = shading;

shading = linspace(cbott,1,anchor(6)-anchor(5))
cmap(anchor(5)+1:(anchor(6)),1) = shading;
cmap(anchor(5)+1:(anchor(6)),2) = shading;


colormap(F,cmap)

subplot(212)
plot(cmap(:,1),'r','LineWidth',2), hold on, plot(cmap(:,2),'g'), plot(cmap(:,3),'b')


%% Recreating the 'jet' colormap

F2 = figure
subplot(211)
scatter(lon,lat,log(Magnitude+min(Magnitude)+1)*15,DateTime)
title('My attempt to re-create the jet color map')


c = colorbar
colormap(F2,'gray')

cmap = colormap(F2)
cmap(:,:) = nan;

anchor = [0 9 15 25 33 39 49 55 64] % this is the last digit of the value that belongs to the set

cbott = 0


n = 1
shadingU = linspace(0.5,1,anchor(n+1)-anchor(n))
shadingD = linspace(0,1,anchor(n+1)-anchor(n))
cmap(anchor(n)+1:(anchor(n+1)),1) = 0;
cmap(anchor(n)+1:(anchor(n+1)),2) = 0;
cmap(anchor(n)+1:(anchor(n+1)),3) = shadingU;

n = 2
shadingU = linspace(0,0.5,anchor(n+1)-anchor(n))
shadingD = linspace(cbott,1,anchor(n+1)-anchor(n))
cmap(anchor(n)+1:(anchor(n+1)),1) = 0;
cmap(anchor(n)+1:(anchor(n+1)),2) = shadingU;
cmap(anchor(n)+1:(anchor(n+1)),3) = 1;

n = 3
shadingU = linspace(0.5,1,anchor(n+1)-anchor(n))
shadingD = linspace(cbott,1,anchor(2)-anchor(1))
cmap(anchor(n)+1:(anchor(n+1)),1) = 0;
cmap(anchor(n)+1:(anchor(n+1)),2) = shadingU;
cmap(anchor(n)+1:(anchor(n+1)),3) = 1;

n = 4
shadingU = linspace(0,0.5,anchor(n+1)-anchor(n))
shadingD = linspace(1,0.5,anchor(n+1)-anchor(n))
cmap(anchor(n)+1:(anchor(n+1)),1) = shadingU;
cmap(anchor(n)+1:(anchor(n+1)),2) = 1;
cmap(anchor(n)+1:(anchor(n+1)),3) = shadingD;

n = 5
shadingU = linspace(0.5,1,anchor(n+1)-anchor(n))
shadingD = linspace(0.5,0,anchor(n+1)-anchor(n))
cmap(anchor(n)+1:(anchor(n+1)),1) = shadingU;
cmap(anchor(n)+1:(anchor(n+1)),2) = 1;
cmap(anchor(n)+1:(anchor(n+1)),3) = shadingD;

n = 6
shadingU = linspace(0.5,1,anchor(n+1)-anchor(n))
shadingD = linspace(1,0.5,anchor(n+1)-anchor(n))
cmap(anchor(n)+1:(anchor(n+1)),1) = 1;
cmap(anchor(n)+1:(anchor(n+1)),2) = shadingD;
cmap(anchor(n)+1:(anchor(n+1)),3) = 0;

n = 7
shadingU = linspace(0.5,1,anchor(n+1)-anchor(n))
shadingD = linspace(0.5,0,anchor(n+1)-anchor(n))
cmap(anchor(n)+1:(anchor(n+1)),1) = 1;
cmap(anchor(n)+1:(anchor(n+1)),2) = shadingD;
cmap(anchor(n)+1:(anchor(n+1)),3) = 0;

n = 8
shadingU = linspace(0.5,1,anchor(n+1)-anchor(n))
shadingD = linspace(1,0.5,anchor(n+1)-anchor(n))
cmap(anchor(n)+1:(anchor(n+1)),1) = shadingD;
cmap(anchor(n)+1:(anchor(n+1)),2) = 0;
cmap(anchor(n)+1:(anchor(n+1)),3) = 0;



colormap(F2,cmap)

subplot(212)
plot(cmap(:,1),'r','LineWidth',2), hold on, plot(cmap(:,2),'g'), plot(cmap(:,3),'b')

%% 2nd Recreating the 'jet' colormap

F3 = figure
subplot(211)
scatter(lon,lat,log(Magnitude+min(Magnitude)+1)*15,DateTime)
title('My 2nd attempt to re-create the jet color map')


c = colorbar
colormap(F3,'gray')

cmap = colormap(F3)
cmap(:,:) = nan;

anchor = [8 16 24 32 40 48 56 64] % this is the last digit of the value that belongs to the set

red = nan(64,1)
red(1:anchor(3)) = 0
red(anchor(3)+1:anchor(5)) = linspace(0,1,anchor(5)-anchor(3))
red(anchor(5)+1:anchor(7)) = 1;
red(anchor(7)+1:anchor(8)) = linspace(1,0.5,anchor(8)-anchor(7))

green = nan(64,1)
green(1:anchor(1)) = 0
green(anchor(1)+1:anchor(3)) = linspace(0,1,anchor(3)-anchor(1))
green(anchor(3)+1:anchor(5)) = 1
green(anchor(5)+1:anchor(7)) = linspace(1,0,anchor(7)-anchor(5))
green(anchor(7)+1:anchor(8)) = 0

blue = nan(64,1)
blue(1:anchor(1)) = linspace(0.5,1,anchor(1)-0)
blue(anchor(1)+1:anchor(3)) = 1
blue(anchor(3)+1:anchor(5)) = linspace(1,0,anchor(5)-anchor(3))
blue(anchor(5)+1:anchor(8)) = 0

cmap(:,1) = red;
cmap(:,2) = green;
cmap(:,3) = blue;



colormap(F3,cmap)

subplot(212)
plot(cmap(:,1),'r','LineWidth',2), hold on, plot(cmap(:,2),'g'), plot(cmap(:,3),'b')


%% plot the jet schema

% cmapjet = colormap('jet')
% figure
% plot(cmap2(:,1),'r'), hold on, plot(cmap2(:,2),'g'), plot(cmap2(:,3),'b')

