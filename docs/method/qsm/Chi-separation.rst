.. _method-qsm-chi-separation:
.. _qsm-chi-separation:
.. role::  raw-html(raw)
    :format: html

χ-separation (Chi-separation)
==============================

Reference
---------

`Shin, H.G., Lee, J., Yun, Y.H., Yoo, S.H., Jang, J., Oh, S.H., Nam, Y., Jung, S., Kim, S., Fukunaga, M., Kim, W., Choi, H.J., Lee, J., 2021. χ-separation: Magnetic susceptibility source separation toward iron and myelin mapping in the brain. NeuroImage 240, 118371. <https://doi.org/10.1016/j.neuroimage.2021.118371>`_

.. note::
    This add-on wraps several related χ-separation solvers (MEDI- and iLSQR-based variants, as well as the Chi-sepnet deep-learning variants). The SEPIA source code and this add-on's README do not include an in-repo citation for the specific Chi-sepnet network weights/implementation, so only the original χ-separation method paper above is listed here. If you use the Chi-sepnet solvers, please also check the ``README.md`` in the ``addons/qsm/Chi-separation/`` folder and the associated toolbox distribution for any additional citation the authors may request.

Setup Chi-separation for SEPIA
-------------------------------
1. Obtain the ONNX model checkpoint files (e.g. ``240531_R2PRIMEnet.onnx``, ``240904_QSMnet.onnx``, ``240904_xsepnet.onnx``, ``R2PNET_7T.onnx``) and their associated normalisation-factor files (e.g. ``norm_factor.mat``, ``xsepnet_train_patch_norm_factor_inplane_largedegree_romeo_arlo.mat``) and place them in the ``models/`` folder of the Chi-separation toolbox distribution.
2. Open ``setup_Chi_sepnet_environment.m`` in ``SEPIA_HOME/addons/qsm/Chi-separation/`` and update the ``home_directory`` variable to point to the actual location of the Chi-separation toolbox on your system.
3. Install the **Deep Learning Toolbox Converter for ONNX Model Format** support package via MATLAB's Add-On Explorer (search for "Deep Learning Toolbox Converter for ONNX Model Format").

.. warning::
    Loading the ONNX checkpoints requires ``importONNXNetwork``, which depends on the Deep Learning Toolbox Converter for ONNX Model Format support package. Chi-sepnet based solvers (``Chi-sepnet-R2*`` and ``Chi-sepnet-R2'``) will not run without this support package installed.

Algorithm parameters overview
------------------------------

+------------------+--------------------------------------------------------------------------------------------------------------------------+
| algorParam.qsm.  | Description                                                                                                              |
+==================+==========================================================================================================================+
| solver           | Chi-separation algorithm to use. One of: 'Chi-separation-MEDI', 'Chi-separation-iLSQR', 'Chi-sepnet-R2*', or "Chi-       |
|                  | sepnet-R2'"                                                                                                              |
+------------------+--------------------------------------------------------------------------------------------------------------------------+
| Dr               | Susceptibility anisotropy constant used by the selected solver (in ppb). The GUI automatically resets this value when    |
|                  | the solver selection changes (see Usage below)                                                                           |
+------------------+--------------------------------------------------------------------------------------------------------------------------+
| R2s              | Full path to a pre-computed R2* map (NIfTI). If left empty, R2* is estimated internally from the multi-echo magnitude    |
|                  | data using ARLO                                                                                                          |
+------------------+--------------------------------------------------------------------------------------------------------------------------+
| R2               | Full path to a pre-computed R2 map (NIfTI), registered to the R2*/GRE data. Only used by 'Chi-separation-MEDI', 'Chi-    |
|                  | separation-iLSQR' and "Chi-sepnet-R2'"; if left empty, the wrapper falls back to 'Chi-sepnet-R2*' using GRE data only    |
+------------------+--------------------------------------------------------------------------------------------------------------------------+

Usage
-----

algorParam.qsm.solver
^^^^^^^^^^^^^^^^^^^^^^

Chi-separation algorithm to use, selected from a drop-down of four options: ``'Chi-separation-MEDI'``, ``'Chi-separation-iLSQR'``, ``'Chi-sepnet-R2*'``, and ``"Chi-sepnet-R2'"``. Selecting a solver in the GUI automatically toggles the availability of the ``R2star``/``R2`` file inputs and resets the default ``Dr`` value (see below):

* ``'Chi-separation-MEDI'`` and ``'Chi-separation-iLSQR'`` — MEDI-/iLSQR-based conventional χ-separation solvers. Both the ``R2star`` and ``R2`` file inputs are enabled (and expected) so that R2' can be computed, and ``Dr`` defaults to 137.
* ``'Chi-sepnet-R2*'`` — deep-learning (Chi-sepnet) solver that uses only the GRE-derived R2* map. The ``R2star`` input remains enabled but the ``R2`` input is disabled, and ``Dr`` is fixed to 114 (its edit field is disabled).
* ``"Chi-sepnet-R2'"`` — deep-learning (Chi-sepnet) solver that additionally uses a supplied R2' (derived from R2* and R2). Both ``R2star`` and ``R2`` inputs are enabled, and ``Dr`` is fixed to 114 (its edit field is disabled).

**Default Value: 'Chi-separation-MEDI'**

Examples:

``algorParam.qsm.solver = 'Chi-separation-MEDI';``

``algorParam.qsm.solver = 'Chi-separation-iLSQR';``

``algorParam.qsm.solver = 'Chi-sepnet-R2*';``

``algorParam.qsm.solver = 'Chi-sepnet-R2''';``

algorParam.qsm.Dr
^^^^^^^^^^^^^^^^^^

Susceptibility anisotropy constant used by the selected solver (in ppb).

.. note::
    The GUI automatically changes this value and, for the Chi-sepnet solvers, disables the edit field whenever the ``solver`` selection changes: ``Dr`` is set to 137 (editable) for ``'Chi-separation-MEDI'``/``'Chi-separation-iLSQR'``, and to 114 (fixed, not editable) for ``'Chi-sepnet-R2*'``/``"Chi-sepnet-R2'"``.

**Default Value: 137**

Examples:

``algorParam.qsm.Dr = 137;``

``algorParam.qsm.Dr = 114;``

algorParam.qsm.R2s
^^^^^^^^^^^^^^^^^^^

Full path to a pre-computed R2* map (NIfTI file) to be used by the selected solver. This field is enabled for all four solver options. If left empty, R2* is estimated internally from the multi-echo magnitude data using ARLO (MEDI toolbox).

**Default Value: [] (empty; R2* estimated internally)**

Examples:

``algorParam.qsm.R2s = '';``

``algorParam.qsm.R2s = '/path/to/R2star.nii.gz';``

algorParam.qsm.R2
^^^^^^^^^^^^^^^^^^

Full path to a pre-computed R2 map (NIfTI file), registered to the R2*/GRE data, used to derive R2' (= R2* − R2) for the selected solver.

.. note::
    This field is disabled in the GUI when ``'Chi-sepnet-R2*'`` is selected, since that solver only uses the GRE-derived R2* map. If this field is left empty for the other solvers, the wrapper automatically falls back to running ``'Chi-sepnet-R2*'`` using GRE data only.

**Default Value: [] (empty)**

Examples:

``algorParam.qsm.R2 = '';``

``algorParam.qsm.R2 = '/path/to/R2.nii.gz';``

