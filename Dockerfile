#################################################################
# Dockerfile
#
# Version:          1
# Software:         PyMol
# Software Version: 1.8.2.0
# Description:      protein visualization
# Website:          http://www.bcgsc.ca/platform/bioinfo/software/abyss/releases/1.9.0
# Tags:             Visualization
# Provides:         PyMol 1.8.2.0
# Base Image:       ubuntu 14.04
# Build Cmd:        
# Pull Cmd:         
# Run Cmd:          
#################################################################
FROM ubuntu:14.04



MAINTAINER Marco Zocca, zocca.marco gmail 


ENV PYMOL_VERSION 1.8.2.0

RUN apt-get update 


# # # install some build tools

RUN apt-get install -y sudo wget curl make python python-pip




# # # install PyMol dependencies

RUN apt-get install -y freeglut3 freeglut3-dev libpng3 libfreetype6 pmw python-dev glew libglew1.13 libglew-dev





# # # clean temp data

RUN apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



# # # fetch and install PyMOl

RUN wget --no-verbose https://sourceforge.net/projects/pymol/files/pymol/1.8/pymol-v${PYMOL_VERSION}.tar.bz2
RUN tar jxf pymol-v${PYMOL_VERSION}.tar.bz2

WORKDIR pymol

RUN python setup.py build install