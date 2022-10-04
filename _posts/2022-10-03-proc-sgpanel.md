## graph: proc sgpanel 

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
