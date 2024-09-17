#include <cstdlib>

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

bool solid = false;

// function called everytime the windows is refreshed
void display()
{
    // clear window
    // glClear(GL_COLOR_BUFFER_BIT);
    // tp4 lighting
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // draw scene
    if (solid)
    {
        glutSolidTeapot(.5);
    }
    else
    {
        glutWireTeapot(.5);
    }
    // flush drawing routines to the window
    glFlush();
}

// Function called everytime a key is pressed
void key(unsigned char key, int, int)
{
    switch (key)
    {
    // the 'esc' key
    case 27:
    // the 'q' key
    case 'q':
        exit(EXIT_SUCCESS);
        break;
    // the 'w' key
    case 'w':
        solid = !solid;
        break;
    default:
        break;
    }
    glutPostRedisplay();
}

// Function called every time the main window is resized
void reshape(int width, int height)
{
    int size = width;
    if (height < size)
    {
        size = height;
    }

    int x = 0;
    int y = 0;
    if (width / 2 - size / 2 > 0)
    {
        x = (int)(width / 2 - size / 2);
    }

    if (height / 2 - size / 2 > 0)
    {
        y = (int)(height / 2 - size / 2);
    }
    // define the viewport transformation;
    glViewport(x, y, size, size);
}

// Main routine
int main(int argc, char *argv[])
{
    // initialize GLUT, using any commandline parameters passed to the
    //   program
    glutInit(&argc, argv);

    // setup the size, position, and display mode for new windows
    glutInitWindowSize(500, 500);
    glutInitWindowPosition(0, 0);
    // glutInitDisplayMode(GLUT_RGB);
    // tp4 lighting
    glutInitDisplayMode(GLUT_RGB | GLUT_DEPTH);

    // create and set up a window
    glutCreateWindow("Hello, teapot!");

    // Set up the callback functions:
    // for display
    glutDisplayFunc(display);
    // for the keyboard
    glutKeyboardFunc(key);
    // for reshaping
    glutReshapeFunc(reshape);

    // tp4 lighting
    glEnable(GL_DEPTH_TEST);

    // define the projection transformation
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(60, 1, 1, 10);

    // define the viewing transformation
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

    // fig a
    // gluLookAt(0.0, 1.5, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0);

    // fig b
    gluLookAt(0.0, 0.0, -1.5, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0);

    // tp4 lighting
    GLfloat light_ambient[] = {0.0, 0.0, 0.0, 1.0};  // the ambient component
    GLfloat light_diffuse[] = {1.0, 1.0, 1.0, 1.0};  // the diffuse component
    GLfloat light_specular[] = {1.0, 1.0, 1.0, 1.0}; // the specular component
    GLfloat light_position[] = {1.0, 1.0, 1.0, 0.0}; // the light position

    // set the components to the first light
    glLightfv(GL_LIGHT0, GL_AMBIENT, light_ambient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light_diffuse);
    glLightfv(GL_LIGHT0, GL_SPECULAR, light_specular);
    glLightfv(GL_LIGHT0, GL_POSITION, light_position);

    // activate lighting effects
    glEnable(GL_LIGHTING);
    // turn on the first light
    glEnable(GL_LIGHT0);

    // tell GLUT to wait for events
    glutMainLoop();
}
