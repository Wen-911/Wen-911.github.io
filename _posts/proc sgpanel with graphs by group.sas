/*************************************************************************************************
1.Adding Statistics and Text to the Panel Graphs using INSET option in PROC SGPANEL
site: https://www.pharmasug.org/proceedings/2016/QT/PharmaSUG-2016-QT07.pdf

2.syntax: 
https://support.sas.com/rnd/datavisualization/papers/tipsheets/SGF2018_SGPanel_TipSheet_Blue_QR.pdf

3.colaxistable
https://support.sas.com/kb/56/520.html

**************************************************************************************************/

/*-------------------------------------------------*
***INSET
*-------------------------------------------------*/

/* Calculate the mean height and weight for the inset */
PROC MEANS DATA=sashelp.class nway;
	CLASS sex;
	VAR weight height;
	OUTPUT OUT=stats mean(weight)=mean_weight
					 mean(height)=mean_height 
					 n(height)=n_height n(weight)=n_weight 
					 std(height)=sd_height std(weight)=sd_weight;
RUN;
/* Sort the data */
PROC SORT DATA=sashelp.class OUT=class;
	BY sex;
RUN;

/* Match-merge the inset data with the original data and label*/
DATA merged;
	MERGE class stats;
	BY sex;
	LABEL mean_height = "mean(height)";
	LABEL mean_weight = "mean(weight)";
	LABEL n_height = "n(height)";
	LABEL n_weight = "n(weight)";
	LABEL sd_height = "sd(height)";
	LABEL sd_weight = "sd(weight)";
RUN;

/*Create Panel Graph using INSET statement*/
PROC SGPANEL DATA=merged;
	PANELBY sex;
	HISTOGRAM weight;
	DENSITY weight;
	INSET mean_weight mean_height /
									POSITION=topright TEXTATTRS=(style=italic)
									TITLE="Averages";
RUN;

/*-------------------------------------------------*
***colaxistable
*-------------------------------------------------*/
/*--Compute statistics by Type and Origin--*/
proc means data=sashelp.cars;
  class type origin;
  var horsepower;
  output out=stat(where=(_type_ > 2))
    mean=Mean N=N;
run;
proc print;run;

/*--Merge statistics with original data set--*/
data cars;
  keep type origin horsepower mean n;
  set sashelp.cars stat;
run;
proc print;run;

/*--Render VBox and statistics using ColAxisTable--*/
proc sgpanel data=cars;
  panelby type;
  vbox horsepower / category=origin;
  colaxistable n mean;
run;


/*-------------------------------------------------*
***colaxistable
*-------------------------------------------------*/

proc sgpanel data=sashelp.cars;
	panelby origin/layout=columnlattice;
	scatter x=horsepower y=mpg_highway/group=type;
	reg x=horsepower y=mpg_highway/group=type;
run;

proc sgpanel data=sashelp.cars;
	panelby origin/layout=columnlattice;
	scatter x=horsepower y=mpg_highway ;
	reg x=horsepower y=mpg_highway ;
run;

proc sgpanel data=sashelp.cars;
	panelby origin ;
	scatter x=horsepower y=mpg_highway ;
	reg x=horsepower y=mpg_highway ;
run;

/*grid*/
proc sgpanel data=sashelp.iris;
	 title "Scatter plot for Fisher iris data";
	 panelby species / columns=2;
	 reg x=sepallength y=sepalwidth / cli clm;
	 rowaxis grid;
	 colaxis grid;
run;

proc sgpanel data=sashelp.iris;
	 title "Scatter plot for Fisher iris data";
	 panelby species / columns=2;
	 reg x=sepallength y=sepalwidth / cli="predicts limit" clm="xx";
	 rowaxis grid;
	 colaxis grid;
run;

ods trace on;
ods output  ParameterEstimates=est;
proc reg data=sashelp.iris;
	by species;
	model sepalwidth=sepallength/ cli clm ;
run;
quit;
ods trace off;

data iris1;	
	merge sashelp.iris est(where=(variable="Intercept"));
	by species;
	if not first.species then Estimate=.;

	if first.species then x="y=0.9981x+0.123";
run;

data stat;
	set est(where=(variable="Intercept"));
run;

data  iris2;
	set sashelp.iris stat;
/*	est= put(Estimate,10.4);*/
	keep sepallength  sepalwidth Estimate  df species;
run;

proc sgpanel data= iris1;
	 title "Scatter plot for Fisher iris data";
	 panelby species 
/*				/ rows=2 columns=2 */
/*						uniscale=column uniscale=row*/
;
	 reg x=sepallength y=sepalwidth / cli="predicts limit" clm="xx";
/*	 rowaxis grid;*/
/*	 colaxis grid;*/
/*	 colaxistable Variable ;*/
	 format Estimate 10.4 ;
	 colaxistable  Estimate x;
run;

proc sgpanel data= iris2;
	 title "Scatter plot for Fisher iris data";
	 panelby species 
/*				/ rows=2 columns=2 */
/*						uniscale=column uniscale=row*/
;
	 reg x=sepallength y=sepalwidth / cli="predicts limit" clm="xx";
/*	 rowaxis grid;*/
/*	 colaxis grid;*/
/*	 colaxistable Variable ;*/
	 format Estimate 10.4 ;
	 colaxistable  Estimate ;
run;



proc sql; 
   create table minmax as
   select country, prodtype, min(actual) as min, max(actual) as max, count(actual) as num
   from sashelp.prdsale 
   group by country, prodtype;
quit;

data prdsale;
   set sashelp.prdsale minmax;
run;

title1 h=1.5 'Sales by Country';
ods graphics / reset outputfmt=png height=400px width=600px border;

proc sgpanel data=prdsale;
   styleattrs datacolors=(tan cxbdbdbd) 
              datacontrastcolors=(black black);
   panelby country / novarname columns=3 headerattrs=(size=12)
                     headerbackcolor=grayf5;
   vbox actual / category=prodtype group=prodtype capshape=line
                 dataskin=pressed meanattrs=(symbol=diamondfilled);
   colaxis display=(nolabel noticks novalues);
   rowaxis valueattrs=(size=10) labelattrs=(size=12);
   format min max dollar12.;
   colaxistable num / label='Num' position=bottom separator 
                      valueattrs=(size=10) labelattrs=(size=10);
   colaxistable min / label='Min' position=bottom separator 
                      valueattrs=(size=10) labelattrs=(size=10);
   colaxistable max / label='Max' position=bottom separator 
                      valueattrs=(size=10) labelattrs=(size=10);
   keylegend / title='' valueattrs=(size=12) autoitemsize;
run;
