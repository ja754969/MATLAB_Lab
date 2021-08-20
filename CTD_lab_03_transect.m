%% Ū��CTD��Ƨ��̪��Ҧ��ɮ�
clear;clc;clf
cd('.\CTD') % �]�w�ɮ׸��|

a=dir; %�b��Ƨ������X�Ҧ��ɮ�
%% ��CTD��Ƨ�Ū���S��S�}�Y����ơA����Ū�iMatlab
% load 1-1.cnv ~ 8-1.cnv
for i = 3:10 
    filename = a(i).name;
    fid = fopen(filename,'r')%Ū��
    while strcmp(fgetl(fid),'*END*') == 0
    %�@��@��Ū����ơA����Ū����'*END*'�r�ꬰ��
        isEND = feof(fid); %�����ɮ׬O�_�HŪ���쥽��(�O�^��1�A�_�^��0)
    end
    ctd_row = fscanf(fid,'%f'); %����e�������Ū�����_�I�A�~�򩹤UŪ���ɮ�fid�̪����
                            %�åB�o��@�Ӧ�V�q
    ctd{i-2} = reshape(ctd_row,8,length(ctd_row)/8)'; %(3-2)~(10-2)
    fclose(fid);
end
%% s1-1.cnv ~ s8-1.cnv
as=dir('s*');
for i = 1:8
    filename2 = as(i).name;
    fid2 = fopen(filename2,'r')
    while strcmp(fgetl(fid2),'*END*') == 0
    %�@��@��Ū����ơA����Ū����'*END*'�r�ꬰ��
        isEND2 = feof(fid2); %�����ɮ׬O�_�HŪ���쥽��(�O�^��1�A�_�^��0)
    end
    ctd_row2 = fscanf(fid,'%f'); %����e�������Ū�����_�I�A�~�򩹤UŪ���ɮ�fid�̪����
                            %�åB�o��@�Ӧ�V�q
    ctd_s{i} = reshape(ctd_row2,8,length(ctd_row2)/8)';
    fclose(fid2);
end
%% �U�����g�n��
lon(1,1) = 121 + 47.66/60;lat(1,1) = 25 + 11.29/60; % 1-1 ���g�n��
lon(2,1) = 121 + 47.88/60;lat(2,1) = 25 + 11.80/60;
lon(3,1) = 121 + 47.88/60;lat(3,1) = 25 + 12.34/60;
lon(4,1) = 121 + 46.89/60;lat(4,1) = 25 + 12.52/60;
lon(5,1) = 121 + 46.99/60;lat(5,1) = 25 + 12.91/60;
lon(6,1) = 121 + 46.42/60;lat(6,1) = 25 + 12.52/60;
lon(7,1) = 121 + 46.04/60;lat(7,1) = 25 + 12.17/60;
lon(8,1) = 121 + 45.80/60;lat(8,1) = 25 + 11.72/60;
LONLIM1 = 121.7:0.05:121.87;LATLIM1 = 25.1:0.05:25.25; % �e�Ϫ��d�򭭨�
location_color = {[1 0 0],[0 1 0],[0 0 1],[1 1 0],[1 0 1],[0 1 1],[0.8500 0.3250 0.0980],[0 0 0]}
%% 1-1 ~ 8-1.cnv  CTD�W�U����
for i = 1:8
%     isint(1)=nan;isint(2)=nan;
%     isint(i) = find(isinteger(ctd{i}(:,1))); % c2_1 ���`�׸�ƨS����ƫ��A
    for j=1:fix(max(ctd{i}(:,1))+1)
    
        dp{j} = find(ctd{i}(:,1) > (j-1) & ctd{i}(:,1) < j); %�C�Ӵ������`�׸�Ư��ޭ�
%         dpdp{i,j} = dp{j,1};
        avg_T(i,j) = mean(ctd{i}(dp{j},4)); %�N�U�������ūפ@�C�@�C�x�s�b�x�}avg_T
        avg_S(i,j) = mean(ctd{i}(dp{j},5)); %�N�U�������Q�פ@�C�@�C�x�s�b�x�}avg_S
        avg_D(i,j) = mean(ctd{i}(dp{j},6)); %�N�U�������K�פ@�C�@�C�x�s�b�x�}avg_D
    end
    figure(1)
    dep{i,1} = (1:fix(max(ctd{i}(:,1))+1))'; %�C�Ӵ������`�׸��
    subplot(2,2,1) %CTD�W�U�������(�ϥ� 1-1 ~ 8-1 )
    [ax,h11,h12] = plotyy(dep{i,1},avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        dep{i,1},avg_S(i,1:fix(max(ctd{i}(:,1))+1)))
    % ax = gca
    set(gca,'View',[90 90]) % �վ���y�Ϫ���쨤�B����
    set(get(ax(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
%     ax.XTickLabelRotation = 45
%     ax.XTick = 1:1:max(ctd{i}(:,1))
    subplot(2,2,2) % �W���P�U�񪺸��(�ϥ� s1-1 ~ s8-1 )
    [ax2,h21,h22] = plotyy(ctd_s{i}(:,1),ctd_s{i}(:,4),ctd_s{i}(:,1),ctd_s{i}(:,5));
    set(gca,'View',[90 90],'tickdir','out') % �վ�϶b����쨤�B����
    set(get(ax2(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax2(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
    subplot(2,2,3) % �K�׵����u�B���Q��
    S{i,1} = linspace(min(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
    %�N�U�������Q�׸��avg_S(i,1:fix(max(ctd{i}(:,1))+1)))�ѳ̤p��̤j���ͤ@�Ӫ��׬�dep{i,1}(end)���M�}�C
    T{i,1} = linspace(min(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
    %�N�U�������ū׸��avg_T(i,1:fix(max(ctd{i}(:,1))+1)))�ѳ̤p��̤j���ͤ@�Ӫ��׬�dep{i,1}(end)���M�}�C
    [SS{i,1},TT{i,1}] = meshgrid(S{i,1},T{i,1});
    sigma{i,1} = den_CTD(SS{i,1},TT{i,1},1.01325+dep{i}*(1.01325*1/10))-1000; % �禡 den_CTD
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %ø�s����K�׽u
    clabel(c1,h1);hold on %��ܼƭ�
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    subplot(2,2,4)
    m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % ø�s����(�զ�)
    ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,...
        'MarkerFaceColor','b')
    m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %ø�s���a

    m_grid('linewi',2,'linestyle','none','tickdir','out',...
            'xtick',LONLIM1,'ytick',LATLIM1,...
            'XaxisLocation','bottom','YaxisLocation','left');

    title([num2str(i) '-1 Location']);

%     print(['D-T_T-S_diagram_' num2str(i) '-1_forloop'],'-dpng')
end
%% �Q��CTD_lab����ư��X�šB�Q�B�K�׭孱��(1-1�B2-1�B3-1 �����孱)
% �ϥ�contour
% Y �b : �`��(m)
% X �b : ������m(�������Z��)(m)
% �����u : �ūסB�Q�סB����K��
figure(2) % 1-1�B2-1�B3-1 �����孱
subplot(2,2,1)
t1dep = 1:121; % ø�ϲ`��
% t1dep = 1:47; % ø�ϲ`��
% t1ctd = [avg_T(1,:)' avg_T(2,:)' avg_T(3,:)']
% t1ctd(t1ctd==0)=nan;
t1ctd = [[avg_T(1,:)';zeros(length(t1dep)-length(avg_T(1,:)),1)] ...
    [avg_T(2,:)';zeros(length(t1dep)-length(avg_T(2,:)),1)] ...
    [avg_T(3,:)';zeros(length(t1dep)-length(avg_T(3,:)),1)]]; %���X�ū׸��
t1ctd(t1ctd==0)=nan;

% t1ctd = [avg_T(1,1:47)' avg_T(2,1:47)' avg_T(3,1:47)'];

t1lat = [lat(1,1) lat(2,1) lat(3,1)];
[tLAT,tD1] = meshgrid(t1lat,t1dep);
contourf(tD1,tLAT,t1ctd,45); %ø�s�ū׭孱
shading interp
% get(gca)
set(gca,'View',[90 90]) % �վ�϶b����쨤�B����
colormap('jet')
cp = colorbar('Direction','normal',...
    'Ticks',[fix(min(min(t1ctd))):1:max(max(t1ctd))]);
cp.Label.String = 'Temperature(^oC)';
title('Temperature Profile(1,2,3)','FontName','times','FontSize',10);

subplot(2,2,2)
s1ctd = [[avg_S(1,:)';zeros(length(t1dep)-length(avg_S(1,:)),1)] ...
    [avg_S(2,:)';zeros(length(t1dep)-length(avg_S(2,:)),1)] ...
    [avg_S(3,:)';zeros(length(t1dep)-length(avg_S(3,:)),1)]]; %���X�Q�׸��
s1ctd(s1ctd==0)=nan;
contourf(tD1,tLAT,s1ctd,45); %ø�s�ū׭孱
shading interp
% clabel(c3,h3)
% get(gca)
set(gca,'View',[90 90]) % �վ�϶b����쨤�B����
colormap('jet')
colorbar
cp2 = colorbar();
cp2.Label.String = 'Salinity(psu)';
title('Salinity Profile(1,2,3)','FontName','times','FontSize',10);

subplot(2,2,3)
d1ctd = [[avg_D(1,:)';zeros(length(t1dep)-length(avg_D(1,:)),1)] ...
    [avg_D(2,:)';zeros(length(t1dep)-length(avg_D(2,:)),1)] ...
    [avg_D(3,:)';zeros(length(t1dep)-length(avg_D(3,:)),1)]]; %���X�Q�׸��
d1ctd(d1ctd==0)=nan;
contourf(tD1,tLAT,d1ctd,45); %ø�s�ū׭孱
shading interp
% clabel(c4,h4)
% get(gca)
set(gca,'View',[90 90]) % �վ�϶b����쨤�B����
colormap('jet')
colorbar
cp3 = colorbar();
cp3.Label.String = 'Density(sigma-theta, kg/m^3)';
title('Density Profile(1,2,3)','FontName','times','FontSize',10);

subplot(2,2,4)
LONLIM2 = 121.65:0.05:121.92;LATLIM2 = 25.1:0.05:25.25;
m_proj('miller','lon',[LONLIM2(1) LONLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % ø�s����(�զ�)
ctd11 = m_plot(lon(1,1),lat(1,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{1});
hold on;
ctd21 = m_plot(lon(2,1),lat(2,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{2});
hold on;
ctd31 = m_plot(lon(3,1),lat(3,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{3});

m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %ø�s���a

% m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
%         'xtick',LONLIM2,'ytick',LATLIM2,...
%         'XaxisLocation','bottom','YaxisLocation','right');
m_grid('box','fancy');
legend([ctd11,ctd21,ctd31],'1-1( 47m)','2-1(111m)','3-1(121m)','Location','southeast');
title('Location of CTD(1,2,3)','FontName','times','FontSize',15);
% xlabel('    Longtitude');ylabel('Latitude');

print('Profile_1_2_3_ctd','-dpng')
%% �Q��CTD_lab����ư��X�šB�Q�B�K�׭孱��(5-1�B6-1�B7-1�B8-1 �����孱)
% �ϥ�contour
% Y �b : �`��(m)
% X �b : ������m(�������Z��)(m)
% �����u : �ūסB�Q�סB����K��
figure(3) % 5-1�B6-1�B7-1�B8-1 �����孱
subplot(2,2,1)
t2dep = 1:101; % ø�ϲ`��
% t1dep = 1:47; % ø�ϲ`��
% t1ctd = [avg_T(1,:)' avg_T(2,:)' avg_T(3,:)']
% t1ctd(t1ctd==0)=nan;
t2ctd = [[avg_T(5,1:101)';zeros(length(t2dep)-length(avg_T(5,1:101)),1)] ...
    [avg_T(6,1:101)';zeros(length(t2dep)-length(avg_T(6,1:101)),1)] ...
    [avg_T(7,1:101)';zeros(length(t2dep)-length(avg_T(7,1:101)),1)] ...
    [avg_T(8,1:101)';zeros(length(t2dep)-length(avg_T(8,1:101)),1)]]; %���X�ū׸��
t2ctd(t2ctd==0)=nan; %��t2ctd��0���ܬ�NAN��

% t1ctd = [avg_T(1,1:47)' avg_T(2,1:47)' avg_T(3,1:47)'];

t2lat = [lat(5,1) lat(6,1) lat(7,1) lat(8,1)];
[t2LAT,t2D1] = meshgrid(t2lat,t2dep);
contourf(t2D1,t2LAT,t2ctd,45); %ø�s�ū׭孱
shading interp
% clabel(c5,h5)
% get(gca)
set(gca,'View',[90 90],'tickdir','out') % �վ�϶b����쨤�B����
colormap('jet')
cp4 = colorbar('Direction','normal',...
    'Ticks',[fix(min(min(t2ctd))):1:max(max(t2ctd))]);
cp4.Label.String = 'Temperature(^oC)';
title('Temperature Profile(5,6,7,8)','FontName','times','FontSize',10);

subplot(2,2,2)
s2ctd = [[avg_S(5,1:length(t2dep))';zeros(length(t2dep)-length(avg_S(5,1:length(t2dep))),1)]...
    [avg_S(6,1:length(t2dep))';zeros(length(t2dep)-length(avg_S(6,1:length(t2dep))),1)] ...
    [avg_S(7,1:length(t2dep))';zeros(length(t2dep)-length(avg_S(7,1:length(t2dep))),1)] ...
    [avg_S(8,1:length(t2dep))';zeros(length(t2dep)-length(avg_S(8,1:length(t2dep))),1)]]; %���X�Q�׸��
s2ctd(s2ctd==0)=nan;
contourf(t2D1,t2LAT,s2ctd,45); %ø�s�Q�׭孱
shading interp
% clabel(c6,h6)
% get(gca)
set(gca,'View',[90 90]) % �վ�϶b����쨤�B����
colormap('jet')
colorbar
cp5 = colorbar('Direction','normal');
cp5.Label.String = 'Salinity(psu)';
title('Salinity Profile(5,6,7,8)','FontName','times','FontSize',10);

subplot(2,2,3)
d2ctd = [[avg_D(5,1:length(t2dep))';zeros(length(t2dep)-length(avg_D(5,1:length(t2dep))),1)] ...
    [avg_D(6,1:length(t2dep))';zeros(length(t2dep)-length(avg_D(6,1:length(t2dep))),1)] ...
    [avg_D(7,1:length(t2dep))';zeros(length(t2dep)-length(avg_D(7,1:length(t2dep))),1)] ...
    [avg_D(8,1:length(t2dep))';zeros(length(t2dep)-length(avg_D(8,1:length(t2dep))),1)]]; %���X�Q�׸��
d2ctd(d2ctd==0)=nan;
contourf(t2D1,t2LAT,d2ctd,45); %ø�s�K�׭孱
shading interp
% clabel(c7,h7)
% get(gca)
set(gca,'View',[90 90]) % �վ�϶b����쨤�B����
colormap('jet')
colorbar
cp6 = colorbar('Direction','normal');
cp6.Label.String = 'Density(sigma-theta, kg/m^3)';
title('Density Profile(5,6,7,8)','FontName','times','FontSize',10);

subplot(2,2,4)
LONLIM2 = 121.65:0.05:121.92;LATLIM2 = 25.1:0.05:25.25;
m_proj('miller','lon',[LONLIM2(1) LONLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % ø�s����(�զ�)
ctd51 = m_plot(lon(5,1),lat(5,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{5})
hold on
ctd61 = m_plot(lon(6,1),lat(6,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{6})
hold on
ctd71 = m_plot(lon(7,1),lat(7,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{7})
hold on
ctd81 = m_plot(lon(8,1),lat(8,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{8})

m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %ø�s���a

% m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
%         'xtick',LONLIM2,'ytick',LATLIM2,...
%         'XaxisLocation','bottom','YaxisLocation','right');
m_grid('box','fancy');
legend([ctd51,ctd61,ctd71,ctd81],'5-1(101m)','6-1( 92m)','7-1( 65m)','8-1( 46m)','Location','southeast');
title('Location of CTD(5,6,7,8)','FontName','times','FontSize',15);
% xlabel('    Longtitude');ylabel('Latitude');

print('Profile_5_6_7_8_ctd','-dpng')
%% �Q��CTD_lab����ư��X�šB�Q�B�K�׭孱��(3-1�B4-1�B6-1 �����孱)
% �ϥ�contour
% Y �b : �`��(m)
% X �b : ������m(�������Z��)(m)
% �����u : �ūסB�Q�סB����K��
figure(4) % 3-1�B4-1�B6-1 �����孱
subplot(2,2,1)
t3dep = 1:121; % ø�ϲ`��
% t1dep = 1:47; % ø�ϲ`��
% t1ctd = [avg_T(1,:)' avg_T(2,:)' avg_T(3,:)']
% t1ctd(t1ctd==0)=nan;
t3ctd = [[avg_T(3,1:length(t3dep))';zeros(length(t3dep)-length(avg_T(3,1:length(t3dep))),1)] ...
    [avg_T(4,1:length(t3dep))';zeros(length(t3dep)-length(avg_T(4,1:length(t3dep))),1)] ...
    [avg_T(6,1:length(t3dep))';zeros(length(t3dep)-length(avg_T(6,1:length(t3dep))),1)]]; %���X�ū׸��
t3ctd(t3ctd==0)=nan; %��t2ctd��0���ܬ�NAN��

% t1ctd = [avg_T(1,1:47)' avg_T(2,1:47)' avg_T(3,1:47)'];

t3lon = [lon(3,1) lon(4,1) lon(6,1)];
[t3LON,t3D1] = meshgrid(t3lon,t3dep);
contourf(t3D1,t3LON,t3ctd,35); %ø�s�ū׭孱
shading interp
% clabel(c5,h5)
% get(gca)
set(gca,'View',[90 90],'tickdir','out') % �վ�϶b����쨤�B����
colormap('jet')
cp4 = colorbar('Direction','normal',...
    'Ticks',[fix(min(min(t3ctd))):1:max(max(t3ctd))]);
cp4.Label.String = 'Temperature(^oC)';
title('Temperature Profile(3,4,6)','FontName','times','FontSize',10);

subplot(2,2,2)
s3ctd = [[avg_S(3,1:length(t3dep))';zeros(length(t3dep)-length(avg_S(3,1:length(t3dep))),1)]...
    [avg_S(4,1:length(t3dep))';zeros(length(t3dep)-length(avg_S(4,1:length(t3dep))),1)] ...
    [avg_S(6,1:length(t3dep))';zeros(length(t3dep)-length(avg_S(6,1:length(t3dep))),1)]]; %���X�Q�׸��
s3ctd(s3ctd==0)=nan;
contourf(t3D1,t3LON,s3ctd,35); %ø�s�Q�׭孱
% pcolor(t3D1,t3LON,s3ctd); %ø�s�Q�׭孱
shading interp
% clabel(c6,h6)
% get(gca)
set(gca,'View',[90 90]) % �վ�϶b����쨤�B����
colormap('jet')
colorbar
cp5 = colorbar();
cp5.Label.String = 'Salinity(psu)';
title('Salinity Profile(3,4,6)','FontName','times','FontSize',10);

subplot(2,2,3)
d3ctd = [[avg_D(3,1:length(t3dep))';zeros(length(t3dep)-length(avg_D(3,1:length(t3dep))),1)] ...
    [avg_D(4,1:length(t3dep))';zeros(length(t3dep)-length(avg_D(4,1:length(t3dep))),1)] ...
    [avg_D(6,1:length(t3dep))';zeros(length(t3dep)-length(avg_D(6,1:length(t3dep))),1)]]; %���X�Q�׸��
d3ctd(d3ctd==0)=nan;
contourf(t3D1,t3LON,d3ctd,35); %ø�s�K�׭孱
% pcolor(t3D1,t3LON,d3ctd); %ø�s�K�׭孱
shading interp
% clabel(c7,h7)
% get(gca)
set(gca,'View',[90 90]) % �վ�϶b����쨤�B����
colormap('jet')
colorbar
cp6 = colorbar('Direction','normal');
cp6.Label.String = 'Density(sigma-theta, kg/m^3)';
title('Density Profile(3,4,6)','FontName','times','FontSize',10);

subplot(2,2,4)
LONLIM2 = 121.65:0.05:121.92;LATLIM2 = 25.1:0.05:25.25;
m_proj('miller','lon',[LONLIM2(1) LONLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % ø�s����(�զ�)
ctd31 = m_plot(lon(3,1),lat(3,1),'Marker','.','Markersize',10,'MarkerFaceColor','y')
hold on
ctd41 = m_plot(lon(4,1),lat(4,1),'Marker','.','Markersize',10,'MarkerFaceColor','r')
hold on
ctd61 = m_plot(lon(6,1),lat(6,1),'Marker','.','Markersize',10,'MarkerFaceColor','g')

m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %ø�s���a

% m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
%         'xtick',LONLIM2,'ytick',LATLIM2,...
%         'XaxisLocation','bottom','YaxisLocation','right');
m_grid('box','fancy')
legend([ctd31,ctd41,ctd61],'3-1(121)','4-1(102m)','6-1( 92m)','Location','southeast');
title('Location of CTD(3,4,6)','FontName','times','FontSize',15);

print('Profile_3_4_6_ctd','-dpng')