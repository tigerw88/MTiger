function [ b, a, Mc, N_theo ] = bvalue1( Magnitude, confidence )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

conf = confidence;

X = [-1:0.02:4]; %bin centers Mw min max
N=hist(Magnitude,X); %
Ncum=fliplr(cumsum(fliplr(N)));f1=figure;
set(gcf,'PaperPositionMode','auto','Position',[100 100 400 300])
bar(X,N), hold on, grid on
axis([-1.0 4 0 50])
xlabel('Mag'), ylabel('Occurrences')

% conf = [0 4]; %magnitudes above this threshold are considered accurate
mask = X>conf(1) & X<conf(2) & Ncum>0;

P = polyfit(X(mask),log10(Ncum(mask)),1);
b = -P(1) %b from Gutenberg-Richter
a = P(2); %a from Gutenberg-Richter
Ncum_theo = 10.^(a-b*X); %Gutenberg-Richter law
N_theo = fliplr(diff(fliplr(Ncum_theo)));
Mc = (log10(Ncum(1))-P(2))/P(1) %intersection with observed cumulative distribution (magnitude of completeness)
figure(f1)

f3=figure;
set(gcf,'PaperPositionMode','auto','Position',[100 100 400 300])
h3=bar(X,log10(Ncum)); set(h3,'FaceColor',[0.75 0.75 0.75]), hold on, grid on
plot(X,log10(Ncum),'.b-')
xlim([min(X) max(X)]), ylim([-0.1 4.0])
xlabel('M_w'), ylabel('LOG10(Cumulative Occurences)')

plot(X,log10(Ncum_theo),'r--','LineWidth',2)
plot(X(mask),log10(Ncum_theo(mask)),'r','LineWidth',2)
plot([Mc Mc],[-0.1 P(1)*Mc+P(2)],'k--','LineWidth',2)
text(conf(1)+.1,3.8,['b=' num2str(b,2) ', Mc=' num2str(Mc,2)],'BackgroundColor','r')

end

