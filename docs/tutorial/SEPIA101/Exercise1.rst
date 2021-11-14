.. _sepia101-exercise1:
.. role::  raw-html(raw)
    :format: html

Exercise 1
==========

Objectives
----------

- Understanding the data required for QSM
- Understanding why we need to correct the phase data before mapping the magnetic susceptibility

Data Required
^^^^^^^^^^^^^

+--------------------+-----------------------------------------------------------------------------------------------------------------------+
| Data               | Description                                                                                                           |
+====================+=======================================================================================================================+
| *mag.nii.gz*       | magnitude of complex-valued multi-echo GRE data with 4 dimenions, [spatial_x,spatial_y,num_of_slices,num_of_echoes]   |
+--------------------+-----------------------------------------------------------------------------------------------------------------------+
| *phase.nii.gz*     | phase of complex-valued multi-echo GRE data with 4 dimenions, [spatial_x,spatial_y,num_of_slices,num_of_echoes]       |
+--------------------+-----------------------------------------------------------------------------------------------------------------------+ 
| *mask.nii.gz*      | 3D signal mask                                                                                                        |
+--------------------+-----------------------------------------------------------------------------------------------------------------------+ 
| *sepia_header.mat* | contains important information such as the echo times (TE) and magnetic field strength (in Tesla), and orientation of |
|                    | the acquisition regarding the physical coordinates of the scanner. These are important to compute the magnetic        |
|                    | susceptibility with the correct units and ensure the physical model is correct.                                       |
+--------------------+-----------------------------------------------------------------------------------------------------------------------+ 

Estimated time
^^^^^^^^^^^^^^

About 15 min.

Understanding multi-echo GRE data
---------------------------------

To compute a magnetic susceptibility map, multi-echo gradient-echo (mGRE) images are usually used because it can provide phase images related to the induced tissue magnetic field. 

.. toctree::
   :maxdepth: 1

   Theory_mrphase

Go to the data directory ``~/sepia_tutorial/sepia101_data/`` and have a look. 

You should be able to see three compressed NIfTI images (.nii.gz) and a SEPIA header file (.mat) in the directory. The NIFTI data is generated from a phantom dataset used in QSM Challenegs 2.0. It simulates data acquired with a 3D mGRE sequence at 7T. Both magnitude and phase images are 4D, with the first 3 dimensions containing spatial information (i.e. image of a brain) and **echo time in the 4th dimension**. 

.. note:: You can check :ref:`gettingstart-installation` to see what information is needed in the SEPIA header file and how to generate this file from standard DICOM/NIfTI conversion tools.

SEPIA is a QSM porcessing pipeline tool developed in Matlab. To use SEPIA, please first start a Matlab session. Once Matlab is open, go to the tutorial data directory (``~/sepia_tutorial/sepia101_data/``) in Matlab environment.

We will first give a brief explaination about our tutorial data:


Magnitude images
^^^^^^^^^^^^^^^^

#. Take a look of the magnitude images. You can do it in Matlab using the following commands:

   ``sepia_addpath``, and then

   ``view_nii(load_nii('mag.nii.gz'))``

   The first command will load all non-external functions in SEPIA, including the `NIfTI support for Matlab <https://nl.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image>`_ from Jimmy Shen. 

   The second command will call a NIfTi viewer to display the magnitude image. The display contrast is automatically adjusted in the viewer. 

   .. image:: images/exercise1_viewnii.png
      :align: center

   .. tip:: You can also do this with your favourite NIfTI viewer that allows visualising 4D data (e.g. ``FSLeyes``). If you use ``FSLeyes`` then adjust the display window to 'Min 0' and 'Max 150'. 

#. By default, the 1st echo data is displayed in the viewer. Use the slider in 'Scan ID' to see how the images change in time (time between echoes = 8 ms).

   .. image:: images/exercise1_scanid_slider.png
      :align: center

   You should be able to see the overall brightness of the images becomes dimmer in later echoes. It is because water protons was losing phase coherence (dephasing) over time. Roughly speaking, the greater is the dephasing phenomenon, the weaker is the signal. One of the causes of dephasing effect in GRE data is related to the field inhomogeneity caused by the local magnetic field from tissues. Tissues that have a lot of strong magnetic sources (e.g. iron stored in ferritin) will decay much faster than those with fewer/weaker sources. 

   .. tip:: If you are using ``FSLeyes``, you can also click the the movie button |movie| to see how the brain contrast changes with respect to the echo time in action.

   .. |movie| image:: images/exercise1_fsleyes_movie.png
      :scale: 70 %

#. Signals change in time on three locations on slice #103 (A, B, C) were plotted randomly representing 3 different types of tissue (deep grey matter, corical gray matter and white matter) as shown below. 

   **Question 1: Can you identify the locations A, B and C to the corresponding type of tissue? Observe the change of intensity differences of the tissues over time in the image viewer**

   .. image:: images/exercise1_q1.png
      :align: center

   .. toctree::
      :maxdepth: 1

      Exercise1_answer1


Phase images
^^^^^^^^^^^^

1. Now close the viewer. Open the phase images and change the colormap to 'Gray':

   ``view_nii(load_nii('phase.nii.gz'))``

   The phase images look quite different from the magnitude images. 

   .. image:: images/exercise1_viewnii_phase.png
      :align: center

   Even in the 1st echo phase, it is still possible to (vaguely) identify some such as globus pallidus, putamen, head of caudate nucleus and corticospinal tracts on slice #103. The structures also become clearer in later echoes (you can use the slider in 'Scan ID' as in the magnitude image exercise above).

   .. image:: images/exercise1_phase_dgm.png
      :align: center

2. In QSM, the phase of the GRE signal is assumed to be directly proportional to the frequency induced by local susceptibility sources in time, i.e.:

   .. math::
      phase = frequency \times time
      :label: pft

   In other words, we should observe the phase contrasts become greater in the later echoes (i.e. bright :raw-html:`&rarr;` brighter and dark :raw-html:`&rarr;` darker in the next echo). 
   
   This is true when we focus on some structures mentioned in Step 1 (e.g. globus pallidus, putamen and corticospinal tracts) but not always true for the caudate nucleus. Here is the plot of the phase over time in these structures:

   .. image:: images/exercise1_q2.png
      :align: center

   In the figure, you can see the phase development over time of the globus pallidus, putamen and corticospinal tracts are roughly linear but it is not the case with the head of caudate nucleus from which you can see the phase value first dropped from first echo to the second echo and then increased from the second echo to the last echo. The decrease of the phase value at the 2nd echo can be seen as the growing zebra-line pattern coming from the inferior frontal lobe toward the centre of the brain (location [75,128,103]). The pattern, if we watch it closely, is spreading not only from the edge to the centre of the brain but also as with the increase of echo time. 

   **Question 2: Which of the following is the cause of the problem?**

   .. toctree::
      :maxdepth: 1

      Exercise1_answer2A
      Exercise1_answer2B
      Exercise1_answer2C
      Exercise1_answer2D
      Exercise1_answer2E

   In order to estimate the frequency shift correctly using Eq. :eq:`pft`, this phase problem has to be addressed which is called phase unwrapping.

   To unwrap the phase and to map back to the correct values, SEPIA provides several algorithms to do the job, and this is what we are going to do in the next exercise.  

   You can close all the image viewer(s) now.

Proceed to :ref:`sepia101-exercise2`.
