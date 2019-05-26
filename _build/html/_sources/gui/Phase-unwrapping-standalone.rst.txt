Phase Unwarpping Standalone
===========================

Why do we need phase unwrapping?
--------------------------------

Phase wrapping occurs when continuous phase information is sampled in a discrete wrapped phase. The measured phase accumulation larger than one phase cycle is wrapped into the interval [-:math:`\pi`, :math:`\pi`), causing the discontinuity in the phase data. To recover the true phase values, one must solve this ambiguity problem by adding the correct integer number of phase cycles to the phase data in order to recover the true phase revolution. 

The objective of this standalone application is to recover the actual, total phase shift of the acquired data.

Structure of the application
----------------------------

This standalone consists of two panels:

- I/O panel, and
- Total field recovery and phase unwrapping panel.

The detailed description of each panel is given below:

I/O panel
^^^^^^^^^

.. image:: images/phase-unwrapping_io.png

- Data input  

  This application accepts three types of data input method:

  1. Specify a directory that contains all DICOM images,
  2. Specify a directory that contains all NIfTI images. Please specify the names of your data as in the following:
     - **Phase**: must contain the string 'ph' in the filename, e.g. *phase.nii.gz*;
     - **Magnitude**: must contain the string 'mag' in the filename, e.g. *magn.nii.gz*;
     - **Header**: must contain the string 'header' in the filename, e.g. *header.mat*;
     - (optional) **Mask data**: if provided, must contain string 'mask' in the filename, e.g. *mask.nii.gz*, or
  3. Specify the required data separately using the GUI buttons. 

- Data output  

  You can specify the prefix of the data output name in the editable field 'Output basename'. By default, the **SEPIA** output will be stored in a directory named '*output*' under the input directory, i.e. '_/your/input/directory/output/_' with prefix '*sepia*'. You can change the default output directory and basename to whatever you need. If the output directory does not exist, the application will create the directory.

- Brain mask  

  QSM related algorithms often require a mask that contains only brain tissue. If you already have the brain mask data in NIfTI format, you can select the file manually, or named it with a specific name (see **Data input** section) and put it in the directory with other NIfTI files. Alternatively, you can check the '**FSL brain extraction**' checkbox to extract the brain mask. Enabling this option will run the Matlab implementation of FSL's brain extraction tool (bet) implemented with MEDI toolbox.    
 
- Invert phase data   

  Due to the way of how the phase data is stored, values of the final local field map and/or magnetic susceptibility map might be inverted, i.e. positive frequency shift and paramagnetic magnetic susceptibility will show in negative, and vice versa. If it is the case, you can invert the values of the results by checking the '**Invert phase data**' option. This will apply a conjugate operation to the phase data after the data being loaded.


Total field recovery and phase unwrapping panel
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. image:: images/phase-unwrapping_total-field.png

- Echo phase combination 

  As the first step to process the multi-echo data, we need to recover the total frequency shift of the tissue across times. **SEPIA** provides two different ways to do this:

  1. `Optimum weights <https://doi.org/10.1002/nbm.3601>`_  

    This is a weighted combination of the phase difference between successive echoes, in which the weights are inversely proportional to the variance of the noise of the fieldmap estimated from the magnitude echo images.

  2. **MEDI nonlinear fit**  

    This is a method in the MEDI toolbox   

- Phase unwrapping  

  There are 5 phase unwrapping method supported in **SEPIA**

  1. `Laplacian <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_  

    Laplacian unwrapping implementation in MEDI toolbox

  2. `Laplacian STI suite <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_  

    Laplacian unwrapping implementation in STI Suite v3.0  

  3. `3D best path <https://doi.org/10.1364/AO.46.006623>`_   

    Robust region growing method yet only works in the DCCN cluster (recommended if you use this toolbox in the DCCN cluster)  

  4. **Region growing**  

    Region growing method in MEDI toolbox 
  
  5. `Graphcut <https://doi.org/10.1109/TMI.2014.2361764>`_  

    Graph-cut algorithm in MEDI toolbox, usually uses in water-fat imaging.
		
- Bipolar readout eddy current correction:   

  enable to correct the phase inconsistency between odd and even echoes, and a gradient-like field contribution by eddy current effect due to bipolar readout.
  If this option is enabled, the eddy current corrected data will be stored in the output directory with the following name:

  - *phase_eddy-correct.nii.gz* (eddy current corrected phase data)
	
- Exclude unreliable voxels, Threshold:  

  enable to exclude low SNR voxels that can create strong artefacts in susceptibility map (you may check with '*relative-residual.nii.gz*' to adjust the threshold). Voxels that have relative fitting residual greater than the threshold will be weighted with zero in subsequent processes. Only available for region growing and 3D best path unwrapping methods.     
	
- Output  

  The output of the standalone application is given below:

  - *total-field.nii.gz* 	(unwrapped total (background+local) field, in Hz)  
  - *fieldmap-sd.nii.gz* 	(normalised field map standard deviation)  
  - *mask.nii.gz* (FSL's bet brain mask, optional)
  - *mask-reliable.nii.gz* (thresholded brain mask, optional)
  - *relative-residual.nii.gz* (relative residual of fitting a mono-exponential decay function with a single frequnecy shift, optional)