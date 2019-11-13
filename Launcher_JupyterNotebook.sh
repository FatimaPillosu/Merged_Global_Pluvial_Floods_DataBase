################################################
# START JUPYTER NOTEBOOK USING A MATLAB KERNEL #
################################################


# PREREQUISITES
#   1. Matlab 
#   2. Anaconda
# Note: this tutorial has been successfully tested for Matlab R2019b. Finally, check that the installed version of Anaconda supports Python 2.7, 3.6, or 3.7 as Matlab R2019b interfaces only with such Python versions.

# INPUTS
MatlabRoot_Dir="$1"
JupyterNotebook_Dir=$(pwd)


# ---------------------------------- #
# Python-side Notebook Configuration #
# ---------------------------------- #

# Create a Conda virtual environment to interface Matlab with Python
conda create -vv -n jmatlab python=3.7 jupyter
conda activate jmatlab

# Install the Matlab Kernel for Jupyter Notebooks
pip install --upgrade pip
pip install matlab_kernel
python -m matlab_kernel install --user


# ---------------------------------- #
# Matlab-side Notebook Configuration #
# ---------------------------------- #

# Install the Matlab Engine API for Python
cd $MatlabRoot_Dir/extern/engines/python/
python setup.py install

echo " "
echo "*** SUCCESSFULL SETUP OF MATLAB IN JUPYTER NOTEBOOKS ***"

# ----------------------------- #
# Start Sample Jupyter Notebook #
# ----------------------------- #

# Initialize a Jupyter Notebook
echo " "
echo "*** INITIALIZATION OF A JUPYTER NOTEBOOK USING MATLAB ***"
echo " "
echo "When JypiterLab will be opened:"
echo " 1. Initialize a new Jupyter notebook with a Matlab kernel by clicking in 'New' and selecting 'Matlab' from the list."
echo " 2. From a Python environment, import the 'Matlab Engine' module, and start the MATLAB engine by typing in the first cell of the notebook:"
echo "      %%python"
echo "      import matlab.engine"
echo "      eng = matlab.engine.start_matlab()"
echo "and running the notebook cell."
echo " "
echo "Now it is possible to test whether the Jupiter notebook is running correctly the Matlab kernel by typing:"
echo "disp('Hello World')"
echo "and running the notebook cell (wait few seconds)."
echo " "
echo "If the command works, it is possible to start using Matlab in the Jupyter Notebook."

cd $JupyterNotebook_Dir
jupyter notebook Merged_Global_FlashFlood_DB.ipynb
