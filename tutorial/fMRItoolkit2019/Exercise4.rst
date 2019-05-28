.. _fmritoolkit2019-exercise4:

Exercise 4
==========

Objectives
----------

- Understanding 
- Gaining experience to use QSM algorithms

Data Required
^^^^^^^^^^^^^

- a 3D local field image (*Sepia_peel-4_local-field.nii.gz* in the previous exercise output directory)
- a 3D refined brain mask (*Sepia_peel-4_mask-qsm.nii.gz* in the previous exercise output directory)
- a SEPIA header (*Sepia_header.mat* in the input directory)

Estimated time
^^^^^^^^^^^^^^

Less than 15 min.

The Last Step
-------------

The last step of QSM processing is to deconvolute the local (tissue) field by the unit dipole field such that the tissue magnetic susceptibility can be revealed. This can be described by:

.. math::
   \chi = F^{-1}[\frac{F(Tissue field)}{F(d)}]
   :label: di

where :math:`F` and :math:`F^{-1}` are the Fourier and inverse Fourier transform operators.

This is the co-called dipole inversion of QSM, which is just the division between the Fourier transforms of the two images.

[See theory]

Sounds simple, isn't it? Let's try it out!

QSM: Dipole inversion
---------------------
Move to the **QSM** tab of SEPIA. 

Exercise 4.1
^^^^^^^^^^^^

#. Select the **Local field** input: *Sepia_peel-4_local-field.nii.gz* from the previous exercise output directory. 
#. Select the **Header**: *Sepia_header.mat*.
#. Change the basename of the output to: *sepia_tkd-0*. 
#. Select the **Brain mask**: *Sepia_peel-4_mask-qsm.nii.gz* from the previous exercise output directory.
#. To do exactly the operation as in Eq. :eq:`di`, set the threshold of the **TKD** algorithm to '0' and press **Start**.
#. Check the result *Sepia_tdf-0_QSM.nii.gz* in the output directory. Set the dispay window to 'Min. -0.2' and 'Max. 0.2' (ppm). Does it look like the QSM map as we expected?

[See theory]

Exercise 4.2
^^^^^^^^^^^^

To avoid the previous QSM map we can increase the threshold of the **TKD**. 

#. Change the basename of the output to: *sepia_tkd-0p15*. 
#. Change the threshold of the **TKD** algorithm to 0.15 and press **Start**.
#. Check the result *Sepia_tkd-0p15_QSM.nii.gz* in the output directory. Display it along with the *Sepia_tkd-0_QSM.nii.gz* in FSLeyes using the '+' button. Do you see any improvement?
#. Compare the location of the tissue edges in this QSM map with what you can see in the mean magnitude image *mag_mean.nii.gz*. Do the edges match between the two data now?

[See theory]

Exercise 4.3
^^^^^^^^^^^^

To further improve the quality of the QSM map, some methods, such as FANSI, incorporate the tissue contrasts in magnitude images during the QSM dipole inversion.

#. Select the **Magnitude** input: *mag.nii.gz*
#. Change the basename of the output to: *sepia_fansi*.
#. Change the **QSM** method to 'FANSI' and press **Start**. It will take about 15 mins to finish.
#. Check the result *Sepia_fansi_QSM.nii.gz* in the output directory. Display it along with the *Sepia_tdf-0p15_QSM.nii.gz* in FSLeyes. Can you see any difference?

[See theory]

Congratulations! You have finished all the exercises in this tutorial. If you still have time left, play around different QSM methods or methods' parameters. 
