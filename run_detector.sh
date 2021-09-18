#!/bin/bash

# Provide the detector iteration count as a command-line parameter
# (e.g., `./run_detector.sh 42082`

detector="full_trained_model/detectors-$1"

root_dir="~/isorc20_journal"
carla_results_dir="${root_dir}/carla_results"
detector_results_dir="${root_dir}/detector_results"

for i in 1 2 3 4 5; do
    image_path="${carla_results_dir}/scenario_${i}/rgb"
    output_path="${detector_results_dir}/scenario_${i}"

    mkdir -p $output_path

    # Detect vehicles, motobikes, and bikes as 'vehicles'
    python3 image_detection.py \
            --model_path=$detector \
            --images_path=$image_path \
            --min_threshold=0.70 \
            --output_path=$output_path \
            --class_list="vehicle,bike,motobike" \
            --class_str="vehicle" \
            --save_images

    # Detect pedestrians as 'pedestrians'
    python3 image_detection.py \
            --model_path=$detector \
            --images_path=$image_path \
            --min_threshold=0.70 \
            --output_path=$output_path \
            --class_list="pedestrian" \
            --class_str="pedestrian"

    # Update the file names
    mv "${output_path}/rgb_log_vehicle.txt" "${output_path}/vehicle_bboxes_scenario_${i}_detector.txt"
    mv "${output_path}/rgb_log_pedestrian.txt" "${output_path}/pedestrian_bboxes_scenario_${i}_detector.txt"

done
