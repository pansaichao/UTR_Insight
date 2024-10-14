UTR-Insight: Integrating Deep Learning for Efficient 5′ UTR Discovery and Design

Install
Create a conda environment.

conda env create -f environment.yaml
conda activate UTR_Insight

Set up Model

pip install fair-esm
find -name esm
scp -r ./Scripts/esm ./.conda/envs/UTRLM/lib/python3.9/site-packages/ # Move the folder ./Scripts/esm/ to the conda env fold, such as ./.conda/envs/UTRLM/lib/python3.9/site-packages/
It is very important to Move the folder ./Scripts/esm/ to the conda env fold, such as ./.conda/envs/UTRLM/lib/python3.9/site-packages/, because we have modified the souce code of ESM.

Due to file size restrictions, please download the data for model training and article drawing at https://zenodo.org/records/12900201. Please download Data.7z and unzip it to main folder. Please download UTR_data.7z and unzip it to the article_plot folder.
