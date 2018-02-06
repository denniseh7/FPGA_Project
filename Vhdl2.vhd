library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_arith.all;

use work.my.all;

ENTITY SYNC IS
PORT(
CLK: IN STD_LOGIC;
HSYNC,VSYNC: OUT STD_LOGIC;
R,G,B: OUT STD_LOGIC_VECTOR(3 downto 0);
KEYS: IN STD_LOGIC_VECTOR(3 downto 0);
S: IN STD_LOGIC_VECTOR(1 downto 0);
H0,H1,H2,H3: OUT STD_LOGIC_VECTOR(6 downto 0)
);

END SYNC;

ARCHITECTURE MAIN OF SYNC IS
--rgb
SIGNAL RGB: STD_LOGIC_VECTOR(3 downto 0);

--horizontal/vertical sync
SIGNAL HPOS: INTEGER RANGE 0 TO 1688:=0;
SIGNAL VPOS: INTEGER RANGE 0 TO 1066:=0;

--signals for drawing
SIGNAL DRAW1, DRAW2, BDRAW, WDRAW1, WDRAW2, VDRAW, SDRAW1, SDRAW2, WINDRAW1, WINDRAW2: STD_LOGIC:='0';

--bars
SIGNAL SQ_X1: INTEGER RANGE 0 TO 1688:=750; --left bar x-position
SIGNAL SQ_X2: INTEGER RANGE 0 TO 1688:=1410; --right bar x-position
SIGNAL SQ_Y1,SQ_Y2: INTEGER RANGE 0 TO 1066:=512; --initial y-position of bars

--ball (X,Y positions) (X direction, Y direction)=B_XNEG,B_YNEG
SIGNAL B_X: INTEGER RANGE 550 TO 1440:=1073; 
SIGNAL B_Y: INTEGER RANGE 0 TO 1066:=527;
SIGNAL B_XNEG: INTEGER RANGE 0 to 1:= 1;
SIGNAL B_YNEG: INTEGER RANGE 0 to 1:= 1;

--top bottom walls
SIGNAL W_X1: INTEGER RANGE 0 TO 1688:=750; --top wall x-position
SIGNAL W_X2: INTEGER RANGE 0 TO 1688:=750; --bottom wall x-position
SIGNAL W_Y1: INTEGER RANGE 0 TO 1066:=239; --top wall y-position 244
SIGNAL W_Y2: INTEGER RANGE 0 TO 1066:=1003; --bottom wall y-position 1033

--middle wall
SIGNAL V_X: INTEGER RANGE 0 TO 1688:=1087;
SIGNAL V_Y: INTEGER RANGE 0 TO 1066:=269; 
--score
SIGNAL P_1SCORE: INTEGER RANGE 0 to 3:= 0;
SIGNAL P_2SCORE: INTEGER RANGE 0 to 3:= 0;
SIGNAL S_X1: INTEGER RANGE 0 TO 1688:=967; --p1 score x-position
SIGNAL S_X2: INTEGER RANGE 0 TO 1688:=1207; --p2 score x-position
SIGNAL S_Y1,S_Y2: INTEGER RANGE 0 TO 1066:=380; -- score y-position

--winner display
SIGNAL WIN_X1: INTEGER RANGE 0 to 1688:=967;
SIGNAL WIN_Y1: INTEGER RANGE 0 to 1066:=650;
SIGNAL WIN_X2: INTEGER RANGE 0 to 1688:=1207;
SIGNAL WIN_Y2: INTEGER RANGE 0 to 1066:=650;


BEGIN


WALL(HPOS,VPOS,W_X1,W_Y1,WDRAW1);
WALL(HPOS,VPOS,W_X2,W_Y2,WDRAW2);
VWALL(HPOS,VPOS,V_X,V_Y,VDRAW);
BALL(HPOS,VPOS,B_X,B_Y,BDRAW);
SCORE(P_1SCORE,HPOS,VPOS,S_X1,S_Y1,SDRAW1);
SCORE(P_2SCORE,HPOS,VPOS,S_X2,S_Y2,SDRAW2);
SQ(HPOS,VPOS,SQ_X1,SQ_Y1,RGB,DRAW1);
SQ(HPOS,VPOS,SQ_X2,SQ_Y2,RGB,DRAW2);
WINSCORE(P_1SCORE,P_2SCORE,HPOS,VPOS,WIN_X1,WIN_Y1,WINDRAW1);
WINSCORE(P_2SCORE,P_1SCORE,HPOS,VPOS,WIN_X2,WIN_Y2,WINDRAW2);

PROCESS(CLK)
BEGIN

--reset
IF(S(0)='1') THEN	
		HPOS<=0;
		VPOS<=0;			
		SQ_Y1<=512;
		SQ_Y2<=512;
		B_X<=1073;
		B_Y<=527;
		P_1SCORE<=0;
		P_2SCORE<=0;
		
ELSE

	IF (CLK'EVENT AND CLK='1') THEN
		--seven side display
		H1(0)<='1';
		H1(1)<='1';
		H1(2)<='1';
		H1(3)<='1';
		H1(4)<='1';
		H1(5)<='1';
		H1(6)<='1';
		
		H3(0)<='1';
		H3(1)<='1';
		H3(2)<='1';
		H3(3)<='1';
		H3(4)<='1';
		H3(5)<='1';
		H3(6)<='1';
		
		--right side score display hex
		IF(P_2SCORE=0) THEN
			H0(0)<='0';
			H0(1)<='0';
			H0(2)<='0';
			H0(3)<='0';
			H0(4)<='0';
			H0(5)<='0';
			H0(6)<='1';
		ELSIF(P_2SCORE=1) THEN
			H0(0)<='1';
			H0(1)<='0';
			H0(2)<='0';
			H0(3)<='1';
			H0(4)<='1';
			H0(5)<='1';
			H0(6)<='1';
		ELSIF(P_2SCORE=2) THEN
			H0(0)<='0';
			H0(1)<='0';
			H0(2)<='1';
			H0(3)<='0';
			H0(4)<='0';
			H0(5)<='1';
			H0(6)<='0';
		ELSIF(P_2SCORE=3) THEN
			H0(0)<='0';
			H0(1)<='0';
			H0(2)<='0';
			H0(3)<='0';
			H0(4)<='1';
			H0(5)<='1';
			H0(6)<='0';
		ELSE
			H0(0)<='1';
			H0(1)<='1';
			H0(2)<='1';
			H0(3)<='1';
			H0(4)<='1';
			H0(5)<='1';
			H0(6)<='0';
		END IF;
		
		--left side score display hex
		IF(P_1SCORE=0) THEN
			H2(0)<='0';
			H2(1)<='0';
			H2(2)<='0';
			H2(3)<='0';
			H2(4)<='0';
			H2(5)<='0';
			H2(6)<='1';
		ELSIF(P_1SCORE=1) THEN
			H2(0)<='1';
			H2(1)<='0';
			H2(2)<='0';
			H2(3)<='1';
			H2(4)<='1';
			H2(5)<='1';
			H2(6)<='1';			
		ELSIF(P_1SCORE=2) THEN
			H2(0)<='0';
			H2(1)<='0';
			H2(2)<='1';
			H2(3)<='0';
			H2(4)<='0';
			H2(5)<='1';
			H2(6)<='0';
		ELSIF(P_1SCORE=3) THEN
			H2(0)<='0';
			H2(1)<='0';
			H2(2)<='0';
			H2(3)<='0';
			H2(4)<='1';
			H2(5)<='1';
			H2(6)<='0';
		ELSE
			H2(0)<='0';
			H2(1)<='0';
			H2(2)<='0';
			H2(3)<='0';
			H2(4)<='0';
			H2(5)<='0';
			H2(6)<='1';
		END IF;
	
		IF(DRAW1='1') THEN		
				R<=(OTHERS=>'1');
				G<=(OTHERS=>'1');
				B<=(OTHERS=>'1');			
		END IF;
		
		IF(DRAW2='1') THEN
				R<=(OTHERS=>'1');
				G<=(OTHERS=>'1');
				B<=(OTHERS=>'1');
		END IF;
		
		IF(WDRAW1='1') THEN
			R<=(OTHERS=>'0');
			G<=(OTHERS=>'1');
			B<=(OTHERS=>'0');
		END IF;
		
		IF(WDRAW2='1') THEN
			R<=(OTHERS=>'0');
			G<=(OTHERS=>'1');
			B<=(OTHERS=>'0');
		END IF;
		
		IF(VDRAW='1') THEN
			R<=(OTHERS=>'0');
			G<=(OTHERS=>'0');
			B<=(OTHERS=>'1');
		END IF; 
		
		IF(SDRAW1='1') THEN
			R<=(OTHERS=>'0');
			G<=(OTHERS=>'1');
			B<=(OTHERS=>'1');
		END IF;
		
		IF(SDRAW2='1') THEN
			R<=(OTHERS=>'0');
			G<=(OTHERS=>'1');
			B<=(OTHERS=>'1');
		END IF;	
		
		IF(WINDRAW1='1') THEN
			R<=(OTHERS=>'1');
			G<=(OTHERS=>'1');
			B<=(OTHERS=>'0');
		END IF;
		
		IF(WINDRAW2='1') THEN
			R<=(OTHERS=>'1');
			G<=(OTHERS=>'1');
			B<=(OTHERS=>'0');
		END IF;
		
		IF(BDRAW='1') THEN
			R<=(OTHERS=>'1');
			G<=(OTHERS=>'0');
			B<=(OTHERS=>'0');
		END IF;
		
		IF (DRAW1='0' AND DRAW2='0' AND BDRAW='0' AND WDRAW1='0' AND WDRAW2='0' AND VDRAW='0' AND SDRAW1='0' AND SDRAW2='0' AND WINDRAW1='0' AND WINDRAW2='0') THEN
				R<=(OTHERS=>'0');
				G<=(OTHERS=>'0');
				B<=(OTHERS=>'0');
		END IF;
		
		IF (HPOS<1688) THEN
			HPOS<=HPOS+1;
			ELSE
			HPOS<=0;
				IF(VPOS<1066) THEN
					VPOS<=VPOS+1;
					ELSE
					VPOS<=0;
					
					IF(KEYS(0)='0')THEN
						IF (SQ_Y2<278) THEN --top check left bar
							SQ_Y2<=269;
						ELSE
							SQ_Y2<=SQ_Y2-8;
						END IF;					
					END IF;
					
					IF(KEYS(3)='0')THEN
						IF (SQ_Y1>917) THEN --bottom check left bar
							SQ_Y1<=928;
						ELSE
							SQ_Y1<=SQ_Y1+8;
						END IF;	
					END IF;
					IF(KEYS(2)='0')THEN --top check right bar
						IF (SQ_Y1<278) THEN
							SQ_Y1<=269;
						ELSE
							SQ_Y1<=SQ_Y1-8;
						END IF;	
					END IF;
					IF(KEYS(1)='0')THEN --bottom check right bar
						IF (SQ_Y2>917) THEN
							SQ_Y2<=928;
						ELSE
							SQ_Y2<=SQ_Y2+8;
						END IF;					
					END IF;				
					
					--ball direction vertically
					IF (B_YNEG>0) THEN					
						IF(B_Y>986) THEN
							B_Y<=988;
							B_YNEG<=B_YNEG-1;
						ELSE
							B_Y<=B_Y+2;
						END IF;
					ELSE
						IF(B_Y<272) THEN
							B_Y<=269;
							B_YNEG<=B_YNEG+1;
						ELSE
							B_Y<=B_Y-2;
						END IF;
					END IF;
					
					--ball direction horizontally
					--ball going right
					IF (B_XNEG>0) THEN						
						IF(B_X=1395) THEN --check collision with right bar
							IF(B_Y>=(SQ_Y2-15) AND B_Y<=(SQ_Y2+85)) THEN
								B_X<=1395; 
								B_XNEG<=B_XNEG-1; --change direction
							ELSE							
								B_X<=B_X+2;	--ball move right						
							END IF;
						ELSE
							IF(B_X>1410) THEN
								B_X<=1073; --reset to center								
								IF(P_2SCORE<3 AND P_1SCORE<3) THEN
									P_1SCORE<=P_1SCORE+1;								
								END IF;
								B_XNEG<=B_XNEG-1;
							ELSE
								B_X<=B_X+2;
							END IF;
						END IF;
					ELSE --ball go left
						IF(B_X=765) THEN --left bar collision check
							IF(B_Y>=(SQ_Y1-15) AND B_Y<=(SQ_Y1+85)) THEN
								B_X<=765;
								B_XNEG<=B_XNEG+1; --change direction
							ELSE							
								B_X<=B_X-2; --ball move left
							END IF;
						ELSE
							IF(B_X<750) THEN
								B_X<=1073; --reset to center
								IF(P_2SCORE<3 AND P_1SCORE<3) THEN
									P_2SCORE<=P_2SCORE+1;																	
								END IF;								
								B_XNEG<=B_XNEG+1;
							ELSE
								B_X<=B_X-2;
							END IF;
						END IF;						
					END IF;						
				END IF;		
		
		END IF;
		IF(HPOS>48 AND HPOS<160)THEN
			HSYNC<='0';
		ELSE
			HSYNC<='1';	
		END IF;
		IF(VPOS>0 AND VPOS<4)THEN
			VSYNC<='0';
		ELSE
			VSYNC<='1';	
		END IF;
		IF ((HPOS>0 AND HPOS<408)OR(VPOS>0 AND VPOS<42)) THEN
		R<=(OTHERS=>'0');
		G<=(OTHERS=>'0');
		B<=(OTHERS=>'0');
		END IF;
	
	END IF;
END IF;
END PROCESS;
END MAIN;