.. _method-bfv-vsharpstisuite2d:
.. _bfv-vsharpstisuite2d:
.. role::  raw-html(raw)
    :format: html

Variable-kernel SHARP, 2D (VSHARP STI Suite 2D)
================================================

.. note::
    New in v1.3.0. This is a slice-wise (2D) variant of :ref:`VSHARP (STI Suite) <method-bfv-vsharpstisuite>`, intended for multi-slice/2D EPI acquisitions where the through-slice field cannot be assumed continuous across the whole volume.

Reference:
`Li, W., Wu, B., Liu, C., 2011. Quantitative susceptibility mapping of human brain reflects spatial variation in tissue composition. Neuroimage 55, 1645–1656. <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_

Algorithm parameters overview
------------------------------

+-----------------+-----------------------------------------------+
| algorParam.bfr. | Description                                   |
+=================+===============================================+
| radius          | Spherical mean value (SMV) kernel size, in mm |
+-----------------+-----------------------------------------------+

Usage
-----

algorParam.bfr.radius
^^^^^^^^^^^^^^^^^^^^^

Spherical mean value (SMV) kernel size, in mm, applied slice-wise (2D) instead of over the full 3D volume.

**Default Value: 12**

Examples:

``algorParam.bfr.radius = 8;``

``algorParam.bfr.radius = 12;``

``algorParam.bfr.radius = 16;``
