%% Ū��CTD��Ƨ��̪��Ҧ��ɮ�
clear;clc;clf
cd('.\CTD') % �]�w�ɮ׸��|

a=dir; %�b��Ƨ������X�Ҧ��ɮ�
%% ��CTD��Ƨ�Ū���S��S�}�Y����ơA����Ū�iMatlab
% load 1-1.cnv ~ 8-1.cnv
for i = 3:10 
    filename = a(i).name;
    fid = fopen(filename,'r') %Ū��
    while strcmp(fgetl(fid),'*END*') == 0
    %�@��@��Ū����ơA����Ū����'*END*'�r�ꬰ��
        isEND = feof(fid); %�����ɮ׬O�_�wŪ���쥽��(�O�^��1�A�_�^��0)
    end
    ctd_row = fscanf(fid,'%f'); %����e�������Ū�����_�I�A�~�򩹤UŪ���ɮ�fid�̪����
                            %�åB�o��@�Ӧ�V�q
    ctd{i-2} = reshape(ctd_row,8,length(ctd_row)/8)'; %�X�����ɮױƧ��ܦ�(3-2)~(10-2)
    fclose(fid);
end
%% s1-1.cnv ~ s8-1.cnv
as=dir('s*');
for i = 1:8
    filename2 = as(i).name;
    fid2 = fopen(filename2,'r')
    while strcmp(fgetl(fid2),'*END*') == 0
    %�@��@��Ū����ơA����Ū����'*END*'�r�ꬰ��
        isEND2 = feof(fid2); %�����ɮ׬O�_�w�gŪ���쥽��(�O�^��1�A�_�^��0)
    end
    ctd_row2 = fscanf(fid,'%f'); %����e�������Ū�����_�I�A�~�򩹤UŪ���ɮ�fid�̪����
                            %�åB�o��@�Ӧ�V�q
    ctd_s{i} = reshape(ctd_row2,8,length(ctd_row2)/8)';
    fclose(fid2);
end
% c1_1_s = ctd_s{1};
% c2_1_s = ctd_s{2};
% c3_1_s = ctd_s{3};
% c4_1_s = ctd_s{4};
% c5_1_s = ctd_s{5};
% c6_1_s = ctd_s{6};
% c7_1_s = ctd_s{7};
% c8_1_s = ctd_s{8};
%% �U�����g�n��
lon(1,1) = 121 + 47.66/60;lat(1,1) = 25 + 11.29/60; % 1-1 ���g�n��
lon(2,1) = 121 + 47.88/60;lat(2,1) = 25 + 11.80/60;
lon(3,1) = 121 + 47.88/60;lat(3,1) = 25 + 12.34/60;
lon(4,1) = 121 + 46.89/60;lat(4,1) = 25 + 12.52/60;
lon(5,1) = 121 + 46.99/60;lat(5,1) = 25 + 12.91/60;
lon(6,1) = 121 + 46.42/60;lat(6,1) = 25 + 12.52/60;
lon(7,1) = 121 + 46.04/60;lat(7,1) = 25 + 12.17/60;
lon(8,1) = 121 + 45.80/60;lat(8,1) = 25 + 11.72/60;
LONLIM1 = 121.7:0.05:121.87 ; LATLIM1 = 25.1:0.05:25.25; % �e�Ϫ��g�n�׽d�򭭨�
location_color = {[1 0 0],[0 1 0],[0 0 1],[1 1 0],[1 0 1],[0 1 1],...
    [0.8500 0.3250 0.0980],...
    [0 0 0]}
%% all . cnv  CTD�W�U����
for i = 1:8
%     isint(1)=nan;isint(2)=nan;
%     isint(i) = find(isinteger(ctd{i}(:,1))); % c2_1 ���`�׸�ƨS����ƫ��A
    for j=1:fix(max(ctd{i}(:,1))+1) %�`�׸�ƪ���w
    
        dp{j} = find(ctd{i}(:,1) > (j-1) & ctd{i}(:,1) < j);
        %�`�׸�� : �C�Ӳ`��j�����H1��@���j�A�s���dp��
%         dpdp{i,j} = dp{j,1};
        avg_T(i,j) = mean(ctd{i}(dp{j},4)); %�S�w�`�׽d�򪺥����ū�
        avg_S(i,j) = mean(ctd{i}(dp{j},5)); %�S�w�`�׽d�򪺥����Q��

    end
    figure(1)
    dep{i,1} = (1:fix(max(ctd{i}(:,1))+1))';
    subplot(2,2,1) %CTD�W�U�������
    [ax,h11,h12] = plotyy(dep{i,1},avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        dep{i,1},avg_S(i,1:fix(max(ctd{i}(:,1))+1)))
    % ax = gca
    set(gca,'View',[90 90]) % �վ���y�Ϫ���쨤�B����
    set(get(ax(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
%     ax.XTickLabelRotation = 45
%     ax.XTick = 1:1:max(ctd{i}(:,1))
    subplot(2,2,2) % �W���P�U�񪺸��
    [ax2,h21,h22] = plotyy(ctd_s{i}(:,1),ctd_s{i}(:,4),ctd_s{i}(:,1),ctd_s{i}(:,5));
    set(gca,'View',[90 90],'tickdir','out') % �վ�϶b����쨤�B����
    set(get(ax2(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax2(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
    subplot(2,2,3) % �K�׵����u�B���Q��
    S{i,1} = linspace(min(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
    % �q�����Q�ת��̤j�ȻP�̤p�Ȥ����A�гydep{i,1}(end)����Ʀs���S{i,1}
    T{i,1} = linspace(min(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
    % �q�����ūת��̤j�ȻP�̤p�Ȥ����A�гydep{i,1}(end)����Ʀs���T{i,1}
    [SS{i,1},TT{i,1}] = meshgrid(S{i,1},T{i,1});
    sigma{i,1} = den_CTD(SS{i,1},TT{i,1},1.01325+dep{i}*(1.01325*1/10))-1000; % �禡 den_CTD
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %ø�s����K�׽u
    clabel(c1,h1);hold on %��ܼƭ�
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k:','LineWidth',2);hold off
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

    print(['D-T_T-S_diagram_' num2str(i) '-1_forloop'],'-dpng')
end
%% all . cnv  CTD �U�񥭧�
for i = 1:8
%     isint(1)=nan;isint(2)=nan;
%     isint(i) = find(isinteger(ctd{i}(:,1))); % c2_1 ���`�׸�ƨS����ƫ��A
    down_max = find(ctd{i}(:,1)==max(ctd{i}(:,1))); % ���`�׸�Ƥ��̤j�Ȫ����ޭ�
    %�]���o�쪺�̤j�ȥi�ण�u�@��(�i�୫��)�A�ҥH�N�o�쪺�̤j�ȯ��ޭȦs���down_max��
    %�A���Xdown_max���Ĥ@�ӭȵ�down_ctd(i,1)�s��
    down_ctd(i,1) = down_max(1); %�Ĥ@�ӳ̤j�Ȫ����ޭ�
    for j=1:fix(max(ctd{i}(:,1))+1)
    
        dp_down{j} = find(ctd{i}(1:down_ctd(i,1),1) > (j-1) &...
            ctd{i}(1:down_ctd(i,1),1) < j);
%         dpdp{i,j} = dp{j,1};
        avg_Tdown(i,j) = mean(ctd{i}(dp_down{j},4));
        avg_Sdown(i,j) = mean(ctd{i}(dp_down{j},5));

    end
    figure(2)
    dep_down{i,1} = (1:1:fix(max(ctd{i}(:,1))+1))';
    subplot(2,2,1)
    [ax,h11,h12] = plotyy(dep_down{i,1},avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        dep_down{i,1},avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)))
    % ax = gca
    set(gca,'View',[90 90]) % �վ���y�Ϫ���쨤�B����
    set(get(ax(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
%     subplot(2,2,2)
%     [ax2,h21,h22] = plotyy(ctd_s{i}(:,1),ctd_s{i}(:,4),ctd_s{i}(:,1),ctd_s{i}(:,5));
%     set(gca,'View',[90 90],'tickdir','out') % �վ�϶b����쨤�B����
%     set(get(ax2(1),'Ylabel'),'String','Temperature (^oC)');
%     set(get(ax2(2),'Ylabel'),'String','Salinity (psu)');
%     xlabel('depth (m)');
    subplot(2,2,3) % �K�׵����u�B���Q��
    Sdown{i,1} = linspace(min(avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1))),...
        max(avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1))),dep_down{i,1}(end));
    Tdown{i,1} = linspace(min(avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1))),...
        max(avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1))),dep_down{i,1}(end));
    [SSdown{i,1},TTdown{i,1}] = meshgrid(Sdown{i,1},Tdown{i,1});
    sigma_down{i,1} = den_CTD(SSdown{i,1},TTdown{i,1},1.01325+dep_down{i}*(1.01325*1/10))-1000; % �禡 den_CTD
    [c1,h1]=contour(SSdown{i,1},TTdown{i,1},sigma_down{i,1});
    clabel(c1,h1);hold on
    plot(avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,down)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    subplot(2,2,2)
    m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % ø�s����(�զ�)
    ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,...
        'MarkerFaceColor','b')
    m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %ø�s���a

    m_grid('linewi',2,'linestyle','none','tickdir','out',...
            'xtick',LONLIM1,'ytick',LATLIM1,...
            'XaxisLocation','bottom','YaxisLocation','left');

    title([num2str(i) '-1 Location (down)']);

        
    subplot(2,2,4) % �K�׵����u�B���Q��
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %ø�s����K�׽u
    clabel(c1,h1);hold on %��ܼƭ�
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,mean)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    
    print(['down_mean_D-T_T-S_diagram_' num2str(i) '-1_forloop'],'-dpng')
end
%% all . cnv  CTD �W������
for i = 1:8
%     isint(1)=nan;isint(2)=nan;
%     isint(i) = find(isinteger(ctd{i}(:,1))); % c2_1 ���`�׸�ƨS����ƫ��A
    up_max = find(ctd{i}(:,1)==max(ctd{i}(:,1))); % ���`�׸�Ƥ��̤j�Ȫ����ޭ�
    %�]���o�쪺�̤j�ȥi�ण�u�@��(�i�୫��)�A�ҥH�N�o�쪺�̤j�ȯ��ޭȦs���up_max��
    %�A���Xup_max���Ĥ@�ӭȵ�up_ctd(i,1)�s��
    up_ctd(i,1) = up_max(1); %�Ĥ@�ӳ̤j�Ȫ����ޭ�
    for j=1:fix(max(ctd{i}(:,1))+1)
    
        dp_up{j} = find(ctd{i}((up_ctd(i,1)+1):end,1) > (j-1) &...
            ctd{i}((up_ctd(i,1)+1):end,1) < j);
%         dpdp{i,j} = dp{j,1};
        avg_Tup(i,j) = mean(ctd{i}(dp_up{j},4));
        avg_Sup(i,j) = mean(ctd{i}(dp_up{j},5));

    end
    figure(3)
    dep_up{i,1} = (1:1:fix(max(ctd{i}(:,1))+1))';
    subplot(2,2,1)
    [ax,h11,h12] = plotyy(dep_up{i,1},avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        dep_up{i,1},avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)))
    % ax = gca
    set(gca,'View',[90 90]) % �վ���y�Ϫ���쨤�B����
    set(get(ax(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
    
    subplot(2,2,3) % �K�׵����u�B���Q��
    Sup{i,1} = linspace(min(avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1))),...
        max(avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1))),dep_up{i,1}(end));
    Tup{i,1} = linspace(min(avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1))),...
        max(avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1))),dep_up{i,1}(end));
    [SSup{i,1},TTup{i,1}] = meshgrid(Sup{i,1},Tup{i,1});
    sigma_up{i,1} = den_CTD(SSup{i,1},TTup{i,1},1.01325+dep_up{i}*(1.01325*1/10))-1000; % �禡 den_CTD
    [c1,h1]=contour(SSup{i,1},TTup{i,1},sigma_up{i,1});
    clabel(c1,h1);hold on
    plot(avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,up)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    subplot(2,2,2)
    m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % ø�s����(�զ�)
    ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,...
        'MarkerFaceColor','b')
    m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %ø�s���a

    m_grid('linewi',2,'linestyle','none','tickdir','out',...
            'xtick',LONLIM1,'ytick',LATLIM1,...
            'XaxisLocation','bottom','YaxisLocation','left');

    title([num2str(i) '-1 Location (up)']);
    
    subplot(2,2,4) % �K�׵����u�B���Q��
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %ø�s����K�׽u
    clabel(c1,h1);hold on %��ܼƭ�
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,mean)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');


    print(['up_mean_D-T_T-S_diagram_' num2str(i) '-1_forloop'],'-dpng')
end
%% all . cnv  CTD �W���P�U��H�Υ��������
for i = 1:8
    figure(4)
    subplot(1,3,1)
    [c1,h1] = contour(SSdown{i,1},TTdown{i,1},sigma_down{i,1});
    clabel(c1,h1);hold on
    plot(avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,down)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');
    
    subplot(1,3,2) % �K�׵����u�B���Q��
    [c1,h1]=contour(SSup{i,1},TTup{i,1},sigma_up{i,1});
    clabel(c1,h1);hold on
    plot(avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,up)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');
    
    subplot(1,3,3) % �K�׵����u�B���Q��
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %ø�s����K�׽u
    clabel(c1,h1);hold on %��ܼƭ�
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,mean)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    print(['T-S_diagram_' num2str(i) '-1_compare'],'-dpng')
end
%% ��ū��Q�ױK�ת���ư������A�̫ᥭ���X�Ӫ���ƼƷ|�M��Ӥ@��

%% ��contour�esigma(�K��)

%% ���X�C�@�Ӵ�����T-S diagram

%% �Q�θg�n�ת���Ƶe�X�������Ҧb�I�b�a�ϤW
figure(5)
LONLIM2 = 121.65:0.05:121.92;LATLIM2 = 25.1:0.05:25.25;
m_proj('miller','lon',[LONLIM2(1) LONLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % ø�s����(�զ�)
ctd11 = m_plot(lon(1,1),lat(1,1),'Marker','.','Markersize',10,'MarkerFaceColor','r')
hold on
ctd21 = m_plot(lon(2,1),lat(2,1),'Marker','.','Markersize',10,'MarkerFaceColor','g')
hold on
ctd31 = m_plot(lon(3,1),lat(3,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
hold on
ctd41 = m_plot(lon(4,1),lat(4,1),'Marker','.','Markersize',10,'MarkerFaceColor',[1 1 0])
hold on
ctd51 = m_plot(lon(5,1),lat(5,1),'Marker','.','Markersize',10,'MarkerFaceColor',[1 0 1])
hold on
ctd61 = m_plot(lon(6,1),lat(6,1),'Marker','s','Markersize',8,'MarkerFaceColor',[0 1 1])
hold on
ctd71 = m_plot(lon(7,1),lat(7,1),'Marker','s','Markersize',8,'MarkerFaceColor',[0.8500 0.3250 0.0980])
hold on
ctd81 = m_plot(lon(8,1),lat(8,1),'Marker','s','Markersize',8,'MarkerFaceColor',[0 0 0])
% m_line(plon_sub,plat_sub,'Marker','.')
% m_gshhs_c('patch',[1 1 1]);
%m_coast('patch',[.1 .1 .1],'edgecolor','k');
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %ø�s���a

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM2,'ytick',LATLIM2,...
        'XaxisLocation','bottom','YaxisLocation','left');
legend([ctd11,ctd21,ctd31,ctd41,ctd51,ctd61,ctd71,ctd81]...
    ,'1-1( 47m)','2-1(111m)','3-1(121m)','4-1(102m)','5-1(101m)','6-1( 92m)','7-1( 65m)','8-1( 46m)')
title('Location of CTD','FontName','times','FontSize',15);
xlabel('    Longtitude');ylabel('Latitude');
print('Location_CTD','-dpng')
%% T-S diagram(�ѤW�U�����ұo�쪺���ø�s)
figure(6)
% avg_S = sum()
% [SS,TT] = meshgrid(avg1_S,avg1_T);
% sigma1 = den_CTD(SS1,TT1,1+dep11*(1/10))-1000;
% [c1,h1]=contour(SS1,TT1,sigma1);
% clabel(c1,h1);
% hold on

TS1 = plot(avg_S(1,1:fix(max(ctd{1}(:,1))+1)),avg_T(1,1:fix(max(ctd{1}(:,1))+1)),'r:','LineWidth',2);hold on
TS2 = plot(avg_S(2,1:fix(max(ctd{2}(:,1))+1)),avg_T(2,1:fix(max(ctd{2}(:,1))+1)),'g:','LineWidth',2);hold on
TS3 = plot(avg_S(3,1:fix(max(ctd{3}(:,1))+1)),avg_T(3,1:fix(max(ctd{3}(:,1))+1)),'b:','LineWidth',2);hold on
TS4 = plot(avg_S(4,1:fix(max(ctd{4}(:,1))+1)),avg_T(4,1:fix(max(ctd{4}(:,1))+1)),'y:','LineWidth',2);hold on
TS5 = plot(avg_S(5,1:fix(max(ctd{5}(:,1))+1)),avg_T(5,1:fix(max(ctd{5}(:,1))+1)),'m:','LineWidth',2);hold on
TS6 = plot(avg_S(6,1:fix(max(ctd{6}(:,1))+1)),avg_T(6,1:fix(max(ctd{6}(:,1))+1)),'c:','LineWidth',2);hold on
TS7 = plot(avg_S(7,1:fix(max(ctd{7}(:,1))+1)),avg_T(7,1:fix(max(ctd{7}(:,1))+1)),':','Color',[0.8500 0.3250 0.0980],'LineWidth',2);hold on
TS8 = plot(avg_S(8,1:fix(max(ctd{8}(:,1))+1)),avg_T(8,1:fix(max(ctd{8}(:,1))+1)),':','Color',[0 0 0],'LineWidth',2);
hold on
% �K�׵����u
x12 = xlim;
y12 = ylim;
S2 = linspace(x12(1),x12(end),121);
T2 = linspace(y12(1),y12(end),121);
[SS2,TT2] = meshgrid(S2,T2);
sigma2 = den_CTD(SS2,TT2,1.01325+dep{3}*(1.01325*1/10))-1000;
[cc,hh] = contour(SS2,TT2,sigma2);
clabel(cc,hh);
hold off

% get(gca)

title('\it T-S diagram','FontName','times','FontSize',15);
xlabel('Salinity (psu)');ylabel('Temperature (^oC)');
legend([TS1,TS2,TS3,TS4,TS5,TS6,TS7,TS8],'1-1','2-1','3-1','4-1','5-1','6-1','7-1','8-1')
print('T-S_diagram_all_forloop','-dpng')