Data Preparation
================

**SEPIA** supports the following type of data input:  

- uncompressed or compressed NIfTI images (.nii and .nii.gz)  

.. warning::
    DICOM images input has been deprecated since v0.7.0.

NIfTI images
------------

NIfTI data is a handy way to work with **SEPIA**. **SEPIA** is mainly designed for multi-echo GRE (mGRE) data. Therefore, the main standalone of **SEPIA** can only work with 4D (row, column, slice, time) NIfTI data (3D for some standalone applications).  

Data conversion
^^^^^^^^^^^^^^^

SEPIA is tested with (but not limited to) the following three data conversion tools:

1. `MRIConvert <https://lcni.uoregon.edu/downloads/mriconvert>`_: Please have the following setting checked: 'Option' -> 'Save multivolumes series as 4D files':

    .. image:: images/mriconvert_save4d.png  

    In this way, your mGRE data will be stored as 4D FSL NIfTI data that is a valid input of **SEPIA**.  

2. `dcm2niix <https://github.com/neurolabusc/dcm2niix>`_: Please make sure the 'merge' option (-m) is set to 'no' for the conversion (i.e. ``dcm2niix -m n``). In this way, multiple 3D volumes (the number of volumes depends on the number of echoes acquired) will be created together with the JSON files containing the TE of each echo (if you enable the merge option of dcm2niix you will only have one JSON file containing one TE). You can then merge the echo images into 4D using tools like `fslmerge <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils>`_.  

3. `dicm2nii <https://github.com/xiangruili/dicm2nii>`_

Data input
^^^^^^^^^^

Once you have the NIfTI files ready, **SEPIA** provides two options to load the data: 

- select the required files directly, or  
- prepare the data with specific names and put all of them in a common directory, from which you can specify the input directory in **SEPIA**. The name requirement depends on the standalone you are working on. For more specific details please check the wiki pages of each standalone applications. 