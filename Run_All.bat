@echo off

call chcp 65001

call svn update "D:\TA\API_interface\shop"

call robot -d D:\TA\API_interface\shop\report D:\TA\API_interface\shop\case

call cd /d D:\TA\API_interface\shop\word

call python Excel_Report-demo.py

call send_mail.py

TIMEOUT /T 3
