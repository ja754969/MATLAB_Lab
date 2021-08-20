%% Ū�� NC �ɮ�
clear;clc;clf
close  all;
% �ΰj��Ū�� (��Ū����)
cd('C:\201108_201505NSST') % �]�w�ɮ׸��|

a=dir('A*'); % * �N�� : �b��Ƨ������X���N�@�� A �}�Y���ɮ�
% a2 = struct2table(a);  %���i�H������table �A table �u�O��K�d��
%% �N�ɦW�ഫ����Ū�����
% mon = [201108:201112 201201:201212 201301:201312 201401:201412 201501:201505]';
for i = 1:2 %Ū����ƽd��
    %---------------------- Ū�� NC �ɮ�------------------------------------
    filename = a(i).name;
    %ncdisp(filename)
    nc_dump(filename); % nc_dump ���J�ɮ�
    %--------------�N�ɦW�ഫ����Ū�����(���O�������ɦW)---------------------
    sst = nc_varget(a(i).name,'sst');             % nc_varget ���X�ɮפ����ܼ� sst
    qual_sst = nc_varget(a(i).name,'qual_sst');   % nc_varget ���X�ɮפ����ܼ� qual_sst
    Sublat = nc_varget(a(i).name,'lat');          % nc_varget ���X�ɮפ����ܼ� lat
    Sublon = nc_varget(a(i).name,'lon');          % nc_varget ���X�ɮפ����ܼ� lon
    palette = nc_varget(a(i).name,'palette');     % nc_varget ���X�ɮפ����ܼ� palette
    
    s1 = a(i).name(2:8);
    t = datetime(s1,'InputFormat','uuuuDDD');
    n = datestr(t,'yyyy-mm');
%     a2.name{i}=['A' num2str(mon(i)) '.L3m_MO_NSST_sst_9km.nc'];
%---------------------------�e�ϨåH print �s��-----------------------------
%   sst2{i} = reshape(sst{i},[],1);
    sst(find(sst >= 45.0007)) = NaN;
%     figure(i)
    LONLIM = [110 160]; LATLIM = [0 40];
    m_proj('miller','lon',LONLIM,'lat',LATLIM);
    [Xlon,Ylat] = meshgrid(Sublon,Sublat);
    m_pcolor(Xlon,Ylat,sst);
    shading interp
    m_gshhs_i('patch',[.1 .1 .1]);
%     m_coast('patch',[.1 .1 .1],'edgecolor','k');
    m_grid('linewi',2,'linestyle','none','tickdir','out',...
        'xtick',[LONLIM(1):5:LONLIM(2)],'ytick',[LATLIM(1):5:LATLIM(2)],...
        'XaxisLocation','bottom','YaxisLocation','left');
    colormap(jet)
    colorbar
    caxis([0 max(max(sst))]) %�� colormap ���϶��d��q 0 �� 30 �令 0 �� max(max(sst)) 
    title([n,' SST_MODIS'],'Interpreter','none');
    print(n,'-dpng')
end
% n = datestr(t,'yyyy-mm-dd')
%% �_�b�y�V�u(12��~2��)SST
% mon = [201108:201112 201201:201212 201301:201312 201401:201412 201501:201505]';
for i = [5 6 7 17 18 19 29 30 31 41 42 43]
    %---------------------- Ū�� NC �ɮ�------------------------------------
    filename = a(i).name;
    %ncdisp(filename)
    nc_dump(filename); % nc_dump ���J�ɮ�
    %---------------------------�N�ɦW�ഫ����Ū�����-----------------------
    sst = nc_varget(a(i).name,'sst');             % nc_varget ���X�ɮפ����ܼ� sst
    qual_sst = nc_varget(a(i).name,'qual_sst');   % nc_varget ���X�ɮפ����ܼ� qual_sst
    Sublat = nc_varget(a(i).name,'lat');          % nc_varget ���X�ɮפ����ܼ� lat
    Sublon = nc_varget(a(i).name,'lon');          % nc_varget ���X�ɮפ����ܼ� lon
    palette = nc_varget(a(i).name,'palette');     % nc_varget ���X�ɮפ����ܼ� palette
    
    s1 = a(i).name(2:8);
    t = datetime(s1,'InputFormat','uuuuDDD');
    n = datestr(t,'yyyy-mm');
%     a2.name{i}=['A' num2str(mon(i)) '.L3m_MO_NSST_sst_9km.nc'];
%---------------------------�e�ϨåH print �s��-----------------------------
%   sst2{i} = reshape(sst{i},[],1);
    sst(find(sst >= 45.0007)) = NaN;
%     figure(i)
    LONLIM = [110 160]; LATLIM = [0 40];
    m_proj('miller','lon',LONLIM,'lat',LATLIM);
    [Xlon,Ylat] = meshgrid(Sublon,Sublat);
    m_pcolor(Xlon,Ylat,sst);
    shading interp
    m_gshhs_i('patch',[.1 .1 .1]);
%     m_coast('patch',[.1 .1 .1],'edgecolor','k');
    m_grid('linewi',2,'linestyle','none','tickdir','out',...
        'xtick',[LONLIM(1):5:LONLIM(2)],'ytick',[LATLIM(1):5:LATLIM(2)],...
        'XaxisLocation','bottom','YaxisLocation','left');
    colormap(jet)
    colorbar
    caxis([0 max(max(sst))]) %�� colormap ���϶��d��q 0 �� 30 �令 0 �� max(max(sst)) 
    title([n,' SST_MODIS'],'Interpreter','none');
    print(n,'-dpng')
end
% n = datestr(t,'yyyy-mm-dd')
%% �e�ϨåH print �s��  (���·ХB�S�Ĳv����k)
% for i=1:5
% %     sst2{i} = reshape(sst{i},[],1);
%     sst{1,i}(find(sst{1,i} >= 45.0007)) = NaN;
%     figure(i)
%     m_proj('miller','lon',[-180 180],'lat',[-90 90]);
%     [Xlon,Ylat] = meshgrid(Sublon{i},Sublat{i});
%     m_pcolor(Xlon,Ylat,sst{i});
%     % m_gshhs_l('patch',[.1 .1 .1]);
%     m_coast('patch',[.1 .1 .1],'edgecolor','k');
%     m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
%         'xtick',[-180:60:180],'ytick',[-90:30:90],...
%         'XaxisLocation','bottom','YaxisLocation','left');
%     colormap(jet)
%     colorbar
%     caxis([0 28]) %�� colormap ���϶��d��q 0 �� 30 �令 0 �� 28 
%     title([n(i,1:7),' SST_MODIS'],'Interpreter','none');
%     print(n(i,1:7),'-dpng')
% end

%%  MOCIS_SST_mutil02  �˰Q (2019/10/25)

% a ���ݭn��structrue2table
% �j��n²��
% ���ƥΨ쪺�Ʀr�n���ܼƧe�{�A���Ƥ~���Τ@�Ӥ@�ӧ�

a(1).name
% ans =
% 
%     'A20112132011243.L3m_MO_NSST_sst_9km.nc'

a(i).name(1:10)

% ans =
% 
%     'A201133520'

a(i).name(2:9)

% ans =
% 
%     '20113352'

a(i).name(2:8)

% ans =
% 
%     '2011335'

num2str(10)

% ans =
% 
%     '10'