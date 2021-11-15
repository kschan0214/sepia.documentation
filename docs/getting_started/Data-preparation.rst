Data Preparation
================

**SEPIA** supports the following type of data input:  

- uncompressed or compressed NIfTI images (.nii and .nii.gz)  

.. warning::
    DICOM images input has been deprecated since v0.7.0.

NIfTI images
------------

NIfTI data is a handy way to work with **SEPIA**. **SEPIA** is mainly designed for 3D data. Therefore, the main standalone of **SEPIA** can only work with 3D/4D (row, column, slice, time) NIfTI data (3D for some standalone applications).  

Data conversion
^^^^^^^^^^^^^^^

SEPIA is tested with (but not limited to) the following three data conversion tools:

1. `dcm2niix <https://github.com/neurolabusc/dcm2niix>`_: Please make sure the 'merge' option (-m) is set to 'no' for the conversion (i.e. ``dcm2niix -m n``). In this way, multiple 3D volumes (the number of volumes depends on the number of echoes acquired) will be created together with the JSON files containing the TE of each echo (if you enable the merge option of dcm2niix you will only have one JSON file containing one TE). You can then merge the echo images into 4D using tools like `fslmerge <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils>`_.  

2. `dicm2nii <https://github.com/xiangruili/dicm2nii>`_

3. `MRIConvert <https://lcni.uoregon.edu/downloads/mriconvert>`_: Please have the following setting checked: 'Option' -> 'Save multivolumes series as 4D files':

    .. image:: images/mriconvert_save4d.png  

    In this way, your mGRE data will be stored as 4D FSL NIfTI data that is a valid input of **SEPIA**.  


Data input
^^^^^^^^^^

Once you have the NIfTI files ready, **SEPIA** provides two options to load the data: 

- select the required files directly, or  

- prepare the data with specific names and put all of them in a common directory, from which you can specify the input directory in **SEPIA**. The name requirement depends on the standalone you are working on. For more specific details please check the wiki pages of each standalone applications:

    - :ref:`Sepia-One-stop-QSM-processing`, e.g., 
        .. image:: images/one-stop-directory-input.png 

    - :ref:`Phase-unwrapping-standalone`, e.g., 
        .. image:: images/one-stop-directory-input.png 

    - :ref:`Background-field-removal-standalone` 
        .. image:: images/bfr-directory-input.png
    
    - :ref:`QSM-standalone` 
        .. image:: images/qsm-directory-input.png

- Brain Imaging Data Structure (BIDS) specification
    Starting from v1.0, it is possible to specify a directory that follows the BIDS specification as an input directory for **SEPIA** one-stop standalone application. Specifically, the following rules must be fulfilled:

    1. Filename of the phase data must contain the following 'key|label' pair: 'part-phase';

    2. Filename of the magnitude data must contain the following 'key|label' pair: 'part-mag';

    3. Filename of the JSON file must contain the following 'key|label' pair: 'part-mag';

    4. No NIfTI and JSON files other than the data for QSM processing that have filenames containing the 'key|label' pairs 'part-mag' and 'part-phase'.

    5. For multi-echo data, the 'key' labelled 'echo-' must present in the filename.

    Here is an example of a valid BIDS directory content for **SEPIA**

    .. image:: images/bids_directory.png  

