@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

rem Set values for your storage account
set subscription_id=8a59d120-91e7-43b3-a22e-8cae383d75d5
set azure_storage_account=knowledgease
set azure_storage_key=GVJ6ivJTd4xxYIIRoWr72jRJQr3N2HHVYPjBdXW1256SIqzPP2AiloXHPpkWcRq+2M1P7iJLOtBAO16RcdcCrw==


echo Creating container...
call az storage container create --account-name !azure_storage_account! --subscription !subscription_id! --name margies --public-access blob --auth-mode key --account-key !azure_storage_key! --output none

echo Uploading files...
call az storage blob upload-batch -d margies -s data --account-name !azure_storage_account! --auth-mode key --account-key !azure_storage_key!  --output none
