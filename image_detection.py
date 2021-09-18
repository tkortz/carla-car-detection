from detection import *



if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--model_path', help='Path to the frozen inference graph and labelmap files',
                        required=True)
    parser.add_argument('--images_path', help='Path to the folder of images', required=True)
    parser.add_argument('--min_threshold', type=float, help='Minimum score threshold for a bounding box to be drawn', default=0.7)
    parser.add_argument('--output_path', help='Path for storing output images and/or logs', required=True)
    parser.add_argument('--save_images', action='store_true')
    parser.add_argument('--class_list', help='Comma-separated list of classes to detect', required=True)
    parser.add_argument('--class_str', help='String to represent class list in logfile name', required=True)

    args = parser.parse_args()

    det = detector(args.model_path)
    det.process_image_folder(args.images_path, args.min_threshold,
                             args.output_path, args.save_images,
                             args.class_list.split(','), args.class_str)
