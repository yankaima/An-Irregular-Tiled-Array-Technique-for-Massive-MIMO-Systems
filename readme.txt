Two cases have been shown in Matlab code. 
"Verification of equivalent modeling" is corresponding to section Ⅲ-A. Analysis of Irregular Array Architecture.
" Example_Case1" is corresponding to Fig.7 in the paper.

Noticing:
It is difficult to express the range of theta and phi if the array is located in yz plane
Hence, assume that the array is located in xy plane(it is different with paper. The detail illustration is in the figure).

phi is the azimuth angle, which is the angle between the x-axis and the projection of the arrival direction vector onto the xy plane. It is positive when measured from the x-axis toward the y-axis.
theta is the elevation angle, which is the angle between the arrival direction vector and xy-plane. It is positive when measured towards the z axis.(shown in figure)

theta=0 deg is corrsponding to x-axis; theta=90 deg is corrsponding to z-axis; 

Given the cellular situation(120deg coverage), the range of theta is [60,90]deg and the range of phi is [0, 360]deg. Actually, in practice, the antenna pattern can not cover 180deg due to the isotropic radiator can not exist.
