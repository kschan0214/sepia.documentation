.. _fmritoolkit2023-exercise3:
.. role::  raw-html(raw)
    :format: html

Exercise 3
==========

Objectives
----------

- Understanding QSM works  
- Fine-tuning method parameters to improve the QSM reconstruction

Estimated time
^^^^^^^^^^^^^^

About 15 min.

Data Required
^^^^^^^^^^^^^

- a 4D raw phase data (*phase.nii.gz* in the input directory)
- a 4D raw magnitude data (*mag.nii.gz* in the input directory)
- a 3D raw mask data (*mask.nii.gz* in the input directory)
- a SEPIA header (*Sepia_header.mat* in the input directory)


Performing a full QSM reconstruction  
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


While Sepia allows to do perfrom the three steps of the QSM pocessing seperatily (using the 2nd, 3rd and 4th tab respectively) here for the interest of time we will to it in one go. 

   .. image:: images/FullSepiaConfiguration_IO.PNG
      :align: center

You will see four panels under the **SEPIA** tab: 
- the **I/O** panel is for specifying data input and output 
- the **Total field recovery and phase unwrapping** panel is for selecting phase unwrapping and true phase estimation algorithms
- the **Background Field Removal (BFR)** panel is for selecting the BFR algorithms that will deliver the tissue specific field variations
- the **QSM** panel allows you to choose the QSM algorithms and respective parameters

.. tip:: SEPIA supports two types of data input. If your data follows the SEPIA naming structure, you can select the directory containing all the input data as your input in the first row of **I/O** panel. Alternatively, you can specify the input files separately by following the instruction of the second row of the **I/O** panel. 

Here, for educational purposes, we will explicitely introduce the input data
In the **I/O** panel:

#. Select the **Input Phase**: *~/QuantitativeTutorial/data/phase.nii.gz*
#. Select the **Magnitude**: *~/QuantitativeTutorial/data/mag.nii.gz*
#. Select the **Brain Mask**: *~/QuantitativeTutorial/data/mask.nii.gz*
#. Select the **SEPIA header**: *~/QuantitativeTutorial/data/sepia_header.mat*
#. Change the **Output basename** to: *~/QuantitativeTutorial/outputQSM/Sepia*


For the purpose of this tutorial we will broadly follow the current QSM harmonization settings for both the total field computation and background field removal, but select a more time efficient reconstruction for the last step (QSM).

In the **Total field recovery and phase unwrapping** panel: 

#. Change the **Echo phase combination** method to 'ROMEO total field calculation'
#. Change the **MCPC-3D-S phase offset** method to 'On'
#. Change the **Mask for unwrapping** method to 'SEPIA mask'. 
#. Select **Exclude voxels using Residual** and apply it on 'Brain mask'. 

   .. image:: images/FullSepiaConfiguration_TF.PNG
      :align: center

.. note::  Alternatively, **Optimum weights** and **MEDI nonlinear fit** echo phase combination combined with either **SEGUE** or **ROMEO** phase unwrapping can perform comparably at high SNR.


In the **Background field removal** panel, the 'LBV' method is shown by default. While this would be an acceptable option. In this tutorial we will choose the more robust to noise option **VSHARP**

- 'Erode edge voxel before BFR': 1. 
- 'Max. radius': 12. 
- 'Min. radius': 1. 
- 'Remove Residual': Spherical harmonics of 2nd order. 

   .. image:: images/FullSepiaConfiguration_BFR.PNG
      :align: center

In the **QSM** panel for the sake of a fast solution we will use the **Closed-form solution**

- Change the **lambda** spatial smoothing regularization factor to 0.1
 
   .. image:: images/FullSepiaConfiguration_QSM.PNG
      :align: center

Press on the **start** button. On the command window some text will appear reflecting the progress of your pipeline as well as some of the choices you have made.  
Wait until:  '*Processing pipeline is completed!*'. 

.. tip:: All the output messages of SEPIA will be displayed on the Matlab command window. Make sure you check the command window before clicking the **Start** button again with a new set of parameters you might want to try!

Check the output (should be in *~/QuantitativeTutorial/output/*), in the terminal, once on the desired output directory: 

``fsleyes data/phase.nii.gz output/Sepia_fieldmap.nii.gz -dr -200 200 output/Sepia_localfield.nii.gz -dr -200 200``

You should see the following viewer with three layers and the different images will already have a predefined color display range

   .. image:: images/fsleyes_phase2fields.PNG
      :align: center


The first dataset is the standard phase images (unit in radian). 
You can make the different layers visible by clicking on the eye next to the dataset name at the bottom left of the fsl window. 
If you have selected the phase dataset you can use the volume counter to see the different  echo times
In the second map (already in fequency units, Hz) you have the computed total field which has no phase wraps. 

The second dataset corresponds to the frequency (Hz) map which was computed using the unwrapped phase images at the different echo times using the following :eq:`fpt`:

.. math::
   frequency = \frac{phase}{time}
   :label: fpt

Finally, as you click and unclick the third layer, you will see the that the local field only conserves high-spatial frequnecy features with very low amplitude values 

  i. Adjust the display window to 'Min -10' and 'Max 10' for the localfield and you will see a lot of relevant anatomical information that was hidden bellow the background field 
  
  ii. Set location as [120 112 49]. Can you see a spherical structure emanating a magnetic field? welcome to the red nucleus. 

  iii. Use shortcut ``Crtl+O`` in the FSLeyes to add *mean_head.nii.gz* to the displayed local field maps (in the data directory).

  iv. Check/Uncheck the 'Visibility' button to turn on/off of the mean magnitude image.

     .. image:: images/visibility_button.png

  #. It is known that there is a high concentration of iron deposition in the red nucleus (also in the globus pallidus [144 131 60]). This generates a strong secondary magnetic field that results in an enhancement of the edges of this structures.



The frequency map we obtained from the last exercise contains magnetic fields generated by not only the brain tissue but also the scanner hardware imperfection and fields generated at air/tissue interfaces. Therefore, we have to remove the non-tissue field, or background field, contributions before computing the susceptibility map.

.. toctree::
   :maxdepth: 1

   Theory_backgroundfieldremoval

.. figure:: images/total_field_explain.png
   :align: center
   
   Figure 1: The total field we obtained from the last exercise is the summation of tissue and background magnetic fields. In order to compute the magnetic susceptibility of the brain tissue correctly, the background field contributions have to be removed before mapping the tissue susceptibilities.

You can close all the FSLView window(s) now.

Proceed to :ref:`fmritoolkit2023-exercise4`.

Back to :ref:`fmritoolkit2023-exercise2`.


     