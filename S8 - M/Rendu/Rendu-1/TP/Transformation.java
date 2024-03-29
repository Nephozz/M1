
import algebra.*;

/**
 * author: cdehais
 */
public class Transformation  {

    Matrix worldToCamera;
    Matrix projection;
    Matrix calibration;

    public Transformation () {
        try {
            worldToCamera = new Matrix ("W2C", 4, 4);
            projection = new Matrix ("P", 3, 4);
            calibration = Matrix.createIdentity (3);
            calibration.setName ("K");
        } catch (InstantiationException e) {
            /* should not reach */
        }
    }

    public void setLookAt (Vector3 cam, Vector3 lookAt, Vector3 up) {
        try {

        for (int j = 0; j < 3; j++) {
            worldToCamera.set(3, j, 0);
        }
        worldToCamera.set(3, 3, 1);

        // compute rotation

        // set e_3c
        Vector3 e_3c = lookAt;
        e_3c.subtract(cam);
        e_3c.normalize();
        for (int j = 0; j < 3; j++) {
            worldToCamera.set(2, j, e_3c.get(j));
        }

        // set e_1c
        Vector3 e_1c = up.cross(e_3c);
        e_1c.normalize();
        for (int j = 0; j < 3; j++) {
            worldToCamera.set(0, j, e_1c.get(j));
        }

        // set e_2c
        Vector3 e_2c = e_3c.cross(e_1c);
        e_2c.normalize();
        for (int j = 0; j < 3; j++) {
            worldToCamera.set(1, j, e_2c.get(j));
        }

        // compute translation
        Matrix N = worldToCamera.getSubMatrix(0, 0, 3, 3);
        Vector t = N.multiply(cam);

        for (int i = 0; i < 3; i++) {
            worldToCamera.set(i, 3, -t.get(i));
        }


        } catch (Exception e) { /* unreached */ };
        
        System.out.println ("Modelview matrix:\n" + worldToCamera);
    }

    public void setProjection () {

        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 4; j++) {
                if (i == j) {
                    projection.set(i, j, 1);
                } else {
                    projection.set(i, j, 0);
                }
            }
        }

        System.out.println ("Projection matrix:\n" + projection);
    }

    public void setCalibration (double focal, double width, double height) {

        calibration.set(0,0, focal);
        calibration.set(1, 1, focal);
        
        calibration.set(0, 2, width / 2);
        calibration.set(1, 2, height / 2);

	    System.out.println ("Calibration matrix:\n" + calibration);
    }

    /**
     * Projects the given homogeneous, 4 dimensional point onto the screen.
     * The resulting Vector as its (x,y) coordinates in pixel, and its z coordinate
     * is the depth of the point in the camera coordinate system.
     */  
    public Vector3 projectPoint (Vector p)
        throws SizeMismatchException, InstantiationException {
	    
        Vector ps = new Vector(3);

        ps = worldToCamera.multiply(p);
        ps = projection.multiply(ps);

        double z = ps.get(2);
        ps.scale(1/z);

        ps = calibration.multiply(ps);

        ps.set(2, z);

	    return new Vector3 (ps);
    }
    
    /**
     * Transform a vector from world to camera coordinates.
     */
    public Vector3 transformVector (Vector3 v)
        throws SizeMismatchException, InstantiationException {
        /* Doing nothing special here because there is no scaling */
        Matrix R = worldToCamera.getSubMatrix (0, 0, 3, 3);
        Vector tv = R.multiply (v);
        return new Vector3 (tv);
    }
    
}

