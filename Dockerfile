#################################################################
# Dockerfile
#
# Version:          1
# Software:         PyMol
# Software Version: 1.8.2.0
# Description:      protein visualization
# Website:          
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


# # # bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh


# # # install some build tools
RUN apt-get install -y sudo wget curl make python python-pip gfortran


# # # Python virtualenv
RUN pip install virtualenv
RUN pip install virtualenvwrapper
# RUN source /usr/local/share/python/virtualenvwrapper.sh
# RUN mkvirtualenv venv



# # # install PyMol dependencies
RUN apt-get install -y freeglut3 freeglut3-dev libpng3 libpng-dev libfreetype6 libfreetype6-dev pmw python-dev glew-utils libglew-dev libxml2-dev 





# # # clean temp data
RUN apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



ENV SCRIPTS_DIR /home/pymol_scripts
ENV DATASETS_DIR /home/datasets

# # useful directories

RUN mkdir -p ${SCRIPTS_DIR}
RUN mkdir -p ${DATASETS_DIR}



# # PyMol scripts

ADD scripts/ ${SCRIPTS_DIR}
ADD datasets/ ${DATASETS_DIR}




# # # fetch and install PyMOl

RUN wget --no-verbose https://sourceforge.net/projects/pymol/files/pymol/1.8/pymol-v${PYMOL_VERSION}.tar.bz2
RUN tar jxf pymol-v${PYMOL_VERSION}.tar.bz2

RUN rm pymol-v*

WORKDIR pymol

RUN python setup.py build install




# # # # iPyMol : control PyMol via Jupyter/iPython

RUN pip install ipython freetype-py matplotlib
# RUN pip install ipymol

# # # example usage of iPyMol
# # from ipymol import viewer as pymol
# # pymol.start()   # Start PyMOL RPC server
# # pymol.do('fetch 3odu; as cartoon; bg white')
# # pymol.show()






# # set working dir 

WORKDIR /home



# # start Python in interactive mode and load PyMol without a GUI

# ENTRYPOINT ["python", "-ic", "execfile('pymol_scripts/pymol_init.py')"]