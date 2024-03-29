.. _gui-Phase-unwrapping-standalone:
.. _Phase-unwrapping-standalone:
.. role::  raw-html(raw)
    :format: html

Phase Unwarpping Standalone
===========================

Phase unwrapping in QSM
-----------------------

Phase wrapping occurs when continuous phase information is sampled in a discrete wrapped phase. The measured phase accumulation larger than one phase cycle is wrapped into the interval [-:math:`\pi`, :math:`\pi`), causing the discontinuity in the phase data. To recover the true phase values, one must solve this ambiguity problem by adding the correct integer number of phase cycles to the phase data in order to recover the true phase revolution. 

The objective of this standalone application is to recover the actual, total phase shift of the acquired data.

Structure of the application
----------------------------

This standalone consists of two panels:

- I/O panel, and
- Total field recovery and phase unwrapping panel.

Description of each panel is given below:

I/O panel
^^^^^^^^^

.. image:: images/IO_panel_phaseunwrap.png

The I/O panel is responsible for data input/output and data processing that is not specific to QSM.

- Data input  

  There are two pathways to specify input in this application:

  1. Specify a directory that contains all essential data. 

    The essential data are:

    +--------------------+--------------------------------------------------------------------------------------------------------------------------+
    | Data               | Description                                                                                                              |
    +====================+==========================================================================================================================+
    | Phase              | 3D/4D phase data ([x,y,slice,time]), must contain 'ph' in the filename, e.g. *phase.nii.gz* or *ph.nii.gz*,              |
    +--------------------+--------------------------------------------------------------------------------------------------------------------------+
    | Magnitude          | 3D/4D magnitude data ([x,y,slice,time]), must contain 'mag' in the filename, e.g. *magn.nii.gz* or *mag.nii.gz*;         |
    +--------------------+--------------------------------------------------------------------------------------------------------------------------+ 
    | Header             | see :ref:`sepia-header` for more information, must contain 'header' in the filename, e.g. *header.mat*                   |
    +--------------------+--------------------------------------------------------------------------------------------------------------------------+ 
    | Mask               | (optional) 3D signal mask, if provided, must contain string 'mask' in the filename, e.g. *mask.nii.gz*                   |
    +--------------------+--------------------------------------------------------------------------------------------------------------------------+ 

    .. warning::
      Please make sure the filenames follow the above rules, or the BIDS specification (see **Data Input** in :ref:`Data-preparation`), and no other files in the directory sharing the same string labels (i.e. 'ph', 'mag', 'header' and 'mask').

  2. Specify the required data separately using the GUI buttons. 

- Output prefix

  By default, the output files generated by SEPIA will be stored in a directory named '*output*' under the directory of the input files (i.e. '_/your/input/directory/output/_'). The prefix of the output filename is '*Sepia*'. You can change the default output directory and prefix according to your preference. If the output directory does not exist, the application will create the directory.  

  .. note::
    Make sure the 'Output prefix' field contains a full path of the output directory and a filename prefix.
  
- Brain mask  

  You can optionally specify a signal (brain) mask NIfTI file. If this input is empty and no mask is found in the input directory, SEPIA will automatically run the FSL's brain extraction tool (bet) provided with the MEDI toolbox to compute the brain mask.

- FSL brain extraction (bet)

  Brain mask can be computed using the Matlab implementation of FSL's BET provided with MEDI toolbox, with options including fractional intensity threshold (-f) and vertical in fractional intensity threshold (-g). More information regarding the options can be found in `BET/UserGuide <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BET/UserGuide>`_.

- Refine brain mask using R2* (Multi-echo data only)
  
  If enable, a R2* map will be computed and used to threshold out high R2* voxels on the edges of the brain mask.

- Invert phase data   

  Checking this option will invert the contrast of the SEPIA output frequency and QSM maps. Mathematically it inverse the signal phase by computing the signal conjugate. It is useful if you want to have specific colour scheme for QSM (e.g. dark colour for paramagnetic susceptibility).

Total field recovery and phase unwrapping panel
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. image:: images/tf_panel.png

- Echo phase combination  

  Select a method for temporal phase unwrapping with multi-echo data.

  .. note::
    If the number of echoes is less than 3. 'Optimum weights' method will be automatically used.

  .. warning::
    The 'MEDI nonlinear fit (Bipolar, testing)' method is not fully supported yet.

- Phase unwrapping  

  Select a method for spatial phase unwrapping. 

  .. warning::
    The '3D best path' method might not work in most operating systems.
		
- Bipolar readout correction

  Correct the phase inconsistency between odd and even echoes, and a gradient-like (should be only in the readout direction) magnetic field contributed from eddy current due to bipolar readout.

- Save unwrapped echo phase
  
  Export all unwrapped echo phase images as NIfTI.
  
- Exclude voxels using residual, threshold:  

  Exclude voxels that have high relative residual based on a single compartment model fitting. The output data with suffix '*relative-residual.nii.gz* will be used for thresholding. For voxels that have intensity **higher** than the threshold will be **excluded** from subsequent processing. Two methods are supported to exclude those voxels: 

  1. 'Weighting map': Please see :ref: `weightings-in-sepia`` Section **Further modulation on the weighting maps**
  2. 'Brain mask': the excluded voxels will be excluded in the signal mask in the subsequent processing. This will affect both background field removal and QSM dipole inversion results.

  Only available for quantitative methods (i.e. '3D best path', 'Region growing (MEDI)', 'SEGUE' and 'ROMEO') and 'Graphcut' method. 

Others
^^^^^^

.. image:: images/start_button_anno.png

- Load config

  Import the method related settings specified in the SEPIA-generated config file to the SEPIA GUI. **NO** modification will be made in the I/O panel.

- Start

  Generate a SEPIA config file that contains all user-defined methods and parameters for QSM processing based on the setting in the GUI. SEPIA will run the config file immediately once it is generated.
