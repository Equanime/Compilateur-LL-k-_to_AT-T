VAR
    ARRAY T[2], T2[3] : INTEGER;
    ARRAY TD[2] : DOUBLE;
    ARRAY S[7] : CHAR;
    i, j, k, x, y, z: INTEGER;
    f, t,b, true, false: BOOLEAN;
    c,e: CHAR;
    d,double,double1,double2: DOUBLE.

(*static array*)
BEGIN
     j:=1;
     T2:=[9,7,13];
     T:=[6,5];
     TD:=[6.1,5.2];
     S:=[ 'b', 'o', 'n', 'j', 'o', 'u', 'r' ];
     DISPLAY T2, ' ', T, ' ', TD , ' ', S, '\n';
     FOR i:=0 TO 2 DO
          DISPLAY T2[i];
     DISPLAY '\n';
     T2[j]:=1;
     DISPLAY T2
END;
DISPLAY '\n';


(*TEST FOR*)
BEGIN
     x := 10;
     y := 20;
     c := 'c';
     t := (3==3);
     f := !(3==3);
     true := TRUE;
     false := FALSE;
     double := 13.3;
     e := '=';


     (* FOR IMBRICATION*)
     FOR i := 1 TO 3 DO
     BEGIN
          (* DISPLAY *)
          DISPLAY 'i', '=',i, ' ' ;

          (* FOR TO loop *)
          FOR j := 1 TO 3 DO
          BEGIN
               DISPLAY 'j', '=',j, ' '
          END;
          DISPLAY ' ';

          (* FOR DOWNTO loop *)
          FOR j := 3 DOWNTO 1 DO
          BEGIN
               DISPLAY 'j', '=',j, ' '
          END;
          DISPLAY '\n';

          (* IF THEN statement *)
          IF (x == 10) THEN 
               DISPLAY 'x', '=', x, '\n';
          
          (* IF THEN ELSE statement *)
          IF !(x == 10) THEN
               DISPLAY 'E', '\n'
          ELSE
              DISPLAY 'x', '=', x, '\n';


          (* WHILE loop *)
          k := 1;
          WHILE k < 3 DO
          BEGIN
               DISPLAY 'k', '=', k, ' ';
               k := k + 1
          END;
          DISPLAY '\n';

          (* CASE statement *)
          CASE i OF
               1,2: DISPLAY 'i', '=', i, ' ';
               3: DISPLAY 'i', '=', i, ' ';
               4: DISPLAY 'i', '=', i, ' '
          ELSE
               DISPLAY ' '
          END;
          DISPLAY '\n', '\n'
     
     END
END;

(*TEST WHILE*)
BEGIN
     x := 10;
     y := 20;
     c := 'c';
     t := (3==3);
     f := !(3==3);
     true := TRUE;
     false := FALSE;
     double := 13.3;
     e := '=';
     WHILE (i!=0) DO
          i:=0;
     (* FOR IMBRICATION*)
     WHILE i<3 DO
     BEGIN
          (* DISPLAY *)
          DISPLAY 'i', '=',i, ' ' ;

          (* FOR TO loop *)
          FOR j := 1 TO 3 DO
          BEGIN
               DISPLAY 'j', '=',j, ' '
          END;
          DISPLAY ' ';

          (* FOR DOWNTO loop *)
          FOR j := 3 DOWNTO 1 DO
          BEGIN
               DISPLAY 'j', '=',j, ' '
          END;
          DISPLAY '\n';

          (* IF THEN statement *)
          IF (x == 10) THEN 
               DISPLAY 'x', '=', x, '\n';
          
          (* IF THEN ELSE statement *)
          IF !(x == 10) THEN
               DISPLAY 'E', '\n'
          ELSE
              DISPLAY 'x', '=', x, '\n';


          (* WHILE loop *)
          k := 1;
          WHILE k < 3 DO
          BEGIN
               DISPLAY 'k', '=', k, ' ';
               k := k + 1
          END;
          DISPLAY '\n';

          (* CASE statement *)
          CASE i OF
               1,2: DISPLAY 'i', '=', i, ' ';
               3: DISPLAY 'i', '=', i, ' ';
               4: DISPLAY 'i', '=', i, ' '
          ELSE
               DISPLAY ' '
          END;
          DISPLAY '\n', '\n';
          i:=i+1
     END
END;

(*TEST CASE*)
x:=12;
y:=6;
CASE x OF
     14: x := x - 1;
     (y+6): 
          CASE y OF
               6: FOR x:=203 DOWNTO 200 DO 
                         BEGIN
                              DISPLAY 'x', x, '\n'
                         END
          ELSE
               x:=x+10
          END
ELSE   
     x:=x+10
    
END;
DISPLAY '\n';

(*TEST TYPES*)
BEGIN
     i := 10;
     j := 3;

     k := i + j;  
     DISPLAY 'k', '=', k, '\n';
     k := i - j;  
     DISPLAY 'k', '=', k, '\n';
     (*ajouter signes*)
     k := j - i;  
     DISPLAY 'k', '=', k, '\n';
     k := i * j;
     DISPLAY 'k', '=', k, '\n';
     k := i % j;
     DISPLAY 'k', '=', k, '\n';
     k := i / j; 
     DISPLAY 'k', '=', k, '\n';
     k:=i;
     b := i > j; 
     DISPLAY 'b', '=', b, '\n';
     b := i >= j; 
     DISPLAY 'b', '=', b, '\n';
     b := i >= 10; 
     DISPLAY 'b', '=', b, '\n';

     b := i < j; 
     DISPLAY 'b', '=', b, '\n';
     b := i <= j; 
     DISPLAY 'b', '=', b, '\n';
     b := i <= 10; 
     DISPLAY 'b', '=', b, '\n';

     true := TRUE;
     DISPLAY 't', '=', true, '\n';
     false := FALSE;
     DISPLAY 'f', '=', false, '\n';
     false := i==j;
     DISPLAY 'f', '=', false, '\n';
     true := i!=j;
     DISPLAY 't', '=', true, '\n';
     b := (true|| true);  
     DISPLAY 'b', '=', b, '\n';
        b := (true|| false);  
     DISPLAY 'b', '=', b, '\n';
        b := (false||false);  
     DISPLAY 'b', '=', b, '\n';
         b := (true && true);  
     DISPLAY 'b', '=', b, '\n';
        b := (true && false);  
     DISPLAY 'b', '=', b, '\n';
        b := (false && false);  
     DISPLAY 'b', '=', b, '\n';

     c := 'A';
     DISPLAY 'c', '=', c, '\n';
     double1 := 3.14;

     DISPLAY 'd', '1', '=', double1, '\n';
     double2 := 10.93;
     DISPLAY 'd', '2', '=', double2, '\n';

     d := double1 + double2;  
     DISPLAY 'd', '=', d, '\n';
     d := double1 - double2;  
     DISPLAY 'd', '=', d, '\n';
     d := double2 - double1;  
     DISPLAY 'd', '=', d, '\n';
     d := double1 * double2;
     DISPLAY 'd', '=', d, '\n';
     d := double1 / double2; 
     DISPLAY 'd', '=', d, '\n';
     d:=double1;
     b := double1 > double2; 
     DISPLAY 'b', '=', b, '\n';
     b := double1 >= double2; 
     DISPLAY 'b', '=', b, '\n';
     b := double1 >= 10.0; 
     DISPLAY 'b', '=', b, '\n';
     b := double1 < double2; 
     DISPLAY 'b', '=', b, '\n';
     b := double1 <= double2; 
     DISPLAY 'b', '=', b, '\n';
     b := double1 <= 10.0; 
     DISPLAY 'b', '=', b, '\n'
END.