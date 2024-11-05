# Kitodo-OCR-Docker 
This project creates a docker image for Kitodo Production 3.7.1 and attach OCR-D maximum image to it for the OCR step.


In this version, the provided Example of workflow is modified to support Operandi-Integration-Script: https://github.com/subugoe/Operandi-Integration-Script/

<img width="1009" alt="Screenshot 2024-07-13 at 14 39 56" src="https://github.com/user-attachments/assets/0f41b3ff-a907-4b90-91c7-a1c90cb51459">

OLA-HD step is resposible of uploading the OCR-D results to OLA_HD Server: https://ola-hd.ocr-d.de/
OCR-D is supported locally and on HPC servers using Operandi project: https://github.com/subugoe/operandi

To use the OCR-D local processing `-l` flag must be added to Operandi(OCR) step in the workflow. To understand more, please read https://github.com/subugoe/Operandi-Integration-Script/

## Project Folder Structure
The project folder structure should contain at least following sub-folders:
<img width="1420" alt="Screenshot 2024-07-14 at 17 13 43" src="https://github.com/user-attachments/assets/02729328-2f8b-46d9-a6d5-8f279a4a62cc">
, where `images/master_(processtitle)_media` is the main images directory and `ocr/alto` is the OCR-D results directory. Thus, the Operandi(OCR) step needs those 2 paths to work. 
Also, any other file group sub-folder is optional and up to the user to decide.

## Quick Startup 
* Set `OPERANDI_USER_PASS="operandi_username:operandi_password"` and `OLA_USR="ola_hd_username:ola_hd_password"` values in the .env file
* Then `./run.sh`

Kitodo Production can be accessed at http://localhost:8080/kitodo with initial credentials `testAdmin / test`

## Note
This version of Kitodo has some rendering issues with some browsers, but works the best with Firefox browser
