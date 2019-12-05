%% GET THE INFO LIST
g_name = lower(readmatrix('S1.xlsx','sheet','三九脑科医院(汇总)','Range','J386:J414','OutputType','string'));
s_name = readmatrix('S1.xlsx','sheet','上海德济医院(汇总)','Range','B89:B113','OutputType','string');

g_date = readmatrix('S1.xlsx','sheet','三九脑科医院(汇总)','Range','H386:H414','OutputType','string');
s_date = readmatrix('S1.xlsx','sheet','上海德济医院(汇总)','Range','H89:H113','OutputType','string');

%% FIX DATE FORMAT
dateid = [];
s_date_fix = [];
g_date_fix = [];
for si = 1:numel(s_date)
    datesep1 = split(s_date(si),'.');   
    datecom = join(datesep1,',');
    dateformal = datestr(datestr(datecom),25);
    datesep2 = split(dateformal,'/');
    dateid = strcat(datesep2(1),datesep2(2),datesep2(3));
    s_date_fix = [s_date_fix,dateid];
end
for gi = 1:numel(g_date)
    if ~ismissing(g_date(gi))
       gdateid =strip(strip(g_date(gi),'left','2'),'left','0');
       g_date_fix = [g_date_fix,gdateid];
    elseif ismissing(g_date(gi))
       g_date_fix = [g_date_fix,'00'];
    end
end
s_date_fix = s_date_fix';
g_date_fix = g_date_fix';

%% CONCATENATE SUBJ_ID
g_subid = [];
s_subid = [];
for i = 1:28
    gid = strcat('g','_',g_name(i),'_',g_date_fix(i));
    g_subid = [g_subid,gid];
end
for ii = 2:25
    sid = strcat('s','_',s_name(ii),'_',s_date_fix(ii-1));
    s_subid = [s_subid,sid];
end
g_subid = g_subid';
s_subid = s_subid';
writematrix(g_subid,'S1.xlsx','sheet','三九脑科医院(汇总)','Range','A386:A413');
writematrix(s_subid,'S1.xlsx','sheet','上海德济医院(汇总)','Range','A90:A113');
