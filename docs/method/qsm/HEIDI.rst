.. _method-qsm-heidi:
.. _qsm-heidi:
.. role::  raw-html(raw)
    :format: html

Homogeneity Enabled Incremental Dipole Inversion (HEIDI)
=========================================================

Reference
---------

Schweser F, Deistung A, Sommer K, Reichenbach JR. HEIDI: a new algorithm for MR phase to susceptibility conversion. Proc Intl Soc Mag Reson Med 2010; 18:4646 (conference abstract).

Setup HEIDI for SEPIA
----------------------
1. Obtain the ``HEIDI_SEPIAready`` package and place it at ``SEPIA_HOME/../external/HEIDI_SEPIAready`` (i.e. in an ``external`` folder that sits alongside, not inside, the SEPIA installation directory). This path is currently hard-coded in ``Wrapper_QSM_LSQRandHEIDI.m`` and cannot be changed from the GUI or a config file.
2. The package is expected to contain, at minimum, a ``LSQR`` subfolder and a ``HEIDI`` subfolder (i.e. ``HEIDI_SEPIAready/LSQR`` and ``HEIDI_SEPIAready/HEIDI``), the latter of which should contain the ``GradientAnisotropicDiffusionImageFilter`` executable used internally by the method.
3. No further configuration is required. The first time it is run, the wrapper automatically checks whether ``GradientAnisotropicDiffusionImageFilter`` has execute permission and, if not, grants it (``chmod a+x``) before continuing.

.. warning::
    This add-on currently supports Linux systems only. The wrapper explicitly checks the platform (``~isunix || ismac``) and raises an error on macOS and Windows.

Algorithm parameters overview
------------------------------

HEIDI is provided in SEPIA as a two-stage "LSQR+HEIDI" pipeline: an LSQR pre-processing step produces an initial susceptibility estimate, which is then refined by the HEIDI dipole-inversion step. Several parameters exposed in the underlying HEIDI package (Tikhonov regularisation, solver type, dipole filter, and residual weighting) are currently disabled in the SEPIA GUI — their popups only offer a single ``Default`` option and their edit fields cannot be modified — as they need further testing before being exposed as user-tunable options. They are still passed through to the algorithm as reserved/fixed-default fields in ``algorParam.qsm``.

+----------------------------------------------+----------------------------------------------------------------------------------------------+
| algorParam.qsm.                              | Description                                                                                  |
+==============================================+==============================================================================================+
| heidi_tolerance                              | Convergence limit for the LSQR pre-processing step                                           |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_maxiter                                | Maximum iterations allowed for the LSQR pre-processing step                                  |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_offsetUseBool                          | Automatic offset determination (checkbox is currently disabled in the GUI; value is fixed at |
|                                              | its default)                                                                                 |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_isFourierDomainFormula                 | If true, constructs the dipole kernel in the Fourier domain; if false, constructs it in the  |
|                                              | spatial domain                                                                               |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_TikhonovRegularizationSusceptibility   | Tikhonov regularisation of the susceptibility solution. Reserved for future functionality;   |
|                                              | the GUI popup currently exposes only the 'Default' option and is disabled                    |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_solvingType                            | HEIDI solver type. Reserved for future functionality; the GUI popup currently exposes only   |
|                                              | the 'Default' option and is disabled                                                         |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_DipoleFilter                           | Dipole filter applied during HEIDI dipole inversion. Reserved for future functionality; the  |
|                                              | GUI popup currently exposes only the 'Default' option and is disabled                        |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_residualWeighting                      | Residual weighting used by the LSQR pre-processing step, scaled internally by the field      |
|                                              | strength (i.e. value*B0). The GUI edit field is currently disabled, so this value is fixed   |
|                                              | at its scaled default                                                                        |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_PostProcCone_threshold                 | Threshold to define the ill-posed cone in k-space (magnitude of dipole below this threshold) |
|                                              | used for cone post-processing                                                                |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_PostProcCone_tol                       | Convergence tolerance for cone post-processing (e.g. TV minimisation)                        |
+----------------------------------------------+----------------------------------------------------------------------------------------------+
| heidi_PostProcCone_tolEnergy                 | Energy-based convergence tolerance for cone post-processing                                  |
+----------------------------------------------+----------------------------------------------------------------------------------------------+

Usage
-----

algorParam.qsm.heidi_tolerance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Convergence limit for the LSQR pre-processing step

**Default Value: 0.00001**

Examples:

``algorParam.qsm.heidi_tolerance = 0.0001;``

``algorParam.qsm.heidi_tolerance = 0.00001;``

algorParam.qsm.heidi_maxiter
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Maximum iterations allowed for the LSQR pre-processing step

**Default Value: 400**

Examples:

``algorParam.qsm.heidi_maxiter = 200;``

``algorParam.qsm.heidi_maxiter = 400;``

algorParam.qsm.heidi_offsetUseBool
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Automatic offset determination.

.. note::
    The corresponding GUI checkbox is currently disabled, so this value cannot be changed from the GUI and is fixed at its default.

**Default Value: true**

Examples:

``algorParam.qsm.heidi_offsetUseBool = true;``

algorParam.qsm.heidi_isFourierDomainFormula
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If true, constructs the dipole kernel in the Fourier domain. If false, constructs the dipole kernel in the spatial domain.

**Default Value: false**

Examples:

``algorParam.qsm.heidi_isFourierDomainFormula = false;``

``algorParam.qsm.heidi_isFourierDomainFormula = true;``

algorParam.qsm.heidi_TikhonovRegularizationSusceptibility
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Performing dipole inversion with Tikhonov regularisation.

.. note::
    This is reserved for future functionality. The GUI popup currently exposes only the ``Default`` option and is disabled; internally this is passed through as an empty value (equivalent to the package's own default behaviour).

**Default Value: [] (i.e. 'Default')**

algorParam.qsm.heidi_solvingType
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

HEIDI solver type.

.. note::
    This is reserved for future functionality. The GUI popup currently exposes only the ``Default`` option and is disabled; internally this is passed through as an empty value (equivalent to the package's own default behaviour).

**Default Value: [] (i.e. 'Default')**

algorParam.qsm.heidi_DipoleFilter
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Dipole filter applied during HEIDI dipole inversion.

.. note::
    This is reserved for future functionality. The GUI popup currently exposes only the ``Default`` option and is disabled; internally this is passed through as an empty value (equivalent to the package's own default behaviour).

**Default Value: [] (i.e. 'Default')**

algorParam.qsm.heidi_residualWeighting
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Residual weighting used by the LSQR pre-processing step. This value is scaled internally by the field strength, i.e. ``residualWeighting * B0``.

.. note::
    The corresponding GUI edit field is currently disabled, so this value cannot be changed from the GUI and is fixed at its (field-strength-scaled) default.

**Default Value: 0.2 / 9.4 (scaled by B0 at run time)**

algorParam.qsm.heidi_PostProcCone_threshold
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Threshold to define the ill-posed "cone" in k-space (magnitude of the dipole kernel below this threshold) used for cone post-processing.

**Default Value: 0.14**

Examples:

``algorParam.qsm.heidi_PostProcCone_threshold = 0.1;``

``algorParam.qsm.heidi_PostProcCone_threshold = 0.14;``

algorParam.qsm.heidi_PostProcCone_tol
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Convergence tolerance for cone post-processing (e.g. TV minimisation).

**Default Value: 0.00001**

Examples:

``algorParam.qsm.heidi_PostProcCone_tol = 0.00001;``

algorParam.qsm.heidi_PostProcCone_tolEnergy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Energy-based convergence tolerance for cone post-processing.

**Default Value: 0.00001**

Examples:

``algorParam.qsm.heidi_PostProcCone_tolEnergy = 0.00001;``

