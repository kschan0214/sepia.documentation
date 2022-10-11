Release note
============

1.2.0 (commit d2f54a3) 
----------------------------------
Release date: 11 October 2022

Toolbox related
^^^^^^^^^^^^^^^
* Support several deep learning based methods (BFRnet, xQSM, QSMnet+ and LP-CNN) on Linux
* Support atlas-based subcortical structure segmentation (CIT168 Reinforcement learning atlas, MuSus-100 and AHEAD) on Linux and Mac
* Integrate R2* mapping toolbox into SEPIA
* New function to further refine brain mask by thresholding high R2* voxels on brain edges
* When magnitude image is used for NDI, the image will be weighted by the intensity of the 99th percentile of the masked voxels instead of the maximum to improve robustness

1.1.1 (commit a7680bb) Patch update
-----------------------------------
Release date: 3 October 2022

Toolbox related
^^^^^^^^^^^^^^^
* New function to support refining brain mask before background field removal step
* Official support mritools v3.5.5 (https://github.com/korbinian90/CompileMRI.jl/releases/tag/v3.5.5), which included ROMEO and CLEAR-SWI
* 'ROMEO_HOME' is now renamed to 'MRITOOLS_HOME' in SpecifyToolboxesDirectory.m 
* Add GPU compatibility for NDI

Bug fix
^^^^^^^
* Fixed bug for full pipeline application and phase unwrapping standalone application used different bipolar readout correction implementations 
* Fixed bug for NDI when weight was used instead of weight^2

1.1.0 (commit 9ffe0e2)
----------------------
Release date: 22 September 2022

GUI related
^^^^^^^^^^^
* Experimental support to export phase image from real|imaginary images (could be useful for GE data)

Toolbox related
^^^^^^^^^^^^^^^
* Better compatibility with ROMEO, including loading config file with ROMEO parameter back to GUI
* New implementation of bipolar readout phase offset correction (no phase unwrapping is required) and provide the estimated phase offset map as output
* New implementation of incorporating relative residual map into the weighting map when the "Exclude voxels using reisdual" box is checked with "weighting map" option

Bug fix
^^^^^^^
* Several minor bugs fixed

Backend related (advanced user)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* New backend architecture for SWI/SMWI. Now new SWI or SMWI methods can be added to SEPIA usinf the add-on feature similar to other methods

1.0.1 (commit 3a2b387)
----------------------
Release date: 4 Aug 2022

Toolbox related
^^^^^^^^^^^^^^^
* Updated function performing phase conversion from arbitary DICOM values to radian (could result in minor numerical differences compared to previous versions if the input phase NIfTI not in radian)

Bug fix
^^^^^^^
* Fixed bug when phase NIfTI is in wrapped range with non-unity rescale slope (e.g. from Philips' scanners)
* Several other minor bugs fixed

1.0 (commit 8e35aee)
----------------------
Release date: 25 Feb 2022

GUI related
^^^^^^^^^^^
* New utility tool for managing external dependencies

Toolbox related
^^^^^^^^^^^^^^^
* Support ROMEO as total field computation and phase unwrapping method
* Support MRI susceptibility calculation methods for QSM dipole field inversion
* Support FANSI v3.0 (note that the algorithm parameters are adapted for this version)
* Improve BIDS compartibility with SEPIA
* Update output filenames in accordance with BIDS format 
* Improve the comparability of weighting maps across different datasets and methods
* GUI supports on managing toolbox dependencies

Bug fix
^^^^^^^
* Improve the robustness of measuring a reference phase point for B0 computation

Backend related (advanced user)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* New architecture for easier integration of new echo combination methods
* New data loading method to reduce memory usage during processing

0.8.1.1 (commit 52dd20b)
------------------------
Release date: 6 May 2021

Bug fix
^^^^^^^
* Fixed bug when using single-echo dataset
* Fixed bug when input phase data in unit of radian with single datatype

0.8.1 (commit c78247d)
----------------------
Release date: 4 Feb 2021

Toolbox related
^^^^^^^^^^^^^^^
* Log file and error message file are now paired (last 15 digits in the extension) instead of sorting in simple numerical order
* Log file and error message file are now generated in both GUI and command-based operations (when using ``sepiaIO``)
* When running SEPIA, the current directory will temporaily move to the output directory to avoid overwriting temporary files if multiple processings happen simultaneously
* A SEPIA pipeline configuration file will be automatically generated using ``sepiaIO`` is the output directory does not have any existing configuration file. This would be useful to look up the pipeline used to produce the results when using command-based operation

Bug fix
^^^^^^^
* Bug fix when running FANSI (see `here <https://github.com/kschan0214/sepia/issues/8>`_)
* Bug fix when getting B0 direction from Sagittal or Coronal acquisition (see `here <https://github.com/kschan0214/sepia/issues/10>`_)
* Bug fix when running QSM standalone with magnitude image for regularisation (see `here <https://github.com/kschan0214/sepia/issues/9>`_)
* Bug fix when running MEDI with zeropadding option is not equal to zero

Backend related (advanced user)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* Improved readiility of how the data are loaded in SEPIA, which could make better BIDS compartibility in the future

0.8.0 (commmit b4255d8)
----------------------
Release date: 18 July 2020

GUI related
^^^^^^^^^^^
* New layout for input/output panel for data selection
* New pipeline configuration file (sepia_config.m), log file (run_sepia.log) and error message file (run_sepia.error)
* New feature to load parameters in a pipeline configuration file (sepia_config.m) to the GUI
* New option to save unwrapped echo phase
* New option to exlcude unreliable voxels
* New option to select reference tissue for QSM normalisation/referencing
* New option to remove residual B1 field in local field using spherical harmonic function with adjustable order of the fitting

Toolbox related
^^^^^^^^^^^^^^^
* Support the lastest version of MEDI toolbox (Jan 15, 2020)
* Support extra brain extraction (FSL's BET) parameters from MEDI toolbox
* New 'percentage' option for MEDI+0 algorithm
* Support the lastest version of FANSI toolbox (commit dc68c306)
* New option to use `weak harmonic regularisation <https://onlinelibrary.wiley.com/doi/full/10.1002/mrm.27483>`_ with FANSI

Backend related (advanced user)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* Support developers adding a third-party method as an addon 
* Introduce tutorial scripts to guide developers on how to adding third-party method in SEPIA
* Introduce functions to simplify the workflow of creating new method panel
* The order of removal of residual B1 field and mask erosion is interchanged to produce better a fitting result

Bug fix
^^^^^^^
* Bug fix: running SEPIA without parrallel computing toolbox
* Bug fix: running MEDI toolbox nonlinear fit echo phase combination with 2 echoes
* Bug fix: running MEDI method in SEPIA
* Bug fix: running single echo data with exclusion of unreliable voxels option enabled

**Please update the MEDI toolbox (Jan 15, 2020) and FANSI toolbox (commit dc68c306) to the lastest version for the best performance.**

0.7.3 (commmit 68c53bc)  
-----------------------
Release date: 9 Nov 2019

* Support `nonlinear dipole inversion (NDI) <https://github.com/polakd/NDI_Toolbox>`_ as external library
* Support `SEGUE <https://xip.uclb.com/i/software/SEGUE.html>`_ as external library

0.7.2 (commmit bf020ce)  
-----------------------
Release date: 4 Jun 2019

* Support single-echo dataset
* Bug fix with odd-number matrix dimension by zero-padding
* Offload unuse variables to reduce memory usage
* Bug fix for reading NIfTI when the rescale slope and intercept are not 1 and 0

0.7.1 (commmit dc51fbe)  
-----------------------
Release date: 9 May 2019

* Support simple susceptibility weighted imaging (SWI) and susceptibility map weighted imaging (SMWI) as part of the GUI
* resolved loading/saving NIfTI issue related to 0.7.0 update
* DICOM input is deprecated: the only possible input is NIfTI data
* fixed bug when running MEDI with CSF regularisation
* fixed bug for single echo SWI
* now support automatic magnitude and phase images detection with name containing string "mag" for magnitude image and "ph" for phase image  
* fixed global phase offset with graph-cut phase unwrapping

0.7.0 (commmit e66d8e4)  
-----------------------
Release date: 12 Apr 2019

* redesigned log file format; the algorithms and parameters being used are much clearer and neat than before (previous log file cannot work in this version)
* resolved '.nii.nii' issue when using STI suite algorithms
* resolved no. of iterations with FANSI does not change issue
* resolved problematic QSM results with FANSI when an input matrix is an odd number
* resolved excluded unreliable voxels issue when 3D best path algorithm doesn't work
* improved build-in VSHARP results when there are masked voxels on the image edges
* added image erosion function for background field removal algorithms
* get header function is now compatible with the JSON files generated by dcm2niix and dicm2nii

0.6.0 (commmit 1c27dc4)  
-----------------------
Release date: 1 Sep 2018

* updated diretcory structure
* added options to select individual files  
