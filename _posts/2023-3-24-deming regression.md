#deming regression using Jackknife Standard Error Estimation

![image](https://user-images.githubusercontent.com/57244999/227522349-0b1c8178-2885-4d99-aa3f-82fbacc16325.png)
from https://www.lexjansen.com/pharmasug/2017/TT/PharmaSUG-2017-TT12.pdf

Algorithm 算法
0. lambda 
default value: lambda=1

Please read this paper: Performance of Deming regression analysis in case of misspecified analytical error ratio in method comparison studies
https://academic.oup.com/clinchem/article/44/5/1024/5642675

![image](https://user-images.githubusercontent.com/57244999/227524360-f0c78d8e-d389-4976-84fc-f8aa2cabe5b2.png)

use quality-control data to get lambda (λ=SD**2<refer>/SD**2<test>) if the sample is measured once
  

1.斜率+截距 slope and intercept 

![image](https://user-images.githubusercontent.com/57244999/227521018-0bf8fac9-7a43-4ab4-b037-e9e7ea2c48eb.png)

2. 区间95% CI using Jackknife Standard Error Estimation
![image](https://user-images.githubusercontent.com/57244999/227521250-dcb8a3fe-7247-4187-a01c-c797392aee10.png)

3.sas macro
https://analytics.ncsu.edu/sesug/2009/CC014.Deal.pdf

Reference:
https://www.ncss.com/wp-content/themes/ncss/pdf/Procedures/NCSS/Deming_Regression.pdf

https://doi.org/10.1093/clinchem/44.5.1024
