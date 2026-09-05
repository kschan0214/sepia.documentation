.. _method-qsm-two-pass-masking:
.. _qsm-two-pass-masking:
.. role::  raw-html(raw)
    :format: html

Two-pass Masking
=================

.. note::
    New in v1.3.0.

Why refine the mask before dipole inversion?
---------------------------------------------

The signal (brain) mask used for QSM is usually generated from the magnitude data (e.g. by a skull-stripping tool such as BET or SynthStrip) and therefore only reflects where there is *signal*, not where the phase (and hence the estimated local field) is *reliable*. Voxels near the edge of the brain, close to air/tissue interfaces, or in regions with strong susceptibility gradients often have signal but an unreliable phase, and including them in the dipole inversion tends to propagate errors as streaking artefacts into the rest of the QSM map.

Two-pass masking addresses this by running a **second masking pass** before the final QSM dipole inversion:

1. **Pass 1** — the QSM dipole inversion method selected in the QSM panel is run once using the original (signal) mask to obtain intermediate results needed by the refinement strategy (e.g. a local field map).
2. **Mask refinement** — the map required by the selected refinement strategy is analysed, and unreliable voxels are excluded from the original mask to create a refined ("reliable") mask.
3. **Pass 2** — the same QSM dipole inversion method is run a second time, this time using the refined mask, to produce the final QSM map.

Available refinement strategies
--------------------------------

The refinement strategy is chosen from the '2-pass masking' dropdown in the :ref:`QSM standalone <QSM-standalone>` (or the corresponding tab of the one-stop pipeline). The available options are:

+--------------------------------+----------------------------------------------------+----------------------------------------------+
| GUI option                     | Data required                                       | ``algorParam.qsm.isTwoPass``                 |
+=================================+======================================================+================================================+
| None                           | —                                                    | ``'None'``                                    |
+--------------------------------+----------------------------------------------------+----------------------------------------------+
| Monoexponential decay model    | Multi-echo magnitude, phase and local field map     | ``'Monoexponential decay model'``             |
+--------------------------------+----------------------------------------------------+----------------------------------------------+
| Magnitude Gradient Field       | Local field map                                     | ``'Magnitude Gradient Field'``                |
+--------------------------------+----------------------------------------------------+----------------------------------------------+
| Noise map                      | Field map noise/standard-deviation map (or weights) | ``'Noise map'``                               |
+--------------------------------+----------------------------------------------------+----------------------------------------------+

.. note::
    If the data required by the selected strategy is not available, a warning is raised and the original mask is kept unchanged (i.e. the pipeline effectively falls back to a single QSM pass).

Monoexponential decay model
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This strategy fits a monoexponential (R2\*) decay model to the multi-echo magnitude data using the current local field map, then simulates the complex signal that model predicts at every echo. Voxels where the simulated signal disagrees strongly with the measured signal are considered unreliable — this typically happens where the local field map itself is inaccurate.

For every voxel, a relative residual between the measured and the simulated multi-echo complex signal is computed:

.. math::
    \text{residual} = \frac{\sum_{t} \left| \hat{s}_t - s_t \right|^2}{\sum_{t} \left| s_t \right|^2}

where :math:`s_t` is the measured complex signal at echo :math:`t` and :math:`\hat{s}_t` is the signal predicted from the fitted R2\* map and the local field map. Voxels are kept only if their residual is below the threshold *λ*:

``mask_refined = (relativeResidual < λ) & mask``

.. note::
    An R2\* map is computed automatically from the multi-echo magnitude data if one is not already available (it is reused if a previous processing step in the pipeline already generated one).

Magnitude Gradient Field
^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note::
    Please cite `<https://archive.ismrm.org/2024/3674.html>`_ if you use this masking strategy.

This strategy looks at the spatial gradient of the local field map. Large gradients typically occur near air/tissue interfaces and other regions where the local field is poorly conditioned, so voxels with an unusually large gradient magnitude are excluded from the mask.

The gradient magnitude of the local field map is computed as :math:`G = \sqrt{G_x^2+G_y^2+G_z^2}`, and its mean :math:`\mu_G` and standard deviation :math:`\sigma_G` across the mask are used to define a threshold:

``threshold = mean(G) + λ * std(G)``

Voxels with a gradient magnitude above this threshold are removed from the mask.

.. note::
    This is currently the only strategy for which the *λ* field/slider is enabled in the GUI; for the other strategies *λ* is fixed at its default value.

Noise map
^^^^^^^^^^

This strategy uses the standard deviation (noise) map of the local field, or the field-map fitting weights when no noise map is provided (in which case the noise map is estimated as the reciprocal of the weights), to erode the mask. The mean of the inverse noise map (i.e. an inverse-noise-based reliability measure), computed only over non-zero voxels, is used as the threshold — voxels whose reliability is below the mean are excluded:

``mask_refined = (1./noiseMap >= mean(1./noiseMap)) & mask``

.. note::
    This strategy does not use the *λ* threshold; the threshold is derived automatically from the noise map.

Legacy R2\*-based refinement
------------------------------

An older, single-purpose R2\*-based mask refinement (``algorParam.msk.refineMethod = 'r2s-refine'``) is still used internally by some pipelines (e.g. phase unwrapping) but is not exposed as one of the '2-pass masking' options in the QSM panel described above.

GUI parameters
----------------

algorParam.qsm.isTwoPass
^^^^^^^^^^^^^^^^^^^^^^^^^^

Selects the mask refinement strategy for the second masking pass.

**Default Value: 'None'**

Examples:

``algorParam.qsm.isTwoPass = 'None';``

``algorParam.qsm.isTwoPass = 'Monoexponential decay model';``

``algorParam.qsm.isTwoPass = 'Magnitude Gradient Field';``

``algorParam.qsm.isTwoPass = 'Noise map';``

algorParam.qsm.twopass_lambda
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Thresholding value (*λ*) used by the selected refinement strategy. Only used by the 'Magnitude Gradient Field' strategy; ignored otherwise.

**Default Value: 0.7**

Examples:

``algorParam.qsm.twopass_lambda = 0.7;``
