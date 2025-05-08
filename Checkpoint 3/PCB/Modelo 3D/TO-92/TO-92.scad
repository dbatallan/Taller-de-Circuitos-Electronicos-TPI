to92A = 3.45;
to92A2 = 1.22;
to92b = 0.38;
to92c = 0.38;
to92D = 4.27;
to92D1 = 3.87;
to92E = 4.32;
to92ee = 1.27;
to92ee2 = 2.54;
to92L = 5.98;
to92L1 = 3.80;
to92L2 = 0.80;
to92L3 = 2.0;
to92L4 = 1.9;

module to92body()
{
    color([0.3, 0.3, 0.3])
    translate([0, 0, to92E / 2])
    {
        linear_extrude(height = to92E, center = true)
            polygon(points = [
                [-to92D1 / 2, to92A2],
                [to92D1 / 2, to92A2],
                [to92D / 2, 0],
                [-to92D / 2, 0]]);
        intersection()
        {
            translate([0, -to92D / 2, 0])
                    cube(size = [to92D * 2, to92D, to92E * 2],
                        center = true);
                cylinder(r = to92D / 2, h = to92E, center = true,
                    $fn = 20);
        }
    }
}


module to92bulk()
{
    to92body();
    color([0.8, 0.8, 0.8])
    {
        for (j = [-1, 0, +1])
            translate([j * to92ee, 0, -to92L / 2])
                cube(size = [to92b, to92c, to92L], center = true);
    }
}
module to92sideBend()
{
    translate([-to92b, 0, 0])
        rotate(-90, [1, 0, 0])
            linear_extrude(height = to92c, center = true)
                polygon(points = [
                    [0, 0],
                    [to92b, 0],
                    [to92b + to92ee2 - to92ee, to92L3 - to92L2],
                    [to92ee2 - to92ee, to92L3 - to92L2]]);
}
module to92doubleSideBend()
{
    color([0.8, 0.8, 0.8])
    {
        for(j = [-1, +1])
            translate([j * (to92ee-0.6), 0, -to92L2 / 2])
                cube(size = [to92b, to92c, to92L2], center = true);
        for ( j = [-1, +1])
            translate([j * (to92ee2-0.6), 0,
                -(to92L1 - to92L3) / 2 - to92L3])
                cube(size = [to92b, to92c, to92L1 - to92L3],
                    center = true);
        
	translate([0, 0, -to92L2])
        {
            translate([to92ee-0.41, 0, 0])
                to92sideBend();
            translate([-to92ee+0.41, 0, 0])
                mirror([1, 0, 0]) to92sideBend();
        }
    }
}

module to92taped()
{
    to92body();
    color([0.8, 0.8, 0.8])
    {
        translate([0, 0, -to92L / 2])
            cube(size = [to92b, to92c, to92L], center = true);
        to92doubleSideBend();
    }
}


module to92leadBend()
{
    color([0.8, 0.8, 0.8]){
    translate([0, -0.7, -to92L2 / 2])
        cube(size = [to92b, to92c, to92L2], center = true);
    translate([0, -0.89, -to92L2])
        rotate(-90, [0, 0, 1])
            to92sideBend();
    translate([0, -0.7-to92ee, -(to92L3 * 2 + to92L4) / 2])
        cube(size = [to92b, to92c, to92L4], center = true);
    }
}



to92body();
to92leadBend();
to92doubleSideBend();