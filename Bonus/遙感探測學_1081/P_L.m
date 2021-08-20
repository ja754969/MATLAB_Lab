clear;clc;clf
h = 6.626*(10^-34);  % 普朗克常數  千克/米2/秒-1
k = 1.38*(10^-23);   % 波茲曼常數
c = 3*(10^8);        % 光速
c1 = 2*pi*h*(c^2)*10^16;
c2 = 10^6*h*c./k;
% len = linspace(0.1,100,3000); % 波長
len = linspace(0.1,100,3000); % 波長
t = [6000 4000 3000 2000 1000 500 300];
lenmu = len.*(10^6);
for i = 1:length(t)
    Mlen = c1./((len.^5).*(exp(c2./(t(i).*len))-1)); % gives the result in W/m2/um x 1e8
%     Mlen{i} = (3.74177153*((10^-16)^2))./((exp(h*1.438777*(10^-2)./(k.*t(i).*len)))-1)./(len.^5);
%     semilogx(lenmu,Mlen{i})
%     semilogy(lenmu,Mlen{i})
    loglog(len,Mlen*10^8);
%     plot(lenmu,Mlen{i})
    hold on
end
axis([0.1 100 1 10^9])

title('Planck''s Law')
ylabel(['Spectral radiant exitance,M_λ' '(Wm^-^2' 'μm^-^1)'])
xlabel('Wavelength(μm)')
%3.74177153*10^-16     1.438777*10^-2
legend('6000K','5000K','4000K','3000K','2000K','1000K','Location','best')