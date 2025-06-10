#!/bin/bash

# Buat folder results jika belum ada
mkdir -p results

# Jalankan semua file .robot di dalam folder testcases/
robot --outputdir results --name PRODUCT-PAYMENT \
  testcases/ottopoint.robot 
  python3 library/notify_to_gspace.py