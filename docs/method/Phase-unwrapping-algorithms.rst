Phase Unwarpping Algorithms
===========================

Phase unwrapping in QSM
-----------------------

Phase wrapping occurs when continuous phase information is sampled in a discrete wrapped phase. The measured phase accumulation larger than one phase cycle is wrapped into the interval [-:math:`\pi`, :math:`\pi`), causing the discontinuity in the phase data. To recover the true phase values, one must solve this ambiguity problem by adding the correct integer number of phase cycles to the phase data in order to recover the true phase revolution. 

The objective of this standalone application is to recover the actual, total phase shift of the acquired data.

Supported algorithms in SEPIA
-----------------------------

Echo phase combination 
^^^^^^^^^^^^^^^^^^^^^^

Temporal phase unwrapping with multi-echo data

1. `Optimum weights <https://doi.org/10.1002/nbm.3601>`_  

  This is a weighted combination of the phase difference between successive echoes, in which the weights are inversely proportional to the variance of the noise of the fieldmap estimated from the magnitude echo images.

2. **MEDI nonlinear fit**  

  This is a method in the MEDI toolbox  

3. `ROMEO total field calculation <https://doi.org/10.1002/mrm.28563>`_
  
  This is the method kindly provided from the ROMEO team. Please check the ROMEO GitHub page for the detailed arguments (settings).


Phase unwrapping
^^^^^^^^^^^^^^^^

Spatial phase unwrapping

1. `Laplacian (MEDI) <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_ 

  Laplacian unwrapping implementation in MEDI toolbox

2. `Laplacian (STI suite) <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_  

  Laplacian unwrapping implementation in STI Suite v3.0  

3. `3D best path <https://doi.org/10.1364/AO.46.006623>`_   

  Robust region growing method yet only works in the DCCN cluster (recommended if you use this toolbox in the DCCN cluster)  

4. **Region growing (MEDI)**  

  Region growing method in the MEDI toolbox 

5. `Graphcut <https://doi.org/10.1109/TMI.2014.2361764>`_  

  Graph-cut algorithm in the MEDI toolbox, sometimes uses with water-fat imaging.

6. `SEGUE <https://doi.org/10.1109/TMI.2018.2884093>`_

7. `ROMEO <https://doi.org/10.1002/mrm.28563>`_

  Using ROMEO for single phase unwrapping only. 
