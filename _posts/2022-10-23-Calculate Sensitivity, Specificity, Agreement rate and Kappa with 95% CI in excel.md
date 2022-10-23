# Calculate Sensitivity, Specificity, Agreement rate and Kappa with 95% CI in excel(VBA)

## To QC the result of 2*2 table for non-programmers like PM 

1. get a, b, c, d with the PivotTable in excel
2. use formula to compute the result

![22](https://user-images.githubusercontent.com/114982176/197374442-fba3a1e8-a054-474f-a599-8378a3b3e975.PNG)

## standard normal distribution vs wilson
pay attention to the kappa of confidence interval, which is computed using the standard normal distribution and different from other parameters 

![kappa](https://user-images.githubusercontent.com/114982176/197374770-ce75272f-efdc-400b-926a-4a16f8409a14.PNG)

## you can also use VBA to get the same result above
![image](https://user-images.githubusercontent.com/114982176/197374928-140ec164-7032-42bd-996b-d1778e0deb7a.png)

reference 
https://ncss-wpengine.netdna-ssl.com/wp-content/themes/ncss/pdf/Procedures/PASS/Confidence_Intervals_for_Kappa.pdf
