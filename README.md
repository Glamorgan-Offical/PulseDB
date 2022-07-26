# PulseDB Dataset

The script, **Generate_Subsets.m**, is provided to generate **Subset** files, which are the training and testing subsets of the PulseDB Dataset. **Subset** files are generated from the **Segment** and **Info** files stored in the folder **Segment_Files** and **Info_Files**, whose contents have to be downloaded seperatedly from Google Drive. 

The generated **Subset** files are stored in the folder **Subset_Files**. Data were organized as large matrices for the compactness of file size that is more suitable to fit into memory for training and testing machine learning models.

Please reference **File_Preparation_Guide** in each folder, or download everything you need all at once in organized folders from this [Google Drive link](https://drive.google.com/drive/folders/1behw-Dljs8-p2axHQ6KJZ5HTRKQHQgnS?usp=sharing), including the already-generated **Subset** files. Remember to unzip the **PulseDB_MIMIC.zip** and **PulseDB_Vital.zip** files before you start if you want to generate the **Subset** files by yourself.

