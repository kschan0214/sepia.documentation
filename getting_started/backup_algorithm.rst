- Echo phase combination  

  As the first step to process the multi-echo data, we need to recover the total frequency shift of the tissue across times. SEPIA provides two different ways to do this:

  1. `Optimum weights <https://doi.org/10.1002/nbm.3601>`_  

    This is a weighted combination of the phase difference between successive echoes, in which the weights are inversely proportional to the variance of the noise of the fieldmap estimated from the magnitude echo images.

  2. **MEDI nonlinear fit**  

    This is a method in the MEDI toolbox  

- Phase unwrapping  

  There are 5 phase unwrapping method supported in SEPIA

  1. `Laplacian <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_ 

    Laplacian unwrapping implementation in MEDI toolbox

  2. `Laplacian STI suite <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_  

    Laplacian unwrapping implementation in STI Suite v3.0  

  3. `3D best path <https://doi.org/10.1364/AO.46.006623>`_   

    Robust region growing method yet only works in the DCCN cluster (recommended if you use this toolbox in the DCCN cluster)  

  4. **Region growing**  
  
    Region growing method in the MEDI toolbox 
  
  5. `Graphcut <https://doi.org/10.1109/TMI.2014.2361764>`_  

    Graph-cut algorithm in the MEDI toolbox, sometimes uses with water-fat imaging.
		
- Bipolar readout eddy current correction:   

  enable to correct the phase inconsistency between odd and even echoes, and a gradient-like field contribution by eddy current effect due to bipolar readout.
  If this option is enabled, the eddy current corrected data will be stored in the output directory with the following name:

  - *phase_eddy-correct.nii.gz* (eddy current corrected phase data) 
  
- Exclude unreliable voxels, Threshold:  

  enable to exclude low SNR voxels that can create strong artefacts in susceptibility map (you may check with '*relative-residual.nii.gz*' to adjust the threshold). Voxels that have relative fitting residual greater than the threshold will be weighted with zero in subsequent processes. Only available for region growing and 3D best path unwrapping methods. 

- Output  

  The output of this step are given below:

  - *total-field.nii.gz* 	(unwrapped total (background+local) field, in Hz)  
  - *fieldmap-sd.nii.gz* 	(normalised field map standard deviation)  
  - *mask.nii.gz* (FSL's bet brain mask, optional)
  - *mask-reliable.nii.gz* (thresholded brain mask, optional)
  - *relative-residual.nii.gz* (relative residual of fitting a mono-exponential decay function with a single frequnecy shift, depends on unwrapping method)

Background field removal panel
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Method

  1. `LBV <https://doi.org/10.1002/nbm.3064>`_  

     Laplacian boundary value approach to removal background field  

  2. `PDF <https://doi.org/10.1002/nbm.1670>`_  

     Projection onto dipole field  

  3. `RESHARP <https://doi.org/10.1002/mrm.24765>`_  

     regularisation enabled SHARP  

  4. `SHARP <https://doi.org/10.1016/j.neuroimage.2010.10.070>`_  

     Sophisticated harmonic artefact reduction for phase data  

  5. `VSHARP STI suite <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_   

     STI suite v3.0 variable-kernel SHARP 

  6. `VSHARP <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_  

  7. `iHARPERELLA <https://doi.org/10.1002/nbm.3056>`_   

     (not optimised with SEPIA yet)  

- Refine local field by 4th order 3D polynomial fit  

  Enable to remove residual B1(+ & -) contribution in the local field

- Output  

  The output of this step are given below:

  - *local-field.nii.gz* (local (or tissue) field, in Hz)  
  - *mask-qsm.nii.gz* (brain mask where local field is reliable, might be eroded and depended on the background field removal algorithms and '**exclude unreliable voxels**' threshold value)  

QSM panel
^^^^^^^^^

- Method:

  1. `TKD <https://doi.org/10.1002/mrm.22334>`_  

     Thresholded k-space division

  2. `Closed-form solution <https://doi.org/10.1002/jmri.24365>`_  

     closed-form solution with L2-norm regularisation

  3. `STI suite iLSQR <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_  

     STI suite v3.0 implementation of iterative LSQR approach

  4. `iLSQR <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_


  5. `FANSI <https://doi.org/10.1002/mrm.27073>`_  

     Fast algorithm for nonlinear susceptibility inversion

  6. `Star <https://doi.org/10.1002/nbm.3383>`_ 

     STI suite v3.0 Star-QSM (recommended)

  7. `MEDI <https://doi.org/10.1002/mrm.26946>`_  

     Morphology enabled dipole inversion (MEDI+0)   
  
- Output     

  The output of this step is given below:

  - *QSM.nii.gz* (quantitative susceptibility map, in ppm) 