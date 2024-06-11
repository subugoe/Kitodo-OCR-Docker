# Kitodo-OCR-Docker 
This code is based on Kitodo Production Docker installation of UB-Mannheim: https://github.com/UB-Mannheim/kitodo-production-docker


In this version, the provided Example of workflow is modified to support Operandi-Integration-Script: https://github.com/subugoe/Operandi-Integration-Script/

<img width="1077" alt="Screenshot 2024-06-05 at 13 42 15" src="https://github.com/subugoe/Kitodo-OCR-Docker/assets/142503679/fbc9dbb1-9abd-4a99-bc9b-4a71d4572bbe">


## Quick Startup 
### Set `OPERANDI_USER_PASS="operandi_username:operandi_password"` and `OLA_USR="ola_hd_username:ola_hd_password"` values in the .env file
### Then `./run.sh`

Kitodo Production can be accessed at http://localhost:8080/kitodo with initial credentials `testAdmin / test`
