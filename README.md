## What is this?

This folder contains the code for replicating the numerical results in 
``Fitting Tractable Convex Sets to Support Function Evauations''

## Running the codes
To replicate the run the scripts Experiment_*.m as it is.

While the procedures for computing the projection maps that specify the
estimator are themselves standalone (codes/vertexfit_lp.m, 
codes/vertexfit_sdp.m), the procedures for computing the Least Squares
Estimate (LSE) and the codes for displaying figures are not.  In 
particular, the code for computing the LSE is based on solving a convex
program proposed by Gardner and Kiderlen, and it requires the CVX parser 
along with a solver (e.g. SDPT3) to be installed.
http://cvxr.com/cvx/
The display of the figures also require the solution of a convex program,
and thus CVX, as well as a third party code called icosphere for creating
a regular-mesh on the 3d sphere
http://www.mathworks.com/matlabcentral/fileexchange/50105-icosphere
The file icosphere.m should be downloaded from this link and placed in the
folder /codes/ 

## Contact Information
If you encounter issues or have questions, please contact me at 
SOH_YONG_SHENG@IHPC.A-STAR.EDU.SG

## References
Finally, the CT scan is derived from the following online source:
http://radiopaedia.org/cases/normal-chest-ct-lung-window.
