# The PulseDB Dataset

The script, **Generate_Subsets.m**, is provided to generate **Subset** files, which are the training and testing subsets of the PulseDB Dataset. **Subset** files are generated from the **Segment** and **Info** files stored in the folder **Segment_Files** and **Info_Files**, whose contents have to be downloaded separately from online drive services.

The generated **Subset** files are stored in the folder **Subset_Files**. Data were organized as large matrices for the compactness of file size that is more suitable to fit into memory for training and testing machine learning models.

Please refer to the **File_Preparation_Guide** in each folder, or find all (248GB) MATLAB data files you need all at once in organized folders from this [OneDrive link](https://rutgersconnect-my.sharepoint.com/:f:/g/personal/ww329_soe_rutgers_edu/ElnVrq7MWdVGvvZztLCuNe0BDJ1YKh9FNBM0tK2BJVC0ew?e=fQYySg) or [Google Drive link](https://drive.google.com/drive/folders/1behw-Dljs8-p2axHQ6KJZ5HTRKQHQgnS?usp=sharing), including the already-generated **Subset** files. Remember to unzip the **PulseDB_MIMIC.zip** and **PulseDB_Vital.zip** files before you start if you want to generate the **Subset** files by yourself.

Tips for downloading data files:
- In our tests, the OneDrive links have shown better stability for downloading the data files, so we recommend using them.
- Downloading each of the file one at a time, instead of zipping multiple files in the online drive and download together, is more likely to success.
- Both OneDrive and GoogleDrive do not support resume downloading from break-point. Therefore, if the download pause or fail, you need to start all over again. This may creat difficulties when downloading the largest data files: **PulseDB_MIMIC.zip** (136GB) and **PulseDB_Vital.zip** (77.4GB) in wirelessly connected circumstances. To resolve this problem, we have created sub-section compressed version of these two files, with each section being 10GB. If you have failed multiple times when downloading the single zip files, try the sub-section compressed version and download the data files section-by-section. After downloading all sections, unzip any one of the sections to get the desired data folder. 
- If your unarchive software does not support subsection-compressed files, we suggest using the open-source software [7Zip](https://www.7-zip.org/) (for Windows only).
