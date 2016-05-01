# docker-pymol

Travis CI: [![Build Status](https://travis-ci.org/ocramz/docker-pymol.svg?branch=master)](https://travis-ci.org/ocramz/docker-pymol)

A container-based installation of PyMol.

It comes bundled with iPython and iPyMol, and respective dependencies (NumPy, SciPy..)



## Usage

Get Docker image from the Docker hub:

    docker pull ocramz/docker-pymol

Run image (this also starts a Python interpreter with PyMol loaded without graphical user interface) :

    docker run -it ocramz/docker-pymol




## Credits

Carlos Hernandez (iPyMol) : https://github.com/cxhernandez/ipymol

Dan Connolly (iPython-docker): https://github.com/dckc/ipython-docker