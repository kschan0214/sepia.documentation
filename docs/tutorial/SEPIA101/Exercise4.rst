.. _sepia101-exercise4:

Exercise 4
==========

Objectives
----------

- Understanding QSM dipole inversion
- Gaining experience to use QSM algorithms

Data Required
^^^^^^^^^^^^^

+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------+
| Data                              | Description                                                                                                               |
+===================================+===========================================================================================================================+
| *Sepia_default_localfield.nii.gz* | Local (tissue) field map in Hz , in *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/output_localfield/* |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------+
| *Sepia_default_mask_QSM.nii.gz*   | Signal mask for QSM step , in *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/output_localfield/*       |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------+
| *Sepia_header.mat*                | contains important information such as the echo times (TE) and magnetic field strength (in Tesla), and                    |
|                                   | orientation of the acquisition regarding the physical coordinates of the scanner. These are important                     |
|                                   | to compute the magnetic susceptibility with the correct units and ensure the physical model is correct                    |
|                                   | , in *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/*                                                  |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------------------+

Estimated time
^^^^^^^^^^^^^^

About 15 min.

The Last Step
-------------

The last step of QSM processing is to deconvolute the local (tissue) field by the unit dipole field, such that the tissue magnetic susceptibility can be revealed. This can be described by:

.. math::
   \chi = F^{-1}[\frac{F(Tissue field)}{F(d)}]
   :label: di

where :math:`F` and :math:`F^{-1}` are the Fourier and inverse Fourier transform operators.

This is the so-called dipole inversion of QSM, which is just the element-wise division between the Fourier transforms of the two images.

.. toctree::
   :maxdepth: 1

   Theory_dipoleinversion

Sounds simple, isn't it? Let's try it out!

QSM: Dipole inversion
---------------------
Move to the **QSM** tab of SEPIA. 

Exercise 4.1
^^^^^^^^^^^^
**I/O** panel:

1. Select the **or Local field** input: *Sepia_default_localfield.nii.gz* (in *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/output_localfield/*), 

2. Select the **SEPIA Header**: *Sepia_header.mat* (in *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/*),

3. Change the **Output prefix** of the output to: *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/output_localfield/output_qsm/Sepia_tkd-0*,

4. Select the **Brain mask**: *Sepia_default_mask_QSM.nii.gz* (in *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/output_localfield/*). 

   .. note:: An updated brain mask has to be used here because some edge voxels were excluded from the original brain mask in the last operation.

   .. image:: images/exercise4_io.png

**QSM** panel:

5. To do exactly the operation as in Eq. :eq:`di`, set the threshold of the **TKD** algorithm to '0' and press **Start**.

   .. image:: images/exercise4_qsm.png

6. Check the result *Sepia_tkd-0_Chimap.nii.gz* in the output directory. Set the display window to 'Min. -0.1' and 'Max. 0.1' (ppm). Does it look like the QSM map as we expected?

.. toctree::
   :maxdepth: 1

   Exercise4_answer1

Exercise 4.2
^^^^^^^^^^^^

To avoid the previous QSM map we can increase the threshold value of the **TKD**. 

#. Change the **Output prefix** to: *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/output_localfield/output_qsm/Sepia_tkd-0p15*.

#. Change the threshold of the **TKD** algorithm to 0.15 and press **Start**.

#. Check the result *Sepia_tkd-0p15_Chimap.nii.gz* in the output directory. Display it along with the *Sepia_tkd-0_Chimap.nii.gz*. Set the display window to 'Min. -0.1' and 'Max. 0.1' (ppm). Do you see any improvement?

.. toctree::
   :maxdepth: 1

   Exercise4_answer2

**Congratulations! You have finished all the exercises in this tutorial.** If you still have time left, finish the advanced exercises or experiment with different QSM methods/methods' parameters. 

Advanced Exercise 4.3
^^^^^^^^^^^^^^^^^^^^^

To further improve the quality of the QSM map, some methods, such as non-linear dipole inversion (NDI), incorporate additional information, e.g. SNR weighting, with advanced processing algorithm.

1. Update the **or Local field** input: *Sepia_rmin-3_localfield.nii.gz* (in *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/output_localfield/*), 
2. Select the **Weights** input: *Sepia_weights.nii.gz* (in *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/*), 
3. Change the **Output prefix** to: *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/output_localfield/output_qsm/Sepia_fansi*.
4. Ypdate the **Brain mask**: *Sepia_rmin-3_mask_QSM.nii.gz* (in *<extracted_folder>/converted/SIEMENS/Monopolar/GRE/output_unwrap/output_localfield/*). 
5. Change the **QSM** method to 'FANSI' and keep the default setting. Press **Start**. It will take about a few minutes to finish.

Back to :ref:`sepia101-exercise3`.
