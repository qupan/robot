@echo off

call robot -d D:\TA\API_interface\ERP\report D:\TA\API_interface\ERP\01\06-demo.robot

cd /d D:\demo

call python Excel_demo.py
