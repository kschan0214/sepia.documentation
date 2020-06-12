Background Magnetic Field Removal Algorithms
============================================

Background field removal in QSM
-------------------------------

The phase we measured in a GRE acquisition is affected by not only the brain tissue but also sources like B0 inhomogeneity and air sinus. In order to compute the susceptibility sources only contributed by the brain tissue, it is important to remove all the non-local field effect. Fortunately, the characteristic of the local field is different from that of the non-local field, it is possible to separate the two fields from the unwrapped total field. This standalone application is designed to solve the field separation problem.

**Caution**: It is crucial that the background field contribution is removed accurately in this stage. Otherwise, the remaining field due to background sources will be treated as part of the local field, degrading the quality of QSM result.

Supported algorithms in SEPIA
-----------------------------

1. `LBV <https://doi.org/10.1002/nbm.3064>`_  

    Laplacian boundary value approach to removal background field  

2. `PDF <https://doi.org/10.1002/nbm.1670>`_  

    Projection onto dipole field  

3. `RESHARP <https://doi.org/10.1002/mrm.24765>`_  

    regularisation enabled SHARP  

4. `SHARP <https://doi.org/10.1016/j.neuroimage.2010.10.070>`_  

    Sophisticated harmonic artefact reduction for phase data  

5. `VSHARP (STI suite) <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_   

    STI suite v3.0 variable-kernel SHARP 

6. `VSHARP <https://doi.org/10.1016/j.neuroimage.2010.11.088>`_  

7. `iHARPERELLA <https://doi.org/10.1002/nbm.3056>`_   

