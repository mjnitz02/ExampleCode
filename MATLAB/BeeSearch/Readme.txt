BeeSearch Readme
-----------------
Version: 1.0
Author: Matt Nitzken
Contact: mjnitz02@gmail.com
-----------------

Requirements:
**This program is tested on MATLAB 2009b and later
- A machine capable of running matlab
- A valid copy of MATLAB 2009b or newer
  (this is required because this code uses object-oriented programming
   which was first introduced to MATLAB in MATLAB 2009a).
- At least 1gb of free ram (recommended: 2gb or more)


Instructions:
1) Open MATLAB
2) Navigate to the BeeSearch source code folder
3) On the command line type "beesearch" without quotes
4) The program is primarily run through the gui which should immediately load


Running BeeSearch:
- The program accepts FASTA input.  Samples of inputs and outputs are included.
- Bee parameters and specifications are discussed in detail in the paper.
- Worker stability is the number of workers to use for the local stability (described in paper).  Global stability is the global stability.
- Emergency kill tells the algorithm to reseed the worker population if more than X workers become identical.  Setting this to a value of 0 will disable the emergency kill.  It is recommended to use a value that is 50% of the Worker Stability.  The occurence of instability is rare (especially on large data sets) and it is likely this parameter will not be used.
- BeeSearch will save the top 3 motifs that it finds to files.  This output is similar to how MEME displays the top 3 motifs.