;ENTER THE STRING :abc
;cba REVERSE STRING IS


GETSTR MACRO STR
MOV AH,0AH
LEA DX,STR
INT 21H
ENDM


PRINTSTR MACRO STR
MOV AH,09H
LEA DX,STR
INT 21H
ENDM

DATA SEGMNT
  STR1 DB 80,80 DUP(`$`)
  STR2 DB 80,80 DUP(`$`)
  MSG1 DB 10,13,`ENTER THE STRING:$`
  MSG2 DB 10,13,`THE REVERSE STRING IS:$`
  STORE DB 2 DUP(`$`)

DATA ENDS

CODE SEGMENT

    ASSUME CS:CODE,DS:DATA
    START:
       MOV AX,DATA
       MOV DS,AX
       PRINTSTR MSG2

       LEA SI,STR1+2
       LEA DI,STR2+2



       MOV CL,STR1+1   ;FOR STORING THE LENGTH OF THE STRING
       MOV CH,00H
       MOV BL,CL
       MOV BH,00H

    LAB1:
       INC SI    ;FOR GOING TO THE END OF THE STRING
       LOOP LAB1
       MOV CX,BX


    LAB2
       MOV AL,DS:BYTE PTR[SI];FOR COPYING CONTENTS OF STR1 TO AL
       MOV DS:BYTE PTR[DI],AL:FOR COPYING CONTENTS OF AL TOSTR2
       INC DI
       DEC SI
       LOOP LAB2



   PRINTSTR STR2+2
   MOV AH,DS:BYTE PTR[SI]
   MOV STORE,AH
   PRINTSTR STORE




   MOV AX,4C00H
   INT 21H



CODE ENDS
  END START






