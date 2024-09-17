
#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <iostream>

// for mac osx
#ifdef __APPLE__
#include <GLUT/glut.h>
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#else
// only for windows
#ifdef _WIN32
#include <windows.h>
#endif
// for windows and linux
#include <GL/freeglut.h>
#include <GL/gl.h>
#include <GL/glu.h>

#endif

// Global variables to animate the robotic arm
float angle1 = 30.0f;
float angle2 = 40.0f;
float pincersX = 1.0f;

// Global variables to rotate the arm as a whole
float robotAngleX = .0f;
float robotAngleY = .0f;

constexpr float angle_step = 5.f;
constexpr float angle_max = 360.f;
constexpr float pincers_step = 0.1f;
constexpr float pincers_max = 1.625f;

/**
 * Function that draws the reference system (three lines along the x, y, z axis)
 */
void drawReferenceSystem()
{
    //**********************************
    // set the line width to 3.0
    //**********************************
    glLineWidth(3.0);
    //**********************************
    // Draw three lines along the x, y, z axis to represent the reference system
    // Use red for the x-axis, green for the y-axis and blue for the z-axis
    //**********************************
    glBegin(GL_LINES);
    // x-axis
    glColor3f(1.0, 0.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(1.0, 0.0, 0.0);
    // y-axis
    glColor3f(0.0, 1.0, 0.0);
    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(0.0, 1.0, 0.0);
    // z-axis
    glColor3f(0.0, 0.0, 1.0);
    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(0.0, 0.0, 1.0);
    glEnd();

    //**********************************
    // reset the drawing color to white
    //**********************************
    glColor3f(1.0, 1.0, 1.0);
    //**********************************
    // reset the line width to 1.0
    //**********************************
    glLineWidth(1.0);
}

/**
 * Function that draws a single joint of the robotic arm
 */
void drawJoint()
{
    // first draw the reference system
    drawReferenceSystem();

    glPushMatrix();
    // Draw the joint as a parallelepiped (a cube scaled on the y-axis)
    //**********************************
    glScalef(1.0, 2.0, 1.0);
    // Bring the cube "up" so that the bottom face is on the xz plane
    //**********************************
    glTranslatef(0.0, 0.5, 0.0);
    glutWireCube(1.0);

    //**********************************
    // draw the scaled cube. Remember that the scaling has to be only
    // on the local reference system, hence we need to get a local copy
    // of the modelview matrix...
    //**********************************
    glPopMatrix();
}

/**
 * Function that draws the robot as three parallelepipeds
 */
void drawRobot()
{
    //**********************************
    // we work on a copy of the current MODELVIEW matrix, hence we need to...
    //**********************************
    glPushMatrix();

    // draw the first joint
    drawJoint();

    // Draw the other joints: every joint must be placed on top of the previous one
    // and rotated according to the relevant Angle
    //**********************************
    // the second joint
    //**********************************
    glTranslatef(0.0, 2.0, 0.0);
    glRotatef(angle1, 1.0, 0.0, 0.0);
    drawJoint();

    //**********************************
    // the third joint
    //**********************************

    glTranslatef(0.0, 2.0, 0.0);
    glRotatef(angle2, 1.0, 0.0, 0.0);
    drawJoint();

    //**********************************
    // the pincers
    //**********************************
    glTranslatef(0.0, 2.125, 0.0);
    glScalef(0.9, 0.2, 0.2);
    glutWireCube(1.0);

    glScalef(0.3, 3, 1);
    glTranslatef(pincersX, 0.625, 0.0);
    glutWireCube(1.0);

    glTranslatef(-2. * pincersX, 0.0, 0.0);
    glutWireCube(1.0);

    //**********************************
    // "Release" the copy of the current MODELVIEW matrix
    //**********************************
    glPopMatrix();
}

/**
 * Function that handles the display callback (drawing routine)
 */
void display()
{
    // clear the window
    glClear(GL_COLOR_BUFFER_BIT);

    // working with the GL_MODELVIEW Matrix
    glMatrixMode(GL_MODELVIEW);

    //**********************************
    // we work on a copy of the current MODELVIEW matrix, hence we need to...
    //**********************************
    glPushMatrix();
    //**********************************
    // Rotate the robot around the x-axis and y-axis according to the relevant angles
    //**********************************
    glRotatef(robotAngleX, 1.0, 0.0, 0.0);
    glRotatef(robotAngleY, 0.0, 1.0, 0.0);
    // draw the robot
    drawRobot();

    //**********************************
    // "Release" the copy of the current MODELVIEW matrix
    //**********************************
    glPopMatrix();
    // flush drawing routines to the window
    glutSwapBuffers();
}

/**
 * Function that handles the special keys callback
 * @param[in] key the key that has been pressed
 * @param[in] x the mouse in window relative x-coordinate when the key was pressed
 * @param[in] y the mouse in window relative y-coordinate when the key was pressed
 */
void arrows(int key, int, int)
{
    //**********************************
    // Manage the update of RobotAngleX and RobotAngleY with the arrow keys
    //**********************************
    switch(key)
    {
        case GLUT_KEY_UP: robotAngleX = std::max(robotAngleX - angle_step, -180.f); break;
        case GLUT_KEY_DOWN: robotAngleX = std::min(robotAngleX + angle_step, 180.f); break;
        case GLUT_KEY_LEFT: robotAngleY = std::max(robotAngleY - angle_step, -180.f); break;
        case GLUT_KEY_RIGHT: robotAngleY = std::min(robotAngleY + angle_step, 180.f); break;
        default: break;
    }

    glutPostRedisplay();
}

/**
 * Function that handles the keyboard callback
 * @param key  the key that has been pressed
 * @param[in] x the mouse in window relative x-coordinate when the key was pressed
 * @param[in] y the mouse in window relative y-coordinate when the key was pressed
 */
void keyboard(unsigned char key, int, int)
{
    switch(key)
    {
        case 'q':
        case 27:
            exit(0);
            break;
            //**********************************
            // Manage the update of Angle1 with the key 'a' and 'z'
            //**********************************

        case 'a': angle1 = std::max(angle1 - angle_step, .0f); break;
        case 'z': angle1 = std::min(angle1 + angle_step, angle_max); break;
        //**********************************
        // Manage the update of Angle2 with the key 'e' and 'r'
        //**********************************
        case 'e': angle2 = std::max(angle2 - angle_step, .0f); break;
        case 'r': angle2 = std::min(angle2 + angle_step, angle_max); break;
        case 'o': pincersX = std::max(pincersX - pincers_step, 0.5f); break;
        case 'l': pincersX = std::min(pincersX + pincers_step, pincers_max); break;
        default: break;
    }

    glutPostRedisplay();
}

void init()
{
    glClearColor(0.f, 0.f, 0.f, 0.f);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(65.0, 1.0, 1.0, 100.0);

    glShadeModel(GL_FLAT);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

    // Place the camera
    gluLookAt(-6., 4, -6., .0, 2.0, 0., .0, 1., .0);
}

/**
 * Function called every time the main window is resized
 * @param[in] width the new window width in pixels
 * @param[in] height the new window height in pixels
 */
void reshape(int width, int height)
{
    // define the viewport transformation;
    glViewport(0, 0, width, height);
    if(width < height)
        glViewport(0, (height - width) / 2, width, width);
    else
        glViewport((width - height) / 2, 0, height, height);
}

/**
 * Function that prints out how to use the keyboard
 */
void usage()
{
    std::cout << "\n*******\n";
    std::cout << "Arrows key: rotate the whole robot\n";
    std::cout << "[a][z] : move the second joint of the arm\n";
    std::cout << "[e][r] : move the third joint of the arm\n";

    std::cout << "[esc]  : terminate\n";
    std::cout << "*******\n";
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
    glutInitWindowSize(500, 500);
    glutInitWindowPosition(100, 100);
    glutCreateWindow(argv[0]);
    init();
    glutDisplayFunc(display);

    glutReshapeFunc(reshape);
    //**********************************
    // Register the keyboard function
    //**********************************
    glutKeyboardFunc(keyboard);
    //**********************************
    // Register the special key function
    //**********************************
    glutSpecialFunc(arrows);
    // just print the help
    usage();

    glutMainLoop();

    return EXIT_SUCCESS;
}
