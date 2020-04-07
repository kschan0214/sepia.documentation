.. _integration_method_part2-index:

Integration of New BFR/QSM Method in SEPIA: Part 2
=======================================================================

Objectives
----------

- Learn how to add a new method to SEPIA GUI

Target Audience
^^^^^^^^^^^^^^^

- who has completed Part 1 of the tutorial
- researchers who want to add their method(s) to SEPIA framework 

Estimated Time
^^^^^^^^^^^^^^

About 1 hour

Introduction  
------------

In this tutorial, we will practice how to add a new method to the SEPIA GUI. you should complete the tutorial Part 1 before proceeding to this tutorial.

GUI is a major component of SEPIA. It provides the most straightfoward way to access all avaiable resources of QSM processing in SEPIA framework. The main goal of the GUI is to generate a pipeline configuration file containing all the processing tasks, methods and algorithm parameters specified by the users and used to trigger the QSM processing. The configuration file can also be executed without initializing the GUI since it directly accesses the processing back end. 

The full QSM processing pipeline in SEPIA can be summarised into 4 task panels, including:

1. Data input/output panel 
2. Total field recovery and phase unwrapping panel
3. Background field removal panel
4. QSM panel

For each processing task, there are multiple methods available to perform the task. Generally, each method has it own method panel in the GUI to obtain information from the users.

.. figure:: images/figure01_method_panel.png
   :align: center
  
The method panel will be switched from one to another based on the current selected method in the task panel. 

There are two main objectives we need to accomplish in this tutorial:

1. design a method panel that can obtain information from the user, and
2. export and import the information to/from a pipelin configuration file.


Exercise
--------

To begin with, let's go to the ``/SEPIA_HOME/tutorial/myQSMmethod/``. You should see there are four Matlab scripts in the folder:

.. figure:: images/figure02_files.png
   :align: center
   
In Part 1, we demonstrated how to connect ``myQSM.m`` to the SEPIA processing back end using ``Wrapper_QSM_myQSM.m`` as a connector. In this tutorial, we will use the remaining two files: ``sepia_handle_panel_qsm_myQSM.m`` and ``get_set_qsm_myQSM.m``


``sepia_handle_panel_qsm_myQSM.m``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Each method in SEPIA GUI has it own panel to obtain information from users. This information can be a value (e.g. tolerance), a decision (e.g. true/false), a selection (given choices) and many others. We will go through the script to understand how a panel can be designed in SEPIA GUI.

.. figure:: images/figure03_panel_script.png
   :align: center
   
**Anatomy of sepia_handle_panel_qsm_myQSM.m**

.. code-block:: matlab

	function h = sepia_handle_panel_qsm_myQSM(hParent,h,position)

For every new panel you can decide a new name of the function. However, the input and output variables are fixed and should not be changed.

.. code-block:: matlab

   %% set default values
   defaultThreshold = 0.15;

We first decide the default input value that will be showed in the GUI.

.. code-block:: matlab

   %% Tooltips
   tooltip.qsm.myQSM.threshold	= 'K-space threshold';

You can also add tooltips to further explain the information the method required.

.. code-block:: matlab

   %% layout of the panel
   nrow        = 4;
   rspacing    = 0.01;
   ncol        = 2;
   cspacing    = 0.01;
   [height,bottom,width,left] = sepia_layout_measurement(nrow,rspacing,ncol,cspacing);

In principle develops can design the layout of the method panel with their own style. In SEPIA, the ``sepia_layout_measurement`` function can help standardise the panel layout by creating a evenly distributed grid. It requires the following input:

- *nrow*: number of rows in the grid
- *rspacing*: spacing between consecutive rows, in normalised unit
- *ncol*: number of columns in the grid
- *cspacing*: spacing between consecutive columns, in normalised unit

It returns four variables that specify the position of each cell in the grid:

- *height*: height of the cell, in normalised unit
- *bottom*: 1-by-*nrow* array indicating the bottom position of the cell, starting from the top of the panel
- *width*: width of the cell, in normalised unit
- *left*: 1-by-*ncol* array indicating the left position of the cell, starting from the left

.. figure:: images/figure04_grid.png
   :align: center

.. code-block:: matlab

   h.qsm.panel.myQSM = uipanel(hParent,...
      'Title','My QSM dipole inversion',...
      'position',position,...
      'backgroundcolor',get(h.fig,'color'),'Visible','on');

Firstly, we create a panel in Matlab. This panel belongs to the QSM task panel which is specified in the *hParent* input. You can only change the '*Title*' value here. 

.. code-block:: matlab

   panelParent = h.qsm.panel.myQSM;

    % width of each element in a functional column, in normalised unit
    wratio = 0.5;
    
    % row 1, col 1
    % text|edit field pair: threshold
    [h.qsm.myQSM.text.threshold,h.qsm.myQSM.edit.threshold] = sepia_construct_text_edit(...
        panelParent,'Threshold (0-1):', defaultThreshold, [left(1) bottom(1) width height], wratio);

Secondly, we can start adding things to the method panel. 

