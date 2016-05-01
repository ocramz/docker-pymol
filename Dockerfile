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
RUN apt-get install -y sudo wget curl make python python-pip pkg-config


# # # install PyMol (and iPython) dependencies
RUN apt-get install -y freeglut3 freeglut3-dev libpng3 libpng-dev libfreetype6 libfreetype6-dev pmw python-dev glew-utils libglew-dev libxml2-dev    gfortran libzmq1 libzmq-dev libc-dev


# # # # iPython + iPyMol + dependencies
RUN pip install pyzmq ipython jinja2 tornado numpy   ipymol matplotlib freetype-py

# RUN apt-get remove -y --purge libzmq-dev python-dev libc-dev; \
#      apt-get remove -y --purge gcc cpp binutils; \
#      apt-get autoremove -y; \
#      apt-get clean -y




# # # # # Python virtualenv
# # RUN pip install virtualenv
# # RUN pip install virtualenvwrapper
# # # RUN source /usr/local/share/python/virtualenvwrapper.sh
# # # RUN mkvirtualenv venv







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



# # # set working dir 
# WORKDIR /home


# # # start Python in interactive mode and load PyMol without a GUI
# ENTRYPOINT ["python", "-ic", "execfile('pymol_scripts/pymol_init.py')"]






# # # # iPyMol : control PyMol via Jupyter/iPython

# # # example usage of iPyMol
# # from ipymol import viewer as pymol
# # pymol.start()   # Start PyMOL RPC server
# # pymol.do('fetch 3odu; as cartoon; bg white')
# # pymol.show()






# # # iPython

# VOLUME /notebooks
# WORKDIR /notebooks

# # for converting notebooks...
# RUN pip install pygments
# RUN apt-get install -y pandoc



# EXPOSE 8888
# CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888

# # # Usage:
# # sudo docker run -p 8123:8888 -v `/bin/pwd`:/notebooks  -t ipython-notebook
