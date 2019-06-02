.. _fmritoolkit2019-exercise4-answer-1:

Answer: Exercise 4.1  
====================

The result should look like the image below. We followed exactly the operation described in the dipole inversion equation, but what's wrong?

.. image:: images/qsm_tkd-0.png

To understand the problem, let's have a look at the denominator of the dipole inversion equation, which is the Fourier transform of the dipole field (so-called dipole kernel).

.. math::
   \chi = F^{-1}[\frac{F(Tissue field)}{F(d)}]

.. math::
   Dipole kernel, D = F(d)

Here is the image representation of the magnitude of the dipole kernel :math:`|D|`

.. figure:: images/dipole_kernel.png
   :align: center

   Figure 1: The magnitude of the Fourier transform of the dipole field.

The dashed lines outlines the regions where the values in the dipole kernel are equal or very close to zero (which can be represented as a cone surface). This leads to the ill-defined division of zero problem! After dividing the two images, these regions will contain either undefined value (when values in dipole kernel equal to zeros) or unrealistic numbers (when values close to zeros), making the QSM map unusable:

.. figure:: images/qsm_fourier_tkd-0.png
   :align: center

Figure 2: Fourier transform of the QSM map (i.e. in k-space). It is clear that the values on/near the cone surface in k-space are amplified. 


Back to :ref:`fmritoolkit2019-exercise4`.
