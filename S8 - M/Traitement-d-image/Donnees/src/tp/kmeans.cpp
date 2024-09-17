#include "ocv_utils.hpp"
#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>
#include <vector>
#include <stdlib.h>
#include <cmath>
#include <algorithm>

using namespace cv;
using namespace std;

void printHelp(const string &progName)
{
    cout << "Usage:\n\t " << progName << " <image_file> <K_num_of_clusters> [<image_ground_truth>]" << endl;
}

Mat kmeans_maison(Mat data, int nb_clust)
{
    // Déclaration des variables
    Mat labels = Mat::zeros(data.rows, data.cols, CV_8UC1);
    vector<double> distances;
    double distance, epsilon = 0.00000001, norm_max = 2 * epsilon;
    int min_index, count, nb_iter = 0;
    Point3f center;

    // Initialisation des centres des clusters avec des valeurs
    vector<Point3f> centers;
    vector<Point3f> centers_old;

    for (int k = 0; k < nb_clust; k++)
    {
        centers.push_back(Point3f(rand() % 255, rand() % 255, rand() % 255));
    }

    while (norm_max > epsilon)
    {
        // Asignation des pixels au centre le plus proche
        for (int i = 0; i < data.rows; i++)
        {

            distances.clear();

            for (int k = 0; k < nb_clust; k++)
            {
                distance = norm(centers[k] - data.at<Point3f>(i, 0));
                distances.push_back(distance);
            }

            min_index = min_element(distances.begin(), distances.end()) - distances.begin();
            labels.at<int>(i, 0) = min_index;
        }

        centers_old = centers;
        // Mise à jour des centres de clusters
        for (int k = 0; k < nb_clust; k++)
        {
            count = 0;
            center = Point3f(0, 0, 0);
            for (int i = 0; i < data.rows; i++)
            {
                if (labels.at<int>(i, 0) == k)
                {
                    count++;
                    center += data.at<Point3f>(i, 0);
                }
            }
            centers[k] = center / count;
        }
        norm_max = 0;
        for (int k = 0; k < nb_clust; k++)
        {
            if (norm_max < norm(centers[k] - centers_old[k]))
            {
                norm_max = norm(centers[k] - centers_old[k]);
            }
        }
    }

    return labels;
}

pair<Mat, int> meanshift(Mat I, int k_max) {

    int h_s = 10; 
    float h_c = 10., epsilon = 0.001;
    int k = 1;
    Mat I_out = I.clone();

    bool convergence = false;

    while (!convergence && k < k_max) {

        for (int i = 0; i < I.rows; i++) {
            for (int j = 0; j < I.cols; j++) {
                vector<Vec3f> m_region;

                for (int x = max(0, i - h_s); x < min(I.rows, i + h_s + 1); x++) {
                    for (int y = max(0, j - h_s); y < min(I.cols, j + h_s + 1); y++) {
                        Vec3f diff = I_out.at<Vec3f>(x, y) - I_out.at<Vec3f>(i, j);
                        float dist = norm(diff);
                        if (dist <= h_c) {
                            m_region.push_back(I.at<Vec3f>(x, y));
                        }
                    }
                }

                Vec3f sum = Vec3f(0., 0., 0.); 
                int n = m_region.size();

                for (int l = 0; l < n; l++) {
                    sum += m_region[l];
                }

                Vec3f M = sum / n;

                if (!convergence && (norm(I_out.at<Vec3f>(i,j) - M) <= epsilon)) {
                    convergence = true;
                }

                I_out.at<Vec3f>(i,j) = M;
            }
        }

        k++;
    }

    pair<Mat,int> res;
    res.first = I_out;
    res.second = k - 1;

    return res;
}

void calcul_qualite(Mat m_ref, Mat clustered_image)
{

    float TP, FP, TN, FN, TP_2, FP_2, TN_2, FN_2;
    TP = 0.;
    FP = 0.;
    TN = 0.;
    FN = 0.;
    TP_2 = 0.;
    FP_2 = 0.;
    TN_2 = 0.;
    FN_2 = 0.;

    for (int i = 0; i < m_ref.rows; i++)
    {
        for (int j = 0; j < m_ref.cols; j++)
        {
            if (clustered_image.at<uchar>(i,j) == 255.0 && m_ref.at<uchar>(i,j) == 255.0)
            {
                TP++;
                FP_2++;
            }
            else if (clustered_image.at<uchar>(i, j) == 255.0 && m_ref.at<uchar>(i, j) == 0.0)
            {
                FP++;
                TP_2++;
            }
            else if (clustered_image.at<uchar>(i, j) == 0.0 && m_ref.at<uchar>(i, j) == 255.0)
            {
                FN++;
                TN_2++;
            }
            else
            {
                TN++;
                FN_2++;
            }
        }
    }

    double DSC, P, S;
    double DSC1 = 2 * TP / (2 * TP + FP + FN);
    double DSC2 = 2 * TP_2 / (2 * TP_2 + FP_2 + FN_2);

    if (DSC1 > DSC2)
    {
        DSC = DSC1;
        P = TP / (TP + FP);
        S = TP / (TP + FN);
    }
    else
    {
        DSC = DSC2;
        P = TP_2 / (TP_2 + FP_2);
        S = TP_2 / (TP_2 + FN_2);
    }

    cout << "P = " << P << endl;
    cout << "S = " << S << endl;
    cout << "DSC = " << DSC << endl
         << endl;
}

int main(int argc, char **argv)
{
    if (argc != 3 && argc != 4)
    {
        cout << " Incorrect number of arguments." << endl;
        printHelp(string(argv[0]));
        return EXIT_FAILURE;
    }

    const auto imageFilename = string(argv[1]);
    const string groundTruthFilename = (argc == 4) ? string(argv[3]) : string();
    const int k = stoi(argv[2]);

    // just for debugging
    {
        cout << " Program called with the following arguments:" << endl;
        cout << " \timage file: " << imageFilename << endl;
        cout << " \tk: " << k << endl;
        if (!groundTruthFilename.empty())
            cout << " \tground truth segmentation: " << groundTruthFilename << endl;
    }

    // load the color image to process from file
    Mat m = imread(imageFilename, IMREAD_COLOR);    

    // 1) in order to call kmeans we need to first convert the image into floats (CV_32F)
    // see the method Mat.convertTo()

    m.convertTo(m, CV_32F);
    PRINT_MAT_INFO(m);

    // 2) kmeans asks for a mono-dimensional list of "points". Our "points" are the pixels of the image that can be seen as 3D points
    // where each coordinate is one of the color channel (e.g. R, G, B). But they are organized as a 2D table, we need
    // to re-arrange them into a single vector.
    // see the method Mat.reshape(), it is similar to matlab's reshape

    Mat m_reshaped = m.reshape(3, m.rows * m.cols);

    // Adding position to the matrix
    Mat positions = Mat::zeros(m.rows * m.cols, 2, CV_32F);

    for (int i = 0; i < m.rows; i++)
    {
        for (int j = 0; j < m.cols; j++)
        {
            positions.at<float>(i * m.cols + j, 1) = i;
            positions.at<float>(i * m.cols + j, 2) = j;
        }
    }

    // hconcat(m_reshaped, positions, m_reshaped);

    Mat result = meanshift(m, k).first;
    result.convertTo(result, CV_8UC1);
    // now we can call kmeans(...)

    Mat labels;
    Mat centers;
    TermCriteria criteria(cv::TermCriteria::EPS + cv::TermCriteria::COUNT, 10, 1.0);
    kmeans(m_reshaped, k, labels, criteria, 3, cv::KMEANS_RANDOM_CENTERS, centers);

    Mat labels_maison = kmeans_maison(m_reshaped, k);

    Mat clustered_image = labels.reshape(1, m.rows);
    Mat clustered_image_maison = labels_maison.reshape(1, m.rows);

    clustered_image.convertTo(clustered_image, CV_8UC1);
    clustered_image_maison.convertTo(clustered_image_maison, CV_8UC1);

    // Rendre l'image visible
    clustered_image = 255 / (k - 1) * clustered_image;
    clustered_image_maison = 255 / (k - 1) * clustered_image_maison;

    // Sauvgarde le résultat
    imwrite("../data/images/out.png", clustered_image);
    imwrite("../data/images/out_maison.png", clustered_image_maison);
    imwrite("../data/images/ms_out.png", result);

    // Affichage
    namedWindow("Clustered Image", cv::WINDOW_AUTOSIZE);
    namedWindow("Clustered Image Maison", cv::WINDOW_AUTOSIZE);
    namedWindow("Meanshift Image", cv::WINDOW_AUTOSIZE);
    imshow("Clustered Image", clustered_image);
    imshow("Meanshift Image", result);
    imshow("Clustered Image Maison", clustered_image_maison);
    waitKey(0);

    // Evalutaion des résultats

    Mat m_ref = imread(groundTruthFilename, IMREAD_GRAYSCALE);

    printf("openCV K-means results : \n");
    calcul_qualite(m_ref, clustered_image);
    printf("our K-means results : \n");
    calcul_qualite(m_ref, clustered_image_maison);

    return EXIT_SUCCESS;
}
