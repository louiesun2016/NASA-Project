PRO amsr_cpr_grid
print,'version_2018_04_01_important_60_5_550_go_on'
  lastmon='08'
  fnewmon='08'
  fnewyear='2010'
  lastyear='2010'
nn=0LL
LaH=2260000.0
resolution=['0.0','25.0','50.0','75.0','100.0','125.0','150.0','175.0','200.0','225.0','250.0','275.0','300.0','325.0','350.0','375.0','400.0','425.0','450.0','475.0','500.0','525.0','550.0','575.0','600.0']
;resolution=['0.00','0.25','0.50','0.75','1.00','1.25','1.50','1.75','2.00','2.25','2.50','2.75','3.00','3.25','3.50','3.75','4.00'];/2
;resolution=['2.75','3.00','3.25','3.50','3.75','4.00']
;resolu=indgen(17)*0.125
resolu=[0.0,25.0,50.0,75.0,100.0,125.0,150.0,175.0,200.0,225.0,250.0,275.0,300.0,325.0,350.0,375.0,400.0,425.0,450.0,475.0,500.0,525.0,550.0,575.0,600.0]/2
resolution=['200.0','225.0','250.0','275.0','300.0','325.0','350.0','375.0','400.0','425.0','450.0','475.0','500.0','525.0','550.0','575.0','600.0']
resolu=[200.0,225.0,250.0,275.0,300.0,325.0,350.0,375.0,400.0,425.0,450.0,475.0,500.0,525.0,550.0,575.0,600.0]/2

resolution=['550.00']
resolu=[550.0]/2

swath_name1='2B-FLXHR-LIDAR'
swath_name2='2C-RAIN-PROFILE'
swath_name3='2B-GEOPROF-LIDAR'
swath_name4='2C-PRECIP-COLUMN'

path='/Volumes/lusun_data4/CLOUDSAT2/'
path1='/Volumes/lusun_data4/CLOUDSAT2/'

for r=0,0 do begin
  nn=0LL
  lonbox=fltarr(2)
  latbox=fltarr(2)
  data1=fltarr(300000);down shortwave all-sky  -  down shortwave clear-sky
  data2=fltarr(300000);delta all-sky-delat clear-sky
  data3=fltarr(300000)
  data4=fltarr(300000)
  data5=fltarr(300000)
  data6=fltarr(300000)
  data7=fltarr(300000)
  data8=fltarr(300000)
  data9=fltarr(300000)

  rc=fltarr(300000)
  rh=fltarr(300000)
  rhh=fltarr(300000)
  rh_amsr=fltarr(300000)
  rc_amsr=fltarr(300000)
  LH_amsr=fltarr(300000)
  LH=fltarr(300000)
  longitude=fltarr(300000)
  latitude=fltarr(300000)
  layertop1=fltarr(5,300000)
  layerbase1=fltarr(5,300000)
  rain_rate=fltarr(300000)
  rain_rate_uncertainty=fltarr(300000)
  precip_flag=intarr(300000)
  totaltime=strarr(300000)
  dataquality=fltarr(300000)
  status1=fltarr(300000)
  wp=fltarr(300000)
  sst1=fltarr(300000)

  ab1=fltarr(300000)
  rainqua1=fltarr(300000)
  rainsta1=fltarr(300000)
  scenesta1=lonarr(300000)
  dataqua1=intarr(300000)
  datasta1=lonarr(300000)
  surface1=fltarr(300000)
  old_rain_rate=fltarr(300000)
  greenhousepar=fltarr(300000)
  albedo_cloud=fltarr(300000)
  ratio1=fltarr(300000)
  cloudlayer1=fltarr(300000)
  cloud_fraction1=fltarr(125,300000)
  cloud_force=fltarr(300000)
  granule=fltarr(300000)
  rain_type=fltarr(300000)
  rainrate_amsr=fltarr(300000)
  rainqua_amsr=fltarr(300000)
  longitude[*]=-9999.00
  latitude[*]=-9999.00
  precip_flag[*]=0LL
  totaltime[*]=''
  status1[*]=0LL
  wp[*]=0LL
  sst1[*]=0LL

  for i=22655,24739 do begin;1541,24738;24882  1831
    print,i
    if i le 3606 then year='2006'
    if i gt 3606 and i le 8921 then year='2007'
    if i gt 8921 and i le 14250 then year='2008'
    if i gt 14250 and i le 19209 then year='2009'
    if i gt 19209 and i le 24739 then year='2010'

    cs_granule=strmid(int2str(i+100000),1,5)
    infile_cloudsat1 = year+'*'+cs_granule+'_CS_'+swath_name1+'*'+'.hdf'
    infile_cloudsat2 = year+'*'+cs_granule+'_CS_'+swath_name2+'*'+'.hdf'
    infile_cloudsat3 = year+'*'+cs_granule+'_CS_'+swath_name3+'*'+'.hdf'
    infile_cloudsat4 = year+'*'+cs_granule+'_CS_'+swath_name4+'*'+'.hdf'

    pathfile1 = path1+swath_name1+'/'+year+'/'
    pathfile2 = path1+swath_name2+'/'+year+'/'
    pathfile3 = path+swath_name3+'/'+year+'/'
    pathfile4 = path1+swath_name4+'/'+year+'/'

    filename1 = pathfile1+infile_cloudsat1
    filename2 = pathfile2+infile_cloudsat2
    filename3 = pathfile3+infile_cloudsat3
    filename4 = pathfile4+infile_cloudsat4

    filenames1=file_search(filename1,count=n1)
    filenames2=file_search(filename2,count=n2)
    filenames3=file_search(filename3,count=n3)
    filenames4=file_search(filename4,count=n4)

    juliday=str2int(strmid(filenames1[0],55,3))
    ls_Jul2day,juliday,year,mon,day
    hour=str2int(strmid(filenames1[0],58,2))
    min=str2int(strmid(filenames1[0],60,2))
    sec=str2int(strmid(filenames1[0],62,2))

 a_hour=intarr(3)
 a_hour[0]=hour-1
 a_hour[1]=hour
 a_hour[2]=hour+1
 pppt=where(a_hour eq -1,ppp)
 pppt1=where(a_hour eq 24,ppp1)
 if ppp gt 0 then a_hour[pppt]=23
 if ppp1 gt 0 then a_hour[pppt1]=00
; printf,lun,a_hour
; a_hour=strmid(filenames1[0],51,2)
; a_min=strmid(filenames1[0],53,2)
; a_sec=strmid(filenames1[0],55,2)
; print,n1,n2,n3

a_mon=strmid(int2str(mon+100),1,2)
a_year=int2str(year)
a_hour=strmid(int2str(a_hour+100),1,2)
a_day=strmid(int2str(day+100),1,2)

if ppp gt 0 then begin
print,' ppp >0'
a_day=[strmid(int2str(day+100-1),1,2),strmid(int2str(day+100),1,2),strmid(int2str(day+100),1,2)]
if mon ne 1 then begin
a_mon=strmid(int2str(mon+100),1,2)
if day ne 1 then begin
a_day=[strmid(int2str(day+100-1),1,2),strmid(int2str(day+100),1,2),strmid(int2str(day+100),1,2)]  
endif else begin
day_previous=lastday_of_firstday(mon,day,year)
print,'day_previuos:',day_previous
a_day=[strmid(int2str(day_previous+100),1,2),strmid(int2str(day+100),1,2),strmid(int2str(day+100),1,2)]
a_mon=[strmid(int2str(mon-1+100),1,2),strmid(int2str(mon+100),1,2),strmid(int2str(mon+100),1,2)]
;print,'month_mark: ',a_mon
endelse
endif else begin
if day eq 1 and hour eq 0 then begin
a_mon=['12',strmid(int2str(mon+100),1,2),strmid(int2str(mon+100),1,2)]
day_previous=lastday_of_firstday(mon,day,year)
print,'day_previuos:',day_previous
a_day=[strmid(int2str(day_previous+100),1,2),strmid(int2str(day+100),1,2),strmid(int2str(day+100),1,2)]
endif else begin
a_mon=strmid(int2str(mon+100),1,2)
;print,'month_mark1: ',a_mon
endelse
endelse
endif

if ppp1 gt 0 then begin
    print,' ppp1 >0'
     a_day=[strmid(int2str(day+100),1,2),strmid(int2str(day+100),1,2),strmid(int2str(day+100+1),1,2)]
if mon ne 12 then begin
if day eq days_month(year,mon) then begin
a_mon=[strmid(int2str(mon+100),1,2),strmid(int2str(mon+100),1,2),strmid(int2str(mon+100+1),1,2)]
a_day=[strmid(int2str(day+100),1,2),strmid(int2str(day+100),1,2),'01']
endif else begin
a_day=[strmid(int2str(day+100),1,2),strmid(int2str(day+100),1,2),strmid(int2str(day+100+1),1,2)] 
endelse  
endif else begin
if day eq 31 and hour eq 23 then begin
a_year=[int2str(year),int2str(year),int2str(year+1)]
a_mon=[strmid(int2str(mon+100),1,2),strmid(int2str(mon+100),1,2),'01']
a_day=[strmid(int2str(day+100),1,2),strmid(int2str(day+100),1,2),'01']
endif else begin
a_day=[strmid(int2str(day+100),1,2),strmid(int2str(day+100),1,2),strmid(int2str(day+100+1),1,2)]   
endelse
endelse
endif

print,'  a_year: ',a_year,'  a_mon: ', a_mon,'  a_day: ', a_day,'  a_hour: ',a_hour

    filename5='/Volumes/lusun_data4/AMSR-E_CPR/AMSRE.L2.RainRateAE_RainStrip200kmAlongCloudSat.'+a_year+'.'+a_mon+'.'+a_day+'.'+a_hour+'*.hdf'
    filenames5=file_search(filename5,count=n5)
    ;print,filenames5
    print,n1,n2,n3,n4,n5
    if i eq 24739 then goto,finish
    if n1 eq 0 or n2 eq 0 or n3 eq 0 or n4 eq 0 or n5 eq 0 then goto,next
    
    file_id=EOS_SW_OPEN(filenames1[0])
    swath_id=EOS_SW_ATTACH(file_id, swath_name1)

    datafield_name='FU'
    status=EOS_SW_READFIELD(swath_id, datafield_name, FU)
    datafield_name='FD'
    status=EOS_SW_READFIELD(swath_id, datafield_name, FD)
    datafield_name='FU_NC'
    status=EOS_SW_READFIELD(swath_id, datafield_name, FU_NC)
    datafield_name='FD_NC'
    status=EOS_SW_READFIELD(swath_id, datafield_name, FD_NC)
    datafield_name='Longitude'
    status=EOS_SW_READFIELD(swath_id, datafield_name, lon)
    datafield_name='Latitude'
    status=EOS_SW_READFIELD(swath_id, datafield_name, lat)
    datafield_name='Height'
    status=EOS_SW_READFIELD(swath_id, datafield_name, lev)
    datafield_name='Profile_time'
    status=EOS_SW_READFIELD(swath_id, datafield_name, time)
    datafield_name='TOACRE'
    status=EOS_SW_READFIELD(swath_id, datafield_name, toa)
    datafield_name='BOACRE'
    status=EOS_SW_READFIELD(swath_id, datafield_name, boa)
    datafield_name='Status'
    status=EOS_SW_READFIELD(swath_id, datafield_name, sta)
    datafield_name='Albedo'
    status=EOS_SW_READFIELD(swath_id, datafield_name, ab)
    datafield_name='Data_quality'
    status=EOS_SW_READFIELD(swath_id, datafield_name, dataqua)
    datafield_name='Data_status'
    status=EOS_SW_READFIELD(swath_id, datafield_name, datasta)
    datafield_name='Scene_status'
    status=EOS_SW_READFIELD(swath_id, datafield_name, scenesta)

    ; Read attributes.

    attr_name = 'FU.factor'
    status=EOS_SW_READATTR(swath_id, attr_name, fu_scale_factor)
    attr_name = 'FU.valid_range'
    status=EOS_SW_READATTR(swath_id, attr_name, fu_valid_range)

    attr_name = 'FD.factor'
    status=EOS_SW_READATTR(swath_id, attr_name, fd_scale_factor)
    attr_name = 'FD.valid_range'
    status=EOS_SW_READATTR(swath_id, attr_name, fd_valid_range)

    ; Detach swath.
    status=EOS_SW_DETACH(swath_id)
    ; Close file.
    status=EOS_SW_CLOSE(file_id)

    FDS=FD[*,*,0]
    FDS = float(FDS)
    FDL=FD[*,*,1]
    FDL = float(FDL)

    FUS=FU[*,*,0]
    FUS = float(FUS)
    FUL=FU[*,*,1]
    FUL = float(FUL)

    FDS_NC=FD_NC[*,*,0]
    FDS_NC = float(FDS_NC)
    FDL_NC=FD_NC[*,*,1]
    FDL_NC = float(FDL_NC)

    FUS_NC=FU_NC[*,*,0]
    FUS_NC = float(FUS_NC)
    FUL_NC=FU_NC[*,*,1]
    FUL_NC = float(FUL_NC)

    FUS=FUS/ fu_scale_factor[0]
    FUL=FUL/ fu_scale_factor[0]
    FDS=FDS/ fd_scale_factor[0]
    FDL=FDL/ fd_scale_factor[0]
    FUS_NC=FUS_NC/ fu_scale_factor[0]
    FUL_NC=FUL_NC/ fu_scale_factor[0]
    FDS_NC=FDS_NC/ fd_scale_factor[0]
    FDL_NC=FDL_NC/ fd_scale_factor[0]
    ;print,rh1

    file_id=EOS_SW_OPEN(filenames2[0])
    swath_id=EOS_SW_ATTACH(file_id, swath_name2)
    datafield_name='rain_rate'
    status=EOS_SW_READFIELD(swath_id, datafield_name, rainrate)
    datafield_name='rain_rate_uncertainty'
    status=EOS_SW_READFIELD(swath_id, datafield_name, rainrateuncer)
    datafield_name='precip_flag'
    status=EOS_SW_READFIELD(swath_id, datafield_name, rainratetype)
    datafield_name='precip_liquid_water'
    status=EOS_SW_READFIELD(swath_id, datafield_name, lwp)
    datafield_name='precip_ice_water'
    status=EOS_SW_READFIELD(swath_id, datafield_name, iwp)
    datafield_name='rain_status_flag'
    status=EOS_SW_READFIELD(swath_id, datafield_name, rainsta)
    datafield_name='rain_quality_flag'
    status=EOS_SW_READFIELD(swath_id, datafield_name, rainqua)
    datafield_name='Navigation_land_sea_flag'
    status=EOS_SW_READFIELD(swath_id, datafield_name, surface)

    ; Read attributes.
    attr_name = 'rain_rate.factor'
    status=EOS_SW_READATTR(swath_id, attr_name, rate_scale_factor)
    attr_name = 'rain_rate.valid_range'
    status=EOS_SW_READATTR(swath_id, attr_name, rate_valid_range)
    attr_name = 'precip_liquid_water.factor'
    status=EOS_SW_READATTR(swath_id, attr_name, lwp_scale_factor)
    attr_name = 'precip_liquid_water.valid_range'
    status=EOS_SW_READATTR(swath_id, attr_name, lwp_valid_range)
    ; Detach swath.
    status=EOS_SW_DETACH(swath_id)
    ; Close file.
    status=EOS_SW_CLOSE(file_id)

    lwp=lwp/1000.0
    iwp=iwp/1000.0

    file_id=EOS_SW_OPEN(filenames3[0])
    swath_id=EOS_SW_ATTACH(file_id, swath_name3)

    datafield_name='CloudLayers'
    status=EOS_SW_READFIELD(swath_id, datafield_name, cloudlayer)
    datafield_name='LayerTop'
    status=EOS_SW_READFIELD(swath_id, datafield_name, layertop)
    datafield_name='LayerBase'
    status=EOS_SW_READFIELD(swath_id, datafield_name, layerbase)
    datafield_name='CloudFraction'
    status=EOS_SW_READFIELD(swath_id, datafield_name, cloud_fraction)
    ;lyt=layer_top[0,*]

    ; Read attributes.
    attr_name = 'CloudLayers.factor'
    status=EOS_SW_READATTR(swath_id, attr_name, cloud_scale_factor)
    attr_name = 'CloudLayers.valid_range'
    status=EOS_SW_READATTR(swath_id, attr_name, cloud_valid_range)
    ; Detach swath.
    status=EOS_SW_DETACH(swath_id)
    ; Close file.
    status=EOS_SW_CLOSE(file_id)
    ;print,sta

    file_id=EOS_SW_OPEN(filenames4[0])
    swath_id=EOS_SW_ATTACH(file_id, swath_name4)
    datafield_name='SST'
    status=EOS_SW_READFIELD(swath_id, datafield_name, sst)
    datafield_name='Surface_wind'
    status=EOS_SW_READFIELD(swath_id, datafield_name, surface_wind)

    attr_name = 'SST.factor'
    status=EOS_SW_READATTR(swath_id, attr_name, sst_scale_factor)
    attr_name = 'Surface_wind.factor'
    status=EOS_SW_READATTR(swath_id, attr_name, surface_wind_factor)
    attr_name = 'SST.valid_range'
    status=EOS_SW_READATTR(swath_id, attr_name, sst_valid_range)
    ; Detach swath.
    status=EOS_SW_DETACH(swath_id)
    ; Close file.
    status=EOS_SW_CLOSE(file_id)
    SST=SST/sst_scale_factor(0)
    surface_wind=surface_wind/surface_wind_factor(0)

    a_rain_rate=[]
    a_rain_status=[]
    a_rain_type=[]
    a_surface_type=[]
    a_lon=[]
    a_lat=[]

    file_num=n5
    n_files=0
    for n_files=0, file_num-1  do begin
      file_id=EOS_SW_OPEN(filenames5[n_files])
      swathlist='L2B Rainfall Products'
      swath_id=EOS_SW_ATTACH(file_id, swathlist)
      datafield_name='Rain Rate'
      status=EOS_SW_READFIELD(swath_id, datafield_name, a_rain_rate_p)
      datafield_name='Rain Status'
      status=EOS_SW_READFIELD(swath_id, datafield_name, a_rain_status_p)
      datafield_name='Rain Type'
      status=EOS_SW_READFIELD(swath_id, datafield_name, a_rain_type_p)
      datafield_name='Surface Type'
      status=EOS_SW_READFIELD(swath_id, datafield_name, a_surface_type_p)
      datafield_name='Longitude'
      status=EOS_SW_READFIELD(swath_id, datafield_name, a_lon_p)
      datafield_name='Latitude'
      status=EOS_SW_READFIELD(swath_id, datafield_name, a_lat_p)
      status=EOS_SW_DETACH(swath_id)
      status=EOS_SW_CLOSE(file_id)

      a_rain_rate=[a_rain_rate,reform(a_rain_rate_p[22,*])]
      a_rain_status=[a_rain_status,reform(a_rain_status_p[22,*])]
      a_rain_type=[a_rain_type,reform(a_rain_type_p[22,*])]
      a_surface_type=[a_surface_type,reform(a_surface_type_p[22,*])]
      a_lon=[a_lon,reform(a_lon_p[22,*])]
      a_lat=[a_lat,reform(a_lat_p[22,*])]
      
      endfor

      print,fnewmon,lastmon,mon,nn
      goodidx = WHERE((dataqua eq 0) and (rainrate ne 0.0) and (rainrate gt -999)  and (sta le 8) and (FUS[3,*] ne 0) and (SST le 32) and (SST gt 0) and ((rainqua ge 3 ) or rainrate lt 0) and (FUS[3,*] gt 0) and (FUL[3,*] gt 0) and (FDS[3,*] gt 0) and (FDL[3,*] gt 0) and (FUS_NC[3,*] gt 0) and (FUL_NC[3,*] gt 0) and (FDS_NC[3,*] gt 0) and (FDL_NC[3,*] gt 0)  ,goodcnt)

      
      for w=0,goodcnt-1 do begin
        if i le 3606 then year=2006
        if i gt 3606 and i le 8921 then year=2007
        if i gt 8921 and i le 14250 then year=2008
        if i gt 14250 and i le 19209 then year=2009
        if i gt 19209 and i le 24739 then year=2010
      
        lonbox[0]=lon[goodidx[w]]-resolu[r]/(111.0*cos(lat[goodidx[w]]*3.1415926/180.0))
        lonbox[1]=lon[goodidx[w]]+resolu[r]/(111.0*cos(lat[goodidx[w]]*3.1415926/180.0))
        latbox[0]=lat[goodidx[w]]-resolu[r]/111.0
        latbox[1]=lat[goodidx[w]]+resolu[r]/111.0
        

;        lonbox[0]=lon[goodidx[w]];-resolu[r]/(111.0*cos(lat[goodidx[w]]*3.1415926/180.0))
;        lonbox[1]=lon[goodidx[w]];+resolu[r]/(111.0*cos(lat[goodidx[w]]*3.1415926/180.0))
;        latbox[0]=lat[goodidx[w]];-resolu[r]/111.0
;        latbox[1]=lat[goodidx[w]];+resolu[r]/111.0
         ;print,'resolu[r]:',resolu[r],'lonbox[0]',lonbox[0],'lonbox[1]',lonbox[1],'latbox[0]',latbox[0],'latbox[1]',latbox[1],'godidx';,godidx

        sl_newtime,year,mon,day,hour,min,sec,time[goodidx[w]],newyear,newmon,newday,newhour,newmin,newsec
        newsec=fix(newsec*100)
        ;;;;;;;;;;;;;;;;;;;;;;;
        fnewmon=strmid(int2str(newmon+100),1,2)
        fnewday=strmid(int2str(newday+100),1,2)
        fnewhour=strmid(int2str(newhour+100),1,2)
        fnewmin=strmid(int2str(newmin+100),1,2)
        fnewsec=strmid(int2str(newsec+10000),1,4)
        fnewyear=int2str(newyear)
        
        finish:
        if  fnewmon ne lastmon or i eq 24739 then begin
          ;help,year,mon,day,hour,min,sec
  ;        hdfnamew = '/Volumes/lusun_data4/rcrh/rcrh12/'+resolution[r]+'/'+lastyear+lastmon+'.h5' &  print, hdfnamew
          hdfnamew = '/Volumes/lusun_data4/rcrh/rcrh18/'+resolution[r]+'/'+lastyear+lastmon+'.h5' &  print, hdfnamew
          fid = H5F_CREATE(hdfnamew)
          var = Rc[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Rc',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = Rh[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Rh',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = Rhh[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Rh_obs',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = longitude[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Longitude',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = latitude[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Latitude',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = totaltime[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Date_YYYYMMDDHHMMSSSS',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = layertop1[*,0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Layer_Top',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = layerbase1[*,0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Layer_Base',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var


          var = cloud_fraction1[*,0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Cloud_Fraction',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = cloudlayer1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Cloud_Layer',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = rain_rate_uncertainty[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'rain_rate_uncertainty',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = precip_flag[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'precip_flag',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = data2[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'caculated TOA_BOA',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = data1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'surface_cool',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = dataquality[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'TOA-BOA',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = status1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'status',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = wp[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'minimum precip_water',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = sst1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'SST',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = ab1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'albedo',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var


          var = rainqua1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'rain_quality_flag',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = rainsta1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'rain_status_flag',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = surface1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Navigation_land_sea_flag',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = dataqua1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Data_quality',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = datasta1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Data_status',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = scenesta1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'Scene_Status',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = old_rain_rate[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'original_rain_rate',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = greenhousepar[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'greenhouse_parameter',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = albedo_cloud[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'albedo_cloud',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = ratio1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'N',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var = cloud_force[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'cloud_force',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

;          var = rain_type[0:nn-1]
;          datatype_id = H5T_IDL_CREATE(var)
;          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
;          dataset_id = H5D_CREATE(fid,'rain_type',datatype_id,dataspace_id)
;          H5D_WRITE,dataset_id,var

          var = granule[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'granule',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var
         
          var =  data8[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'ac_de_flux',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var
          
          var =  data4[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'ac_nom_flux',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var
          
          var =  data7[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'gc_de_flux',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var =  data3[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'gc_nom_flux',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var
       
          var =  data6[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'nc_de_flux',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var =  data5[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'nc_nom_flux',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var
      
          var =  data1[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'rc_flux',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          var =  data2[0:nn-1]
          datatype_id = H5T_IDL_CREATE(var)
          dataspace_id = H5S_CREATE_SIMPLE(size(var,/DIMENSIONS))
          dataset_id = H5D_CREATE(fid,'rh_flux',datatype_id,dataspace_id)
          H5D_WRITE,dataset_id,var

          H5D_CLOSE,dataset_id
          H5S_CLOSE,dataspace_id
          H5T_CLOSE,datatype_id
          H5F_CLOSE,fid
          lastmon=strmid(int2str(fnewmon+100),1,2)
          lastyear=int2str(fnewyear)
          nn=0LL


          DELVAR,data1,data2,data3,data4,data5,data6,rc,rh,LH,longitude, latitude, layertop1, layerbase1, rain_rate, rain_rate_uncertainty,$
            precip_flag, totaltime, dataquality, status1, rhh, wp,  sst1, ab1,  rainqua1, rainsta1,  scenesta1, dataqua1, datasta1,surface1,$
            old_rain_rate, greenhousepar, albedo_cloud, ratio1, cloudlayer1, cloud_fraction1,rcnew,rhnew,rhhnew
          if i eq 24739 then goto,nextnext
          data1=fltarr(300000);down shortwave all-sky  -  down shortwave clear-sky
          data2=fltarr(300000);delta all-sky-delat clear-sky
          data3=fltarr(300000)
          data4=fltarr(300000)
          data5=fltarr(300000)
          data6=fltarr(300000)
          data7=fltarr(300000)
          data8=fltarr(300000)
          rc=fltarr(300000)
          rh=fltarr(300000)
  ;        rc_amsr=fltarr(300000)
  ;        rh_amsr=fltarr(300000)
          LH=fltarr(300000)
          LH_amsr=fltarr(300000)
          longitude=fltarr(300000)
          latitude=fltarr(300000)
          layertop1=fltarr(5,300000)
          layerbase1=fltarr(5,300000)
          rain_rate=fltarr(300000)
          rain_rate_uncertainty=fltarr(300000)
          precip_flag=intarr(300000)
          totaltime=strarr(300000)
          dataquality=fltarr(300000)
          status1=fltarr(300000)
          rhh=fltarr(300000)
          wp=fltarr(300000)
          sst1=fltarr(300000)

          ab1=fltarr(300000)
          rainqua1=fltarr(300000)
          rainsta1=fltarr(300000)
          scenesta1=lonarr(300000)
          dataqua1=intarr(300000)
          datasta1=lonarr(300000)
          surface1=fltarr(300000)
          old_rain_rate=fltarr(300000)
          greenhousepar=fltarr(300000)
          albedo_cloud=fltarr(300000)
          ratio1=fltarr(300000)
          cloudlayer1=fltarr(300000)
          cloud_fraction1=fltarr(125,300000)
          cloud_force=fltarr(300000)
          granule=fltarr(300000)

  ;        rainqua_amsr=fltarr(300000)
        endif

       tmp1=where(FUL[*,goodidx(w)] le 0,cnt1)  ;fix(uint(surfaceheightbin[goodidx(w)]));
       tmp1_1=where(FUL_NC[*,goodidx(w)] le 0,cnt1_1)
       tmp1_2=where(FDL[*,goodidx(w)] le 0,cnt1_2)
       tmp1_3=where(FDL_NC[*,goodidx(w)] le 0,cnt1_3)
       tmp1_4=where(FUS[*,goodidx(w)] le 0,cnt1_4)
       tmp1_5=where(FUS_NC[*,goodidx(w)] le 0,cnt1_5)
       tmp1_6=where(FDS[*,goodidx(w)] le 0,cnt1_6)
       tmp1_7=where(FDS_NC[*,goodidx(w)] le 0,cnt1_7)

        tmp3=where(layertop[*,goodidx(w)] ne -99,cnt3)

        tmp2=where(lwp[*,goodidx(w)] ne 0,cnt2)
        tmp4=where(iwp[*,goodidx(w)] ne 0,cnt4)

        if tmp4(cnt4-1) eq tmp2(cnt2-1) then wp[nn]=lwp[tmp2(cnt2-1),goodidx(w)]+iwp[tmp4(cnt4-1),goodidx(w)]
        if tmp4(cnt4-1) gt tmp2(cnt2-1) then wp[nn]=iwp[tmp4(cnt4-1),goodidx(w)]
        if tmp2(cnt2-1) gt tmp4(cnt4-1) then wp[nn]=lwp[tmp2(cnt2-1),goodidx(w)]

        nn1=0.0
        godidx=where((dataqua eq 0)  and (rainrate gt -999) and (lon ge lonbox[0] and lon le lonbox[1]) and (lat ge latbox[0] and lat le latbox[1]) and (FUS[3,*] ne 0 and SST le 32) and (sta le 8 ) and (rainqua ge 3 or rainrate lt 0),n_grid); and (rainrate gt 0)
       ; print,'n_grid:',n_grid
        for ww=0,n_grid-1 do begin
          data2[nn]=data2[nn]+FUL[tmp1(0)-1,godidx(ww)]-FDL[tmp1_2(1)-1,godidx(ww)]-FUL(0,godidx(ww))+(FDS(0,godidx(ww))+FUS(tmp1_4(0)-1,godidx(ww))-FDS(tmp1_6(0)-1,godidx(ww))-FUS(0,godidx(ww)))-$
            (FUL_NC[tmp1_1(0)-1,godidx(ww)]-FDL_NC[tmp1_3(1)-1,godidx(ww)]-FUL_NC(0,godidx(ww))+FDS_NC(0,godidx(ww))+FUS_NC(tmp1_5(0)-1,godidx(ww))-FDS_NC(tmp1_7(0)-1,godidx(ww))-FUS_NC(0,godidx(ww)))
          data1[nn]=data1[nn]+FDS[tmp1_6(0)-1,godidx(ww)]-FDS_NC(tmp1_7(0)-1,godidx(ww))
          dataquality[nn]=dataquality[nn]-(boa[godidx(ww),0]+boa[godidx(ww),1]-toa[godidx(ww),0]-toa[godidx(ww),1])
          data3[nn]=data3[nn]+FUL_NC[0,godidx(ww)]-FUL[0,godidx(ww)]
          data4[nn]=data4[nn]+FUS[0,godidx(ww)]-FUS_NC[0,godidx(ww)]
          data5[nn]=data5[nn]+FDS[0,godidx(ww)]-FUS[0,godidx(ww)]-FDS_NC[0,godidx(ww)]+FUS_NC[0,godidx(ww)]
          data6[nn]=data6[nn]+FDL[0,godidx(ww)]-FUL[0,godidx(ww)]-FDL_NC[0,godidx(ww)]+FUL_NC[0,godidx(ww)]
          data7[nn]=data7[nn]+FUL[tmp1(0)-1,goodidx(w)]
          data8[nn]=data8[nn]+FDS[0,goodidx(w)]
          totaltime[nn]=fnewyear+fnewmon+fnewday+fnewhour+fnewmin+fnewsec
          LaH=2260000.0
          
          lonmatch = lon(godidx(ww))
          latmatch = lat(godidx(ww))

          diffspring1_amsr=abs(lonmatch-a_lon)
          diffspring2_amsr=abs(latmatch-a_lat)
          diff_total_amsr=diffspring1_amsr^(2.0)+diffspring2_amsr^(2.0)
          index=where(diff_total_amsr eq min(diff_total_amsr))
      ;    printf,lun,'  index',index,'  index[0]',index[0],'  lon_cloudsat',lonmatch,'  lat_cloudsat',latmatch,'  lon_amsr',a_lon[index],'  lat_amsr',a_lat[index]
          rainrate_amsr[nn]=a_rain_rate[index[0]]*0.1
          ;    rainqua_amsr[nn]=5
          ;    rain_type[nn]=a_rain_type[index[0]]*0.01
          ;      get_cloudbase_rr, lowconv,cuconv, mpconv, wp[nn],sst[goodidx(w)],layertop[tmp3(cnt3-1),goodidx(ww)],newwrainrate;tmp2(cnt-1)
          if rainrate_amsr[nn] ge abs(rainrate[godidx(ww)]) then old_rain_rate[nn]=rainrate_amsr[nn]
          if rainrate_amsr[nn] lt abs(rainrate[godidx(ww)]) then old_rain_rate[nn]=abs(rainrate[godidx(ww)])
          LH[nn]=LH[nn]+old_rain_rate[nn]*LaH/3600.0
          nn1=nn1+1
        endfor
        totaltime[nn]=fnewyear+fnewmon+fnewday+fnewhour+fnewmin+fnewsec
        old_rain_rate[nn]=LH[nn]*3600.0/(LaH*nn1)
        rc[nn]=data1[nn]/LH[nn]
        rh[nn]=data2[nn]/LH[nn]
        rhh[nn]=dataquality[nn]/LH[nn]
        greenhousepar[nn]=data3[nn]/data7[nn]
        albedo_cloud[nn]=data4[nn]/data8[nn]
        ratio1[nn]=-data5[nn]/data6[nn]
        longitude[nn]=lon[goodidx(w)]
        latitude[nn]=lat[goodidx(w)]
        layertop1[*,nn]=layertop[*,goodidx(w)]
        layerbase1[*,nn]=layerbase[*,goodidx(w)]
        cloud_fraction1[*,nn]=cloud_fraction[*,goodidx(w)]
        rain_rate_uncertainty[nn]=rainrateuncer[goodidx(w)]
        precip_flag[nn]=rainratetype[goodidx(w)]
        status1[nn]=sta[goodidx(w)]
        sst1[nn]=sst[goodidx(w)]
        ab1[nn]=ab[goodidx(w)]
        cloudlayer1[nn]=cloudlayer[goodidx(w)]
        rainqua1[nn]=rainqua[goodidx(w)]
        rainsta1[nn]=rainsta[goodidx(w)]
        scenesta1[nn]=scenesta[goodidx(w)]
        dataqua1[nn]=dataqua[goodidx(w)]
        datasta1[nn]=datasta[goodidx(w)]
        surface1[nn]= surface[goodidx(w)]
        cloud_force[nn]=-toa(goodidx(w),0)/toa(goodidx(w),1)
        granule[nn]=i
        nn=nn+1
      endfor
  ;    print,totaltime[nn-1]
    

    next:
  endfor
  nextnext:
endfor

end