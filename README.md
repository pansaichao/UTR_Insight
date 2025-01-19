UTR-Insight: Integrating Deep Learning for Efficient 5′ UTR Discovery and Design

Install
Create a conda environment.

conda env create -f environment.yaml
conda activate UTR_Insight

Set up Model

pip install fair-esm
find -name esm
scp -r ./Scripts/esm ./.conda/envs/UTRLM/lib/python3.9/site-packages/ # Move the folder ./Scripts/esm/ to the conda env fold, such as ./.conda/envs/UTRLM/lib/python3.9/site-packages/

It is very important to Move the folder ./Scripts/esm/ to the conda env fold, such as ./.conda/envs/UTR_Insight/lib/python3.9/site-packages/, because we have modified the souce code of ESM.

Due to file size restrictions, please download the data for model training and article drawing from the OMIX database (https://ngdc.cncb.ac.cn/omix), part of the Genome Sequence Archive (GSA) at the China National Center for Bioinformation. The dataset is named UTR MRL dataset, with the accession number OMIX008723. Please download OMIX008723-01.tar.gz, unzip it to the main folder, and rename the folder to Data. Similarly, download OMIX008723-02.7z, unzip it to the article_plot folder, and rename the folder to UTR_data.
