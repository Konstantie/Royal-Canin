----------------------------------------------------MAT SHARE%-CY
MAT share%-CY-4 KPI = 
VAR RSVincGSTSHARE=
DIVIDE(
    CALCULATE(
        SELECTEDMEASURE(),
        'd_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-11&&
        'd_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])
    ),
    CALCULATE(
        SELECTEDMEASURE(),
        ALL(Segment[SEGMENT]),ALL('Sub Category'),ALL('life stage'),ALL('brand'),ALL('Retailers'),
        ALLSELECTED('d_pbi_load_agg'[PILLAR],'d_pbi_load_agg'[RETAILER],'d_pbi_load_agg'[CHANNEL],'d_pbi_load_agg'[BRAND]),
        'd_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-11&&
        'd_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])
    )
)

--------------------------------------------YTD SHARE%-CY
YTD share%-CY-4 KPI = 
VAR RSVincGSTSHARE=
DIVIDE(
    CALCULATE(
        SELECTEDMEASURE(),
        'd_pbi_load_agg'[CALENDAR_YEAR]=SELECTEDVALUE('d_calendar2_slicer table'[YEAR]),
        'd_pbi_load_agg'[CALENDAR_MONTH]<=SELECTEDVALUE('d_calendar2_slicer table'[MONTH_NUMBER])
    ),
    CALCULATE(
        SELECTEDMEASURE(),
        ALL(Segment[SEGMENT]),ALL('Sub Category'),ALL('life stage'),ALL('brand'),ALL('Retailers'),
        ALLSELECTED('d_pbi_load_agg'[PILLAR],'d_pbi_load_agg'[RETAILER],'d_pbi_load_agg'[CHANNEL],'d_pbi_load_agg'[BRAND]),
        'd_pbi_load_agg'[CALENDAR_YEAR]=SELECTEDVALUE('d_calendar2_slicer table'[YEAR]),
        'd_pbi_load_agg'[CALENDAR_MONTH]<=SELECTEDVALUE('d_calendar2_slicer table'[MONTH_NUMBER])
    )
)


---------------------------------------------------------------------------QTR SHARE%-CY

QTR share%-CY-4 KPI = 
VAR RSVincGSTSHARE=
DIVIDE(
    CALCULATE(
        SELECTEDMEASURE(),
        'd_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-2&&
        'd_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])
    ),
    CALCULATE(
        SELECTEDMEASURE(),
        ALL(Segment[SEGMENT]),ALL('Sub Category'),ALL('life stage'),ALL('brand'),ALL('Retailers'),
        ALLSELECTED('d_pbi_load_agg'[PILLAR],'d_pbi_load_agg'[RETAILER],'d_pbi_load_agg'[CHANNEL],'d_pbi_load_agg'[BRAND]),
        'd_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-2&&
        'd_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])
    )
)

---------------------------------------------------------------------------Month SHARE%-CY
Month SHARE%-CY-4 KPI = 
VAR RSVincGSTSHARE=
DIVIDE(
    CALCULATE(
        SELECTEDMEASURE(),
        'd_pbi_load_agg'[CALENDAR_YEAR]=SELECTEDVALUE('d_calendar2_slicer table'[YEAR]),
        'd_pbi_load_agg'[CALENDAR_MONTH]=SELECTEDVALUE('d_calendar2_slicer table'[MONTH_NUMBER])
    )
    ,
    CALCULATE(
        SELECTEDMEASURE(),
        ALL(Segment[SEGMENT]),ALL('Sub Category'),ALL('life stage'),ALL('brand'),ALL('Retailers'),
        ALLSELECTED('d_pbi_load_agg'[PILLAR],'d_pbi_load_agg'[RETAILER],'d_pbi_load_agg'[CHANNEL],'d_pbi_load_agg'[BRAND]),
        'd_pbi_load_agg'[CALENDAR_YEAR]=SELECTEDVALUE('d_calendar2_slicer table'[YEAR]),
        'd_pbi_load_agg'[CALENDAR_MONTH]=SELECTEDVALUE('d_calendar2_slicer table'[MONTH_NUMBER])
    )
)

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

MAT share%-VS LY-4 KPI = 
IFERROR(IF(ISBLANK([MAT share%-LY-4 KPI]),BLANK(),[MAT share%-CY-4 KPI]-[MAT share%-LY-4 KPI]),BLANK())*10000

YTD share%-VS LY-4 KPI = 
IFERROR(IF(ISBLANK([YTD share%-LY-4 KPI]),BLANK(),[YTD share%-CY-4 KPI]-[YTD share%-LY-4 KPI]),BLANK())*10000

QTR share%-VS LY-4 KPI = 
IFERROR(IF(ISBLANK([QTR share%-LY-4 KPI]),BLANK(),[QTR share%-CY-4 KPI]-[QTR share%-LY-4 KPI]),BLANK())*10000

Month share%-VS LY-4 KPI = 
IFERROR(IF(ISBLANK([Month share%-LY-4 KPI]),BLANK(),[Month share%-CY-4 KPI]-[Month share%-LY-4 KPI]),BLANK())*10000

IFERROR(
    IF(
        ISBLANK([Month share%-LY-4 KPI]),
        BLANK(),
        [Month share%-CY-4 KPI]-[Month share%-LY-4 KPI]
    ),
    BLANK()
)*10000


如何写出CY-LY的适用条件在一个条件内
也就是必须写成 LY = F(CY)  = CY-12 的递进层时间关系，我上面的才能被统一
CY = 
CALCULATE(SELECTEDMEASURE(),
    'd_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-11&&'d_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])
)
LY = 
CALCULATE(SELECTEDMEASURE(),
    'd_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-23&&'d_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-12
)

------------------------------------------------------------------------------------研究-----------------------------------------------------------------------------------------------------



CALCGRP:
A = 
IF(SEARCH("_1",SELECTEDMEASURENAME(),1,-1)<>-1,
    SELECTEDMEASURE()*3
)

DAX_1_A = CALCULATE([DAX_1],step_A[Name] = "A")



step_1: --- 改第一参数，需要将自己名字写在ISSELECTEDMEASURE()中
step1_1 = IF(ISSELECTEDMEASURE([DAX_1]),1)
step1_2 = IF(ISSELECTEDMEASURE([DAX_1]),2)

DAX_1 = [DAX_0]

DAX_0 = 0










/*
test_ori_RSV inc GST = SUM('d_pbi_load_agg'[RSV_INC_GST])/1000000
test_ori_Unit = sum('d_pbi_load_agg'[UNITS_SOLD])
test_RSVexlGST = CALCULATE(sum('d_pbi_load_agg'[RSV_EXC_GST]),'d_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-11&&'d_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2]))
test_RSVincGST = 1000000*CALCULATE([RSV inc GST],'d_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-11&&'d_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2]))
test_unit = CALCULATE([Unit],'d_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-11&&'d_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2]))
test_volume = CALCULATE(sum('d_pbi_load_agg'[VOLUME_OF_UNITS_SOLD]),'d_pbi_load_agg'[CALENDAR_MONTH2]>=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2])-11&&'d_pbi_load_agg'[CALENDAR_MONTH2]<=SELECTEDVALUE('d_calendar2_slicer table'[CALENDAR_MONTH2]))
*/