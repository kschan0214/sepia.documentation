.. _sepia101-exercise2:

Exercise 2
==========

Objectives
----------

- Gaining experience in using SEPIA
- Understanding how to perform phase unwrapping

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

About 20 min.

SEPIA
-----

Now, go the data directory in the Matlab's command window and start sepia:

``cd ~/sepia_tutorial/sepia101_data/`` 

``sepia``

A graphical user interface (GUI) should appear right away. 

.. image:: images/exercise2_gui.png
   :align: center

There are several tabs in SEPIS corresponding to usage of SEPIA in various tasks. The first tab in SEPIA provides a one-step application to process QSM from the raw phase data to a magnetic susceptibility map. Alternatively, we can break down the processing pipeline into several steps and SEPIA also supports this approach. 

In the following exercises, we will go for the second approach in this tutorial such that we can explain the QSM processing step by step.

Phase Unwrapping and Total Field Computation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

From exercise 1, we understand the raw phase GRE data is affected by the phase wrapping issue which stops us from computing the frequency shift correctly using the phase data.

To correct the wrapped phase in the raw images, go the **Phase unwrapping** tab (next to **SEPIA** tab). 

You will see two panels under the tab: the **I/O** panel is for specifying data input and output and the **Total field recovery and phase unwrapping** panel is for selecting phase unwrapping and true phase estimation algorithms.

.. tip:: SEPIA supports two data input routines: (1) If your data follows the SEPIA naming structure, you can select the directory containing all the input data as your input in the first row of **I/O** panel. (2) Alternatively, you can specify the input files separately by following the instruction of the second row of the **I/O** panel. 

In the **I/O** panel:

#. Select the **Input directory**: *~/sepia_tutorial/sepia101_data/*
#. Change the **Output prefix** to: *~/sepia_tutorial/sepia101_data/output_unwrap/Sepia*

   .. image:: images/exercise2_phase_unwrap_io.png

In the **Total field recovery and phase unwrapping** panel: 

#. Keep the **Echo phase combination** method as 'Optimum weights'. 

   This option is to determine how the phase information in time will be combined for multi-echo data. Here we decided to combined the phase information based on SNR weighting. 

#. Change the **Phase unwrapping** method to 'SEGUE'. 

   This option is to determine the algorithm to spatially unwrap the phase. 'SEGUE' is a region growing based method.

#. Check **Exlcude voxels using residual, threshold:** option. 

   This optino allows us to create a new weighting map based on how closely the signal evolves like a simple linear model. 

#. Check **Save unwrapped echo phase** option. 

   This option allows us to save the unwrapped phase for each echo.

   .. image:: images/exercise2_phase_unwrap_algorithm.png
      :align: center

Then click the **Start** button at the bottom of the GUI.

You should now see some messages regarding the general information of your input data and the overview of the selected method(s) displaying on the Matlab's command window. Once the process finishes (a few minutes), you will see the message meaning the processing is finished.

'*Processing pipeline is completed!*'. 

.. tip:: All the output messages of SEPIA will be displayed on the Matlab command window. Make sure you check the command window before clicking the **Start** button again!

Once the process is finished, you should be able to see the following output in the output directory (*~/sepia_tutorial/sepia101_data/output_unwrap/*)

+-----------------------------------+--------------------------------------------------------------------------------------------------------+
| Output data                       | Description                                                                                            |
+===================================+========================================================================================================+
| *sepia_config.m*                  | Automatic generated script by the GUI of SEPIA containing all user specified parameters                |
+-----------------------------------+--------------------------------------------------------------------------------------------------------+
| *run_sepia.log*                   | Event log file of the Matlab's command window output                                                   |
+-----------------------------------+--------------------------------------------------------------------------------------------------------+ 
| *Sepia_total-field.nii.gz*        | Unwrapped total frequency shift in Hz                                                                  |
+-----------------------------------+--------------------------------------------------------------------------------------------------------+ 
| *Sepia_relative-residual.nii.gz*  | Relative residual derived using mono-exponential model with a single frequency shift (if voxel         |
|                                   | exclusion is selected)                                                                                 |
+-----------------------------------+--------------------------------------------------------------------------------------------------------+ 
| *Sepia_mask-reliable.nii.gz*      | Derived from thresholding relative-residual map using user-defined value                               |
+-----------------------------------+--------------------------------------------------------------------------------------------------------+ 
| *Sepia_noise-sd.nii.gz*           | Estimated standard deviation of noise in the phase data                                                |
+-----------------------------------+--------------------------------------------------------------------------------------------------------+ 
| *Sepia_unwrapped-phase.nii.gz*    | Unwrapped phase data in radian                                                                         |
+-----------------------------------+--------------------------------------------------------------------------------------------------------+ 
| *Sepia_weights.nii.gz*            | SNR-weighted image derived from standard deviation of noise in phase data                              |
+-----------------------------------+--------------------------------------------------------------------------------------------------------+ 

Let's have a look of the unwrapped phase first (*Sepia_unwrapped-phase.nii.gz*), assuming you are still in the data directory (*~/sepia_tutorial/sepia101_data/*) in Matlab. 

``view_nii(load_nii('output_unwrap/Sepia_unwrapped-phase.nii.gz'))``

Try to see the phase of each echoes using the slider of 'Scan ID'. Now you shall see that all the zebra-line pattern and phase jumps are gone in the later echo images. If we plot the phase of the brain structure in Exercise 1, the phase of the caudate nucleus also evolves linearly after phase unwrapping.

.. image:: images/exercise2_unwrapped_phase_plot3.png
   :align: center

With the correctly unwrapped phase, we can compute the total frequency shift (*Sepia_total-field.nii.gz*) in the tissue from the phase using the following equation:

.. math::
   frequency = \frac{phase}{time}
   :label: fpt

Open the total frequency shift (or field) map and see how it looks like:

``view_nii(load_nii('output_unwrap/Sepia_total-field.nii.gz'))``

In the total field map, we can vaguely see some brain structures but they seems to be hidding behind something. It is because the total field map has contributions from not only the tissues but also background sources such as air/tissue interface which have strong magnetic susceptibility creating magnetic fields that can affect the whole brain. To be able to compute tissue magnetic susceptibility, the field effect from background (non-tissue) sources has to be removed from the total field.

You can close the image viewer now.

Proceed to :ref:`sepia101-exercise3`.

Back to :ref:`sepia101-exercise1`.
