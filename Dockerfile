FROM ubuntu:14.04

# # ocramz/docker-pymol

MAINTAINER Marco Zocca, zocca.marco gmail 


ENV PYMOL_VERSION 1.8.2.0

RUN apt-get update 


# PyMol dependencies : OpenGL, glut, libpng, tcl/tk, python, freetype2, and Pmw

RUN apt-get install -y sudo wget curl make python python-pip

RUN apt-get install -y  freeglut3 freeglut3-dev libpng3 libfreetype6 pmw


RUN wget --no-verbose https://sourceforge.net/projects/pymol/files/pymol/1.8/pymol-v${PYMOL_VERSION}.tar.bz2
RUN tar jxf pymol-v${PYMOL_VERSION}.tar.bz2

RUN ls

WORKDIR pymol

RUN python setup.py build install