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

In the **I\O** panel, we will now simply select the data required to perform the QSM step, starting from the previously preprocessed data.

#. Select the **Local field**: *~/QuantitativeTutorial/outputQSM/Sepia_localfield.nii.gz*
#. Select the **weights**: *~/QuantitativeTutorial/outputQSM/Sepia_weights.nii.gz*
#. Select the **Brain Mask**: *~/QuantitativeTutorial/outputQSM/Sepia_mask_QSM.nii.gz*
#. Select the **SEPIA header**: *~/QuantitativeTutorial/data/sepia_header.mat*
#. Change the **Output basename** to: *~/QuantitativeTutorial/outputQSM/SepiaSTAR*

Note 1: The various preprocessing steps will erode the brain mask, resulting in a final brain mask that is significantly tighter. 
Note 1: More advanced methods of QSM benefit from knowing about the confidence you have on your measured fieldmap, that information is embedded on 'weights'

   .. image:: images/STARset.PNG
      :align: center

In the **QSM** you will now choose the STAR method (Wei et al, NMR in Biomed, 2015).

Press **start** on the SEPIA window and continue the exercise.

In the Exercise 2 you already had a chance to see many iron rich strucures throught out the brain.

   .. image:: images/DeepGM_rois.jpg
      :align: center

   1, Caudate Nucleus;   2, Globus pallidus;   3, Putamen,   4, Thalamus;    5, Substantia Nigra;   6, Red Nucleus;    7, Dentate Nucleus;
   Figure from Chai et al, Front. Neurosci., 2022

Return to the terminal and type

``fsleyes outputR2star/Sepia_R2starmap.nii.gz -dr 0 50 outputQSM/SepiaSTAR_Chimap.nii.gz -dr -0.15 0.2 outputQSM/Sepia_Chimap.nii.gz -dr -0.15 0.2 outputQSM/Sepia_localfield.nii.gz -dr -5 5 ``


As the top layer you will have the local field map that you have already seen on the previous exercise.

While many of the deep gray matter regions mentioned above are clear discernible, with very sharp edges, the intensity inside the regions is not very different than that of White Matter.

If you now  remove the visibility of this first layer you will be able to see the reconstructed QSM (TKD) where these ROIs are now visible and have a stron positive contrast (meaning they have paramagnetic contrast).

If you now vary between the visibility of the two QSM reconstructions you will note that SepiaSTAR_Chimap has less deconvolution artifacts and that the edges of Iron rich structures have less artifacts on the edges.


   .. image:: images/FSLeyesQSM.PNG
      :align: center

   
Finally you can appreciate the difference between the R2* and Star QSM recosntruction.
Points to note:

- the reduced mask size associated with the QSM reconstruction;

- while the R2* map has a strong tissue CSF contrast, this is vanished in the QSM showing that the magnetic properties of most brain tissue is comparable

- appreciate the increased visibility of the Substantia Nigra and Dentate Nucleus on the QSM map.


**Congratulations! You have finished all the exercises in this tutorial.** If you still have time left, finish the advanced exercises or experiment with different QSM methods/methods' parameters or move to the next exercise that will show you how to get Synthetic images out of some of these iamges and maps. 



Back to :ref:`fmritoolkit2023-exercise3`.
Proceed to :ref:`fmritoolkit2023-exercise5`.
