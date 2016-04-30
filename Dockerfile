FROM ubuntu:14.04

# # ocramz/docker-pymol

MAINTAINER Marco Zocca, zocca.marco gmail 

RUN apt-get update 


# PyMol dependencies : OpenGL, glut, libpng, tcl/tk, python, freetype2, and Pmw

RUN apt-get install -y sudo wget make python

RUN apt-get install -y  freeglut3 freeglut3-dev libpng freetype2 pmw

