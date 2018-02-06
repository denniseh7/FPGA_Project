library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

PACKAGE MY IS
PROCEDURE SQ(SIGNAL Xcur,Ycur,Xpos,Ypos: IN INTEGER; SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0); SIGNAL DRAW: OUT STD_LOGIC);
PROCEDURE BALL(SIGNAL Xcb,Ycb,Xpb,Ypb: IN INTEGER; SIGNAL BALLDRAW: OUT STD_LOGIC);
PROCEDURE WALL(SIGNAL Xcw,Ycw,Xpw,Ypw: IN INTEGER; SIGNAL WALLDRAW: OUT STD_LOGIC);
PROCEDURE SCORE(SIGNAL CurS,Xcs,Ycs,Xps,Yps: IN INTEGER; SIGNAL SCOREDRAW: OUT STD_LOGIC);
PROCEDURE WINSCORE(SIGNAL Pw1,Pw2,Xcwin,Ycwin,Xpwin,Ypwin: IN INTEGER; SIGNAL WINDRAW: OUT STD_LOGIC);
PROCEDURE VWALL(SIGNAL Xcv,Ycv,Xpv,Ypv: IN INTEGER; SIGNAL VERTDRAW: OUT STD_LOGIC);
END MY;

PACKAGE BODY MY IS
	PROCEDURE SQ(SIGNAL Xcur,Ycur,Xpos,Ypos: IN INTEGER; SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0); SIGNAL DRAW: OUT STD_LOGIC) IS
	BEGIN
		IF(Xcur>Xpos AND Xcur<(Xpos+15) AND Ycur>Ypos AND Ycur<(Ypos+75)) THEN
			RGB<="1111";
			DRAW<='1';
			ELSE
			DRAW<='0';
		END IF;
	END SQ;
	
	PROCEDURE BALL(SIGNAL Xcb,Ycb,Xpb,Ypb: IN INTEGER; SIGNAL BALLDRAW: OUT STD_LOGIC) IS
	BEGIN
		IF(Xcb>Xpb AND Xcb<(Xpb+15) AND Ycb>Ypb AND Ycb<(Ypb+15)) THEN
			BALLDRAW<='1';
		ELSE
			BALLDRAW<='0';
		END IF;
	END BALL;
	
	PROCEDURE WALL(SIGNAL Xcw,Ycw,Xpw,Ypw: IN INTEGER; SIGNAL WALLDRAW: OUT STD_LOGIC) IS
	BEGIN
		IF(Xcw>Xpw AND Xcw<(Xpw+675) AND Ycw>Ypw AND Ycw<(Ypw+30)) THEN
			WALLDRAW<='1';
			ELSE
			WALLDRAW<='0';
		END IF;
	END WALL; 
	
	PROCEDURE VWALL(SIGNAL Xcv,Ycv,Xpv,Ypv: IN INTEGER; SIGNAL VERTDRAW: OUT STD_LOGIC) IS
	BEGIN
		IF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv-1) AND Ycv<(Ypv+23)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+53) AND Ycv<(Ypv+83)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+113) AND Ycv<(Ypv+143)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+173) AND Ycv<(Ypv+203)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+233) AND Ycv<(Ypv+263)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+293) AND Ycv<(Ypv+323)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+353) AND Ycv<(Ypv+383)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+413) AND Ycv<(Ypv+443)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+473) AND Ycv<(Ypv+503)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+533) AND Ycv<(Ypv+563)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+593) AND Ycv<(Ypv+623)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+653) AND Ycv<(Ypv+683)) THEN
			VERTDRAW<='1';
		ELSIF(Xcv>(Xpv-10) AND Xcv<(Xpv+11) AND Ycv>(Ypv+713) AND Ycv<(Ypv+735)) THEN
			VERTDRAW<='1';
		ELSE
			VERTDRAW<='0';
		END IF;
	END VWALL;
	
	PROCEDURE SCORE(SIGNAL CurS,Xcs,Ycs,Xps,Yps: IN INTEGER; SIGNAL SCOREDRAW: OUT STD_LOGIC) IS
	BEGIN
		IF(CurS=1) THEN --1
			IF(Xcs>Xps AND Xcs<(Xps+20) AND Ycs>Yps AND Ycs<(Yps+100)) THEN
				SCOREDRAW<='1';
			ELSE
				SCOREDRAW<='0';
			END IF;			
		ELSIF (CurS=2) THEN --2
			IF(Xcs>(Xps-40) AND Xcs<(Xps+40) AND Ycs>Yps AND Ycs<(Yps+20)) THEN
				SCOREDRAW<='1';
			ELSIF(Xcs>(Xps-40) AND Xcs<(Xps+40) AND Ycs>(Yps+80) AND Ycs<(Yps+100)) THEN
				SCOREDRAW<='1';
			ELSIF(Xcs>(Xps-40) AND Xcs<(Xps+40) AND Ycs>(Yps+40) AND Ycs<(Yps+60)) THEN
				SCOREDRAW<='1';
			ELSIF(Xcs>(Xps+20) AND Xcs<(Xps+40) AND Ycs>Yps AND Ycs<(Yps+50)) THEN
				SCOREDRAW<='1';
			ELSIF(Xcs>(Xps-40) AND Xcs<(Xps-20) AND Ycs>(Yps+50) AND Ycs<(Yps+100)) THEN
				SCOREDRAW<='1';			
			ELSE
				SCOREDRAW<='0';
			END IF;
		ELSIF (CurS=3) THEN --3
			IF(Xcs>(Xps-40) AND Xcs<(Xps+40) AND Ycs>Yps AND Ycs<(Yps+20)) THEN
				SCOREDRAW<='1';
			ELSIF(Xcs>(Xps-40) AND Xcs<(Xps+40) AND Ycs>(Yps+80) AND Ycs<(Yps+100)) THEN
				SCOREDRAW<='1';
			ELSIF(Xcs>(Xps-40) AND Xcs<(Xps+40) AND Ycs>(Yps+40) AND Ycs<(Yps+60)) THEN
				SCOREDRAW<='1';			
			ELSIF(Xcs>(Xps+20) AND Xcs<(Xps+40) AND Ycs>Yps AND Ycs<(Yps+100)) THEN
				SCOREDRAW<='1';					
			ELSE
				SCOREDRAW<='0';
			END IF;
		ELSE --0
			IF(Xcs>(Xps-40) AND Xcs<(Xps+40) AND Ycs>Yps AND Ycs<(Yps+20)) THEN
				SCOREDRAW<='1';
			ELSIF(Xcs>(Xps-40) AND Xcs<(Xps+40) AND Ycs>(Yps+80) AND Ycs<(Yps+100)) THEN
				SCOREDRAW<='1';
			ELSIF(Xcs>(Xps-40) AND Xcs<(Xps-20) AND Ycs>Yps AND Ycs<(Yps+100)) THEN
				SCOREDRAW<='1';
			ELSIF(Xcs>(Xps+20) AND Xcs<(Xps+40) AND Ycs>Yps AND Ycs<(Yps+100)) THEN
				SCOREDRAW<='1';
			ELSE
				SCOREDRAW<='0';
			END IF;
		END IF;				
	END SCORE;
	
	PROCEDURE WINSCORE(SIGNAL Pw1,Pw2,Xcwin,Ycwin,Xpwin,Ypwin: IN INTEGER; SIGNAL WINDRAW: OUT STD_LOGIC) IS
	BEGIN		
		IF(Pw1>2) THEN			
			IF(Xcwin>(Xpwin-50) AND Xcwin<(Xpwin+50) AND Ycwin>(Ypwin+80) AND Ycwin<(Ypwin+100)) THEN
				WINDRAW<='1';
			ELSIF(Xcwin>(Xpwin-50) AND Xcwin<(Xpwin-30) AND Ycwin>Ypwin AND Ycwin<(Ypwin+100)) THEN
				WINDRAW<='1';
			ELSIF(Xcwin>(Xpwin+30) AND Xcwin<(Xpwin+50) AND Ycwin>Ypwin AND Ycwin<(Ypwin+100)) THEN
				WINDRAW<='1';
			ELSIF(Xcwin>(Xpwin-10) AND Xcwin<(Xpwin+10) AND Ycwin>Ypwin AND Ycwin<(Ypwin+100)) THEN
				WINDRAW<='1';
			ELSE
				WINDRAW<='0';
			END IF;
		ELSIF(Pw2>2) THEN
			IF(Xcwin>(Xpwin-40) AND Xcwin<(Xpwin+40) AND Ycwin>(Ypwin+80) AND Ycwin<(Ypwin+100)) THEN
				WINDRAW<='1';
			ELSIF(Xcwin>(Xpwin-40) AND Xcwin<(Xpwin-20) AND Ycwin>Ypwin AND Ycwin<(Ypwin+100)) THEN
				WINDRAW<='1';			
			ELSE
				WINDRAW<='0';
			END IF;
		ELSE
			WINDRAW<='0';
		END IF;
	END WINSCORE;
END MY;