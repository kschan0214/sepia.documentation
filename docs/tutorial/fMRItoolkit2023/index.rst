.. _fmritoolkit2023-index:

(f)MRI Toolkit 2023
===================

Objectives
----------

- Understanding the data needed for R2* and QSM mapping
- Gaining experience in basic QSM processing and some of the intermediate steps and data

Target Audience
^^^^^^^^^^^^^^^

- who is new to SEPIA
- who wants to learn ao to create a QSM pipeline

Estimated Time
^^^^^^^^^^^^^^

About 1 hour

Introduction  
------------

In this tutorial, we will go through the standard processing pipeline for quantitative susceptibility mapping (QSM), a novel contrast mechanism that can provide local tissue magnetic properties. 

.. toctree::
   :maxdepth: 1

   Theory_qsmphysics

.. figure:: images/qsm_model_flow.png
   :align: center
   
   Figure 1: The QSM theory. A magnetic source generates a secondary magnetic field inside the MRI scanner, which will eventually alter the signal phase we measured. Decoding the phase images allows us to detect the molecular environment of the brain tissues.  

Exercises
---------

Let's begin with the following exercises that will take you from the phase data to the susceptibility maps!

.. toctree::
   :maxdepth: 1
   :name: toc-tutorial-fmritoolkit2023

   Exercise1
   Exercise2
   Exercise3
   Exercise4
   
