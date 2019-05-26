.. SEPIA documentation master file, created by
   sphinx-quickstart on Sat May 25 22:48:00 2019.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

SEPIA Documentation
===================

Welcome to the SEPIA documentation! Here you can find all the documents related to SEPIA.

**SEPIA** provides a graphical user interface in Matlab to build data processing pipelines related to quantitative susceptibility mapping (QSM).

**SEPIA** is designed to solve two issues I encountered during my research in QSM:  

1. Using algorithms from toolboxes developed by different research groups,
2. Having a platform such that I can quickly adjust (and remember) parameters of each algorithm.  

The purpose of SEPIA is to provide a platform for easy access to different QSM processing methods in the field. It provides interfaces to use the following three toolboxes freely available online for academic purposes, i.e.  

1. `MEDI toolbox <http://pre.weill.cornell.edu/mri/pages/qsm.html>`_  
2. `STI Suite <https://people.eecs.berkeley.edu/%7Echunlei.liu/software.html>`_  
3. `FANSI toolbox <https://gitlab.com/cmilovic/FANSI-toolbox>`_  

Through SEPIA I hope researchers who are not coming from the field could also be able to use QSM for their research. For those more experienced researchers, I also hope this tool can simplify your workflow.

Table of Contents
=================

.. toctree::
   :maxdepth: 1
   :caption: Getting started
   :name: sec-getstart

   getting_started/Installation
   getting_started/Data-preparation
   getting_started/Sepia-header

.. toctree::
   :maxdepth: 1
   :caption: Graphical User Interface (GUI)
   :name: sec-gui

   gui/Sepia-One-stop-QSM-processing
   gui/Phase-unwrapping-standalone
   gui/Background-field-removal-standalone
   gui/QSM-standalone

.. toctree::
   :maxdepth: 1
   :caption: Demonstration
   :name: sec-demo

   demo/Choosing-a-right-phase-unwrapping-method-for-your-data

.. toctree::
   :maxdepth: 1
   :caption: Tutorial
   :name: sec-tutorial

   tutorial/fMRItoolkits2019/index

.. toctree::
   :maxdepth: 1
   :caption: Acknowledgements and References
   :name: sec-acknowledge

   pages/Acknowledgements
   pages/References



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
