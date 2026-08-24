.. _method-r2s-nlls:
.. role::  raw-html(raw)
    :format: html

Non-linear least square
=======================

Mono expoential R2* mapping with a non-linear least square solver.

.. image:: ../images/r2s/nlls.png

Algorithm parameters overview
-----------------------------

+-----------------+-------------------------------------------------------------------------+
| algorParam.r2s. | Description                                                             |
+=================+=========================================================================+
| isParallel      | Enable parallel computing (parfor) to accelerate the voxel-wise fitting |
+-----------------+-------------------------------------------------------------------------+

Usage
-----

algorParam.r2s.isParallel
^^^^^^^^^^^^^^^^^^^^^^^^^

Enable parallel computing (parfor) to accelerate the voxel-wise fitting

**Default Value: false**

Examples:

``algorParam.r2s.isParallel = false;``

``algorParam.r2s.isParallel = true;``
