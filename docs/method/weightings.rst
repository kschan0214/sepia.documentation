.. _weightings-in-sepia:

Weightings in SEPIA
===================

How does SEPIA compute the weights for dipole field inversion algorithms?
-------------------------------------------------------------------------

SEPIA utilises the inverse of the fieldmap standard deviation map (noisesd.nii.gz) as the weights for potential dipole field inversion algorithms usage. Specifically, The following steps are applied:

Step 1
^^^^^^
Invert the fieldmap standard deviation and remove non-value entries (i.e., NaN & inf become 0)

.. math::
   weights = \frac{1}{fieldmapSD}
   :label: invertsd

Step 2
^^^^^^
Normalisation of the weights. To establish more comparable weights between subjects and between protocols, the weights are first normalised by the value defined as (median + 3IQR). Because of the fast R2* tissues (e.g., globus pallidus), the histogram of the weights is usually negatively skewed. The threshold of (median +3IQR) should capture most of the brain issue <= 1.

.. math::
   weights = \frac{weights}{median(weights(mask) + 3\times IQR(weights(mask))}
   :label: normalise

Step 3
^^^^^^
To avoid the weights estimated from vaious echo combination methods and dataset having significant differences in magnitude overall, the median of the histogram of the weights is re-centred to 1.

.. math::
   weights = weights - median(weights(mask)) + 1
   :label: recentre

And this is the final output of the weights. Since the median after normalisation will be less than 1. Therefore, the minimum value of the weights will not be equal to zero, roughly speaking, most gray matter and white matter could have weight ~1; globus pallidus, red nucleus and substantia nigra ~0.7-0.9; veneous structures ~0.3-0.6.

.. note::
   In future, we would seek for providing more controls on different ways to produce the weighting map.

How does SEPIA compute the weights before v1?
---------------------------------------------

Before v1, SEPIA utilises also the inverse of the field map standard deviation map as the weights, but the normalisation is different and more primitive. 

Step 1
^^^^^^
Invert the fieldmap standard deviation and remove non-value entries (i.e., NaN & inf become 0)

.. math::
   weights = \frac{1}{fieldmapSD}
   :label: invertsd2

Step 2
^^^^^^
Normalisation of the weights. Normalisation is performed by simply using the maximum value in the data so that the range of the weights is between 0 and 1

.. math::
   weights(mask) = \frac{weights(mask)}{max(weights(mask))}
   :label: max

The potential issue with this approach is the maximum value relying on a single voxel so it could be subject to outliers and variations between dataset (e.g., different subjects or acquisition protocol can produce different maximum). As a results, there could be a global differences in terms of the magnitude of the weights between different datasets. If a dipole field inversion algorithm takes the weights for the processing, without further normalisation by the algorithms, the differences of the overall weights magnitude could impose additional regularisation differences between datasets (e.g., among subjects of the same study) even the same regularisation parameter is used across the entire study. 

.. warning::
    The medians of the weights of these two versions are in different range (before v1: less than 1 and around 0.3-0.4; v1: close to 1), meaning it may require adjusting the regularisation parameter to match regularisation effect between the two versions. Therefore, it is not recommended to mix software versions in a single study.

