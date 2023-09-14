.. _fmritoolkit2023-exercise4:

Exercise 4
==========

Objectives
----------

- Understanding QSM dipole inversion
- Comparing a QSM reconstruction and an R2* map and find the relevant deep gray matter nuclei visualizes
- Gaining experience to use QSM algorithms

Data Required
^^^^^^^^^^^^^

- a 3D recontructed R2* map (*Sepia_R2starmap.nii.gz* in the Exercise 2 output directory)
- a 3D recontructed QSM map (*Sepia_Chimap.nii.gz* in the Exercise 3 output directory)
- a 3D local field image (*Sepia_localfield.nii.gz* in the Exercise 3 output directory)
- a 3D refined brain mask (*Sepia_mask_QSM.nii.gz* in the Exercise 3 output directory)
- a SEPIA header (*Sepia_header.mat* in the input data directory)

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

This is the so-called dipole inversion of QSM, which is just the element-wise division between the Fourier transforms of the two images. It can also be seen as a deblurring process.

.. toctree::
   :maxdepth: 1

   Theory_dipoleinversion

One extra QSM reconstruction 
----------------------------
Move to the **QSM** tab of SEPIA. 

In the **I\O** panel, the 'LBV' method is shown by default. While this would be an acceptable option. In this tutorial we will choose the more robust to noise option **VSHARP**


   .. image:: images/STARset.PNG
      :align: center

In the **QSM** pannel there are various methods that have been implemented by different teams around the world.



1. Check the result *Sepia_tkd-0_QSM.nii.gz* in the output directory. Set the display window to 'Min. -0.2' and 'Max. 0.2' (ppm). Does it look like the QSM map as we expected?

.. toctree::
   :maxdepth: 1

   Exercise4_answer1

Exercise 4.2
^^^^^^^^^^^^

To avoid the previous QSM map we can increase the threshold of the **TKD**. 

#. Change the **Output basename** to: *~/qsm_tutorial/data/output_qsm/Sepia_tkd-0p15*. 

#. Change the threshold of the **TKD** algorithm to 0.15 and press **Start**.

#. Check the result *Sepia_tkd-0p15_QSM.nii.gz* in the output directory. Display it along with the *Sepia_tkd-0_QSM.nii.gz* in FSLView. Do you see any improvement?

#. Compare the location on the tissue edges (e.g. [133 155 81]) in this QSM map with what you can see in the mean magnitude image *mean_head.nii.gz*. Do the edges match between the two data now?

.. toctree::
   :maxdepth: 1

   Exercise4_answer2

**Congratulations! You have finished all the exercises in this tutorial.** If you still have time left, finish the advanced exercises or experiment with different QSM methods/methods' parameters. 

Advanced Exercise 4.3
^^^^^^^^^^^^^^^^^^^^^

To further improve the quality of the QSM map, some methods, such as Star-QSM, incorporate additional information, e.g. smoothness of the QSM map, during the QSM dipole inversion.

1. Change the **Output basename** to: *~/qsm_tutorial/data/output_qsm/Sepia_star-qsm*.
2. Change the **QSM** method to 'Star-QSM' and press **Start**. It will take about 2 mins to finish.

It is difficult to see the differences between the two QSM maps with the naked eyes. Subtract the two maps so that you can see the differences:

``fslmaths Sepia_tkd-0p15_QSM.nii.gz -sub Sepia_star-qsm_QSM.nii.gz difference_qsm``

3. Display the *difference_qsm.nii.gz* image (dispay window [-0.1,0.1]) in FSLView with *Sepia_star-qsm_QSM.nii.gz* (dispay window [-0.2,0.2]) and *Sepia_tkd-0p15_QSM.nii.gz* (dispay window [-0.2,0.2]) in the output directory. Can you see any difference between the two QSM maps?

.. toctree::
   :maxdepth: 1

   Exercise4_answer3

Back to :ref:`fmritoolkit2023-exercise3`.
