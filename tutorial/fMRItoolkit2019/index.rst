(f)MRI Toolkit 2019
===================

Objectives
----------

- Understanding the background of magnetic susceptibility contrast
- Gaining experience on basic QSM processing

Target Audience
^^^^^^^^^^^^^^^

- who is new to SEPIA
- who wants to know some basic knowledge about QSM

Estimated Time
^^^^^^^^^^^^^^

Less than 1 hour

Introduction  
------------

In this tutorial we will go through the standard processing pipeline for quantitative susceptibility mapping (QSM), a novel contrast mechanism that can provide local tissue magnetic properties. 

.. toctree::
   :maxdepth: 1

   Theory_qsmphysics

.. figure:: images/qsm_model_flow.png
   :align: center
   
   Figure 1: The QSM theory. A magnetic source generates a secondary magnetic field inside the MRI scanner, which will eventually alter the signal phase we measured. Decoding the phase images allows us to detect the molecular environment of the brain tissues.  

Let's begin with the following exercises that will take you from the phase data to the susceptibility maps!

.. toctree::
   :maxdepth: 1
   :name: toc-tutorial-fmritoolkit2019

   Exercise1
   Exercise2
   Exercise3
   Exercise4
   