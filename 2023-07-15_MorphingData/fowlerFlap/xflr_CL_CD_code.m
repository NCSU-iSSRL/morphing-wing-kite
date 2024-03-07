                %%% Carson - June 11 2023
                xflr5CL_1000 = [-0.4031, -0.5222, -0.4466, -0.6255, -0.4381, -0.2691, -0.1262, 0.0312, 0.1934, 0.4119, 0.6110, 0.7806, 0.9787, 1.1347, 1.1650]';
                xflr5CD_1000 = [0.1493, 0.1219, 0.0926, 0.0512, 0.0359, 0.0328, 0.0331, 0.0326, 0.0344, 0.0404, 0.0503, 0.0617, 0.0747, 0.0875, 0.1013]';
                xflr5alfa_1000 = -14:2:14;

                xflr5CL_1004 = [-0.4549, -0.4570, -0.4539, -0.4687, -0.2831, -0.1353, 0.0010, 0.1579, 0.3444, 0.5528, 0.7407, 0.9400, 1.1681, 1.2407, 1.2807]';
                xflr5CD_1004 = [0.1495, 0.1110, 0.0752, 0.0472, 0.0395, 0.0425, 0.0443, 0.0450, 0.0487, 0.0567, 0.0676, 0.0810, 0.0953, 0.1103, 0.1269]';
                xflr5alfa_1004 = -14:2:14;
                
                xflr5CL_1152 = [-0.4135, -0.5001, -0.4528, -0.3823, -0.2008, -0.0351, 0.1188, 0.2958, 0.4820, 0.6691, 0.8389, 1.0115, 1.1305, 1.1918, 1.254314]';
                xflr5CD_1152 = [0.1261, 0.0919, 0.0599, 0.0386, 0.0329, 0.0355, 0.0367, 0.0392, 0.0453, 0.0551, 0.0677, 0.0815, 0.0928, 0.1064, 0.1244]';
                xflr5alfa_1152 = -14:2:14;

                xflr5CL_1154 = [-0.4380, -0.4265, -0.5054, -0.4038, -0.2103, -0.0502, 0.0971, 0.2685, 0.4630, 0.6677, 0.8780, 1.0759, 1.2017, 1.2609, 1.2350]';
                xflr5CD_1154 = [0.1404, 0.1031, 0.0656, 0.0428, 0.0358, 0.0384, 0.0409, 0.0433, 0.0487, 0.0582, 0.0732, 0.0904, 0.1042, 0.1178, 0.1645]';
                xflr5alfa_1154 = -14:2:14;

                xflr5CL_1304 = [-0.4304, -0.4055, -0.3489, -0.3122, -0.1279, 0.0304, 0.1832, 0.3549, 0.5402, 0.7207, 0.8814, 1.0557, 1.1833, 1.2459, 1.2201]';
                xflr5CD_1304 = [0.1311, 0.0945, 0.0598, 0.0377, 0.0325, 0.0359, 0.0397, 0.0438, 0.0511, 0.0619, 0.0755, 0.0909, 0.1074, 0.1219, 0.1690]';
                xflr5alfa_1304 = -14:2:14;
                
%                 vhcl.portWing.setCL(xflr5CL_1000/2, '');
%                 vhcl.portWing.setCD(xflr5CD_1000/2, '');
%                 vhcl.portWing.setAlpha(xflr5alfa_1000, 'deg');
%                 vhcl.stbdWing.setCL(xflr5CL_1000/2, '');
%                 vhcl.stbdWing.setCD(xflr5CD_1000/2, '');
%                 vhcl.stbdWing.setAlpha(xflr5alfa_1000, 'deg');

%                 vhcl.portWing.setCL(xflr5CL_1004/2, '');
%                 vhcl.portWing.setCD(xflr5CD_1004/2, '');
%                 vhcl.portWing.setAlpha(xflr5alfa_1004, 'deg');
%                 vhcl.stbdWing.setCL(xflr5CL_1004/2, '');
%                 vhcl.stbdWing.setCD(xflr5CD_1004/2, '');
%                 vhcl.stbdWing.setAlpha(xflr5alfa_1004, 'deg');

%                 vhcl.portWing.setCL(xflr5CL_1154/2, '');
%                 vhcl.portWing.setCD(xflr5CD_1154/2, '');
%                 vhcl.portWing.setAlpha(xflr5alfa_1154, 'deg');
%                 vhcl.stbdWing.setCL(xflr5CL_1154/2, '');
%                 vhcl.stbdWing.setCD(xflr5CD_1154/2, '');
%                 vhcl.stbdWing.setAlpha(xflr5alfa_1154, 'deg');

%                 vhcl.portWing.setCL(xflr5CL_1152/2, '');
%                 vhcl.portWing.setCD(xflr5CD_1152/2, '');
%                 vhcl.portWing.setAlpha(xflr5alfa_1152, 'deg');
%                 vhcl.stbdWing.setCL(xflr5CL_1152/2, '');
%                 vhcl.stbdWing.setCD(xflr5CD_1152/2, '');
%                 vhcl.stbdWing.setAlpha(xflr5alfa_1152, 'deg');

                vhcl.portWing.setCL(xflr5CL_1304/2, '');
                vhcl.portWing.setCD(xflr5CD_1304/2, '');
                vhcl.portWing.setAlpha(xflr5alfa_1304, 'deg');
                vhcl.stbdWing.setCL(xflr5CL_1304/2, '');
                vhcl.stbdWing.setCD(xflr5CD_1304/2, '');
                vhcl.stbdWing.setAlpha(xflr5alfa_1304, 'deg');
                %%%