.586
;;Stan Mihai Alexandru grupa 4
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc
extern printf: proc
includelib canvas.lib
extern BeginDrawing: proc
extern fopen: proc
extern fclose: proc
extern fscanf: proc
extern fprintf: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data


;aici declaram date
window_title DB "Exemplu proiect desenare",0
area_width EQU 640
area_height EQU 480
area DD 0
image_width EQU 10
image_height EQU 10
;;Variabiles
direction dd 2
snakeLength dd 4 
snakeY dd 200
snakeX dd 230
appleY dd 100
appleX dd 100
rotten_appleX dd 400
rotten_appleY dd 400
golden_appleX dd 150
golden_appleY dd 150
ardeiX dd 400
ardeiY dd 400
randomX dd 0
randomY dd 4
rotten_randomX dd 40
rotten_randomY dd 40
golden_randomX dd 15
golden_randomY dd 16
ardei_randomX dd 9
ardei_randomY dd 30
speed dd 0
make_fruit dd 0 ;;;Cu aceasta globala vedem daca apare un ardei/mar auriu (cand e 5 ardei, 3 mar auriu);
snakeXarray dd 200,210,220,230, 2048 dup (0)
snakeYarray dd 200,200,200,200, 2048 dup (0)
counter DD 0 ; numara evenimentele de tip timer
aux DD 0
HighScore dd 0
game_situation dd 0
fruit dd 0
delay dd 0
arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

;;;Date pentru fisiere
mode_w db "w", 0
mode_r db "r", 0
fname db "HighestScore.txt", 0
format db "%d", 10, 0
pointer dd 0
pointer_aux dd 0

symbol_width EQU 10
symbol_height EQU 20
include digits.inc
include letters.inc
include body.inc
include appleRed.inc
include SnakeHead.inc
include MarStricat.inc
include GoldenApple.inc
include ardei.inc
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ardei
make_ardei proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, ardei_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_ardei endp

; simple macro to call the procedure easier
make_ardei_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_ardei
	add esp, 12
endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Mar de aur
make_GoldenApple proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, GoldenApple_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_GoldenApple endp

; simple macro to call the procedure easier
make_GoldenApple_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_GoldenApple
	add esp, 12
endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MarStricat
make_MarStricat proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, MarStricat_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_MarStricat endp

; simple macro to call the procedure easier
make_MarStricat_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_MarStricat
	add esp, 12
endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SnakeHead
make_SnakeHead proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, SnakeHead_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_SnakeHead endp

; simple macro to call the procedure easier
make_SnakeHead_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_SnakeHead
	add esp, 12
endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SnakeBody
make_snake proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, green_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_snake endp

; simple macro to call the procedure easier
make_snake_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_snake
	add esp, 12
endm
make_apple proc
	push ebp
	mov ebp, esp
	pusha

	lea esi, apple_0
	
draw_image:
	mov ecx, image_height
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_apple endp

; simple macro to call the procedure easier
make_apple_macro macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_apple
	add esp, 12
endm
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 00FF00h
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm
line_vertical macro x, y, len, color
local bucla_linia
	mov eax, y
	mov ebx, area_width
	mul ebx
	add eax, x
	shl eax, 2
	add eax, area
	mov ecx, len
bucla_linia:
	mov dword ptr[eax], color
	add eax, area_width*4
	loop bucla_linia
endm

line_horizontal macro x, y, len, color
local bucla_linia
	mov eax, y
	mov ebx, area_width
	mul ebx
	add eax, x
	shl eax, 2
	add eax, area
	mov ecx, len
bucla_linia:
	mov dword ptr[eax], color
	add eax, 4
	loop bucla_linia
endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm
EndGame proc
	push ebp
	mov ebp, esp
	pusha

	
	make_text_macro "G", area, 230, 200
	make_text_macro "A", area, 240, 200
	make_text_macro "M", area, 250, 200
	make_text_macro "E", area, 260, 200
	
	make_text_macro "O", area, 280, 200
	make_text_macro "V", area, 290, 200
	make_text_macro "E", area, 300, 200
	make_text_macro "R", area, 310, 200
	
	make_text_macro "P", area, 190, 300
	make_text_macro "R", area, 200, 300
	make_text_macro "E", area, 210, 300
	make_text_macro "S", area, 220, 300
	make_text_macro "S", area, 230, 300
	
	make_text_macro "R", area, 250, 300
	
	make_text_macro "T", area, 270, 300
	make_text_macro "O", area, 280, 300
	
	make_text_macro "R", area, 300, 300
	make_text_macro "E", area, 310, 300
	make_text_macro "S", area, 320, 300
	make_text_macro "T", area, 330, 300
	make_text_macro "A", area, 340, 300
	make_text_macro "R", area, 350, 300
	make_text_macro "T", area, 360, 300
	
	

	popa
	mov esp, ebp
	pop ebp
	ret 
EndGame endp
Randomizer proc
	push ebp
	mov ebp, esp
	pusha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;mar
apple_again:
	inc randomY
	inc randomX		
	cmp randomX, 63
	jge reset_randomX
	jmp randomX_continue
reset_randomX:
	mov randomX, 1
randomX_continue:	
	cmp randomY, 47
	jge reset_randomY
	jmp randomY_continue
reset_randomY:
	mov randomY, 4
randomY_continue:
	cmp randomY, 10
	JL no_wall_touch9
	cmp randomY, 14
	JG no_wall_touch9
	cmp randomX, 39
	JG no_wall_touch9
	cmp randomX, 20
	JL no_wall_touch9
	jmp apple_again
no_wall_touch9:
	cmp randomY, 30
	JL no_wall_touch10
	cmp randomY, 34
	JG no_wall_touch10
	cmp randomX, 39
	JG no_wall_touch10
	cmp randomX, 20
	JL no_wall_touch10
	jmp apple_again
no_wall_touch10:

;;;;;;;;;;;;;;;;;;;;;;;;;;Mar stricat
rotten_again:
	inc rotten_randomY
	inc rotten_randomX		
	cmp rotten_randomX, 63
	jge reset_rotten_randomX
	jmp rotten_randomX_continue
reset_rotten_randomX:
	mov rotten_randomX, 1
rotten_randomX_continue:	
	cmp rotten_randomY, 47
	jge reset_rotten_randomY
	jmp rotten_randomY_continue
reset_rotten_randomY:
	mov rotten_randomY, 4
rotten_randomY_continue:
	cmp rotten_randomY, 10
	JL no_wall_touch7
	cmp rotten_randomY, 14
	JG no_wall_touch7
	cmp rotten_randomX, 39
	JG no_wall_touch7
	cmp rotten_randomX, 20
	JL no_wall_touch7
	jmp rotten_again
no_wall_touch7:
	cmp rotten_randomY, 30
	JL no_wall_touch8
	cmp rotten_randomY, 34
	JG no_wall_touch8
	cmp rotten_randomX, 39
	JG no_wall_touch8
	cmp rotten_randomX, 20
	JL no_wall_touch8
	jmp rotten_again
no_wall_touch8:


golden_again:
	RDTSC
	mov edx, 0
	mov ebx, 62
	div ebx
	add edx, 1
	mov golden_randomX, edx
	RDTSC
	mov edx, 0
	mov ebx, 42
	div ebx
	add edx, 4
	mov golden_randomY, edx
	cmp golden_randomY, 10
	JL no_wall_touch5
	cmp golden_randomY, 14
	JG no_wall_touch5
	cmp golden_randomX, 39
	JG no_wall_touch5
	cmp golden_randomX, 20
	JL no_wall_touch5
	jmp golden_again
no_wall_touch5:
	cmp golden_randomY, 30
	JL no_wall_touch6
	cmp golden_randomY, 34
	JG no_wall_touch6
	cmp golden_randomX, 39
	JG no_wall_touch6
	cmp golden_randomX, 20
	JL no_wall_touch6
	jmp golden_again
no_wall_touch6:
	
	
ardei_again:	
	RDTSC
	mov edx, 0
	mov ebx, 62
	div ebx
	add edx, 1
	mov ardei_randomX, edx
	RDTSC
	mov edx, 0
	mov ebx, 42
	div ebx
	add edx, 4
	mov ardei_randomY, edx
	cmp ardei_randomY, 10
	JL no_wall_touch3
	cmp ardei_randomY, 14
	JG no_wall_touch3
	cmp ardei_randomX, 39
	JG no_wall_touch3
	cmp ardei_randomX, 20
	JL no_wall_touch3
	jmp ardei_again
no_wall_touch3:
	cmp ardei_randomY, 30
	JL no_wall_touch4
	cmp ardei_randomY, 34
	JG no_wall_touch4
	cmp ardei_randomX, 39
	JG no_wall_touch4
	cmp ardei_randomX, 20
	JL no_wall_touch4
	jmp ardei_again
no_wall_touch4:
	
	RDTSC
	mov edx, 0
	mov ebx, 30
	div ebx
	mov make_fruit, edx
	
	popa
	mov esp, ebp
	pop ebp
	ret
Randomizer endp
; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click, 3 - s-a apasat o tasta)
; arg2 - x (in cazul apasarii unei taste, x contine codul ascii al tastei care a fost apasata)
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	
	push eax
	push 0
	push area
	call memset
	add esp, 12
										;;reset highscore
	cmp dword ptr[ebp + arg2], 'H'
	jne same_highschore
	mov HighScore, 0
same_highschore:
	
	cmp dword ptr[ebp + arg2], 'R'			;;reset game
	jne R_not_pressed
	cmp game_situation, 1
	jne R_not_pressed

	mov snakeLength, 4
	mov dword ptr[snakeYarray], 200
	mov dword ptr[snakeYarray + 4], 200
	mov dword ptr[snakeYarray + 8], 200
	mov dword ptr[snakeYarray + 12], 200
	mov dword ptr[snakeXarray], 200
	mov dword ptr[snakeXarray + 4], 210
	mov dword ptr[snakeXarray + 8], 220
	mov dword ptr[snakeXarray + 12], 230
	mov direction, 2
	mov snakeY, 200
	mov snakeX, 230
	mov counter, 0
	mov game_situation, 0
R_not_pressed:

	cmp game_situation, 1		;;Verificam daca s-a terminat jocul
	je end_of_draw

	;;Comparam counter cu HighScore sa vedem daca s-a facut un nou record
	mov eax, counter
	cmp eax, HighScore
	jle mai_mic
	mov HighScore, eax
	push offset mode_w
	push offset fname
	call fopen
	add esp, 8
	mov eax, pointer_aux
	mov pointer, eax
	push HighScore
	push offset format
	push pointer
	call fprintf
	add esp, 12
	push pointer
	call fclose
	add esp, 4
mai_mic:
	;afisam valoarea counter-ului curent (sute, zeci si unitati)
	mov ebx, 10
	mov eax, counter
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 100, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 90, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 80, 10
	
	;scriem un mesaj
	make_text_macro 'S', area, 20, 10
	make_text_macro 'C', area, 30, 10
	make_text_macro 'O', area, 40, 10
	make_text_macro 'R', area, 50, 10
	make_text_macro 'E', area, 60, 10
	line_horizontal 0, 40, 640, 00FFFFh
	line_horizontal 0, 470, 640, 00FFFFh
	line_vertical 10, 40, 440, 00FFFFh
	line_vertical 630, 40, 440, 00FFFFh
	line_horizontal 200, 100 , 200, 00FFFFh
	line_horizontal 200, 150 , 200, 00FFFFh
	line_vertical 200, 100, 50, 00FFFFh
	line_vertical 400, 100, 50, 00FFFFh
	line_horizontal 200, 300 , 200, 00FFFFh
	line_horizontal 200, 350 , 200, 00FFFFh  ;;y,x,lungime
	line_vertical 200, 300, 50, 00FFFFh
	line_vertical 400, 300, 50, 00FFFFh
	make_text_macro 'H', area, 200, 10
	make_text_macro 'I', area, 210, 10
	make_text_macro 'G', area, 220, 10
	make_text_macro 'H', area, 230, 10
	make_text_macro 'E', area, 240, 10
	make_text_macro 'S', area, 250, 10
	make_text_macro 'T', area, 260, 10
	make_apple_macro area, appleX, appleY
	;afisam valoarea HighScore-ului curent (sute, zeci si unitati)
	mov ebx, 10
	mov eax, HighScore
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 300, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 290, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 280, 10
											;;La fiecare 5 puncte apare un mar stricat
	mov eax, counter
	mov edx, 0
	mov ebx, 5
	div ebx
	cmp counter, 0
	je no_rotten_apple
	cmp edx, 0
	jne no_rotten_apple
	make_MarStricat_macro area, rotten_appleX, rotten_appleY
	mov fruit, 1
no_rotten_apple:
											;;Cand make_fruit e 3 apare un mar auriu(care ofera 2 puncte cand mancat)
	cmp make_fruit, 3
	jne no_golden_apple
	cmp fruit, 0 
	jne no_golden_apple
	mov ebx, 10
	mov eax, golden_randomX
	mul ebx
	mov golden_appleX, eax
	mov ebx, 10
	mov eax, golden_randomY
	mul ebx
	mov golden_appleY, eax
	mov fruit, 3
no_golden_apple:
	cmp fruit, 3
	jne no_golden_apple2
	make_GoldenApple_macro area, golden_appleX, golden_appleY
no_golden_apple2:	
											;;Cand make_fruit e 5 apare un ardei(care mareste viteza sarpelui)
	cmp make_fruit, 5
	jne no_ardei
	cmp fruit, 0
	jne no_ardei
	mov ebx, 10
	mov eax, ardei_randomX
	mul ebx
	mov ardeiX, eax
	mov ebx, 10
	mov eax, ardei_randomY
	mul ebx
	mov ardeiY, eax
	mov fruit, 5
no_ardei:
	cmp fruit, 5
	jne no_ardei2
	make_ardei_macro area, ardeiX, ardeiY
no_ardei2:
	 ;;Afisam capul sarpelui + corpul in timp ce se deplaseaza
	mov ecx, snakeLength
	sub ecx, 1
	make_SnakeHead_macro area, dword ptr[snakeXarray + ecx*4], dword ptr[snakeYarray + ecx*4]
snake_loop:
	mov eax, ecx
	dec eax
	make_Snake_macro area, dword ptr[snakeXarray + eax*4], dword ptr[snakeYarray + eax * 4]
	loop snake_loop
	
	
	
	cmp dword ptr[ebp + arg2], 'A'
	je left_going
	cmp dword ptr[ebp + arg2], 'S'
	je down_going
	cmp dword ptr[ebp + arg2], 'D'
	je right_going
	cmp dword ptr[ebp + arg2], 'W'
	je up_going
	jmp miscare
left_going:
	mov direction, 0
	jmp miscare
down_going:
	mov direction, 1
	jmp miscare
right_going:
	mov direction, 2
	jmp miscare
up_going:
	mov direction, 3    ;;Se afla valoarea lui direction (care ne arata directia de mers)
miscare:
	cmp direction, 0
	je left_moving
	cmp direction, 1
	je down_moving
	cmp direction, 2
	je right_moving
	cmp direction, 3 
	je up_moving
	jmp next

left_moving:                      ;;;Deplasare
	sub snakeX, 10
	jmp next
down_moving:
	add snakeY, 10
	jmp next
right_moving:
	add snakeX, 10
	jmp next
up_moving:
	sub snakeY, 10

next:	
								;;;Verificam daca sarpele loveste peretii
	cmp snakeY, 100
	JL no_wall_touch1
	cmp snakeY, 140
	JG no_wall_touch1
	cmp snakeX, 390
	JG no_wall_touch1
	cmp snakeX, 200
	JL no_wall_touch1
	jmp GameOver
no_wall_touch1:
	cmp snakeY, 300
	JL no_wall_touch2
	cmp snakeY, 340
	JG no_wall_touch2
	cmp snakeX, 390
	JG no_wall_touch2
	cmp snakeX, 200
	JL no_wall_touch2
	jmp GameOver
no_wall_touch2:
								;;;vericam daca sarpele atinge marginea
	cmp snakeX, 630
	je GameOver
	cmp snakeX, 0
	je GameOver
	cmp snakeY, 30
	je GameOver
	cmp snakeY, 470
	je GameOver
	mov ecx, snakeLength
								;;;Verificam daca sarpele se musca pe el insusi
GameOver_loop:
	mov eax, snakeX
	cmp eax, dword ptr[snakeXarray + 4*ecx]
	je verificareY
	jmp non_verificareY
verificareY:
	mov eax, snakeY
	cmp eax, dword ptr[snakeYarray + 4*ecx]
	je GameOver
non_verificareY:
	loop GameOver_loop
	jmp not_GameOver
	jmp not_GameOver
GameOver:						;;;Orice conditie de moarte duce la GameOver
	mov game_situation, 1
not_GameOver:
	
										 
	mov ecx, snakeLength
	mov ebx, snakeX
	mov dword ptr[snakeXarray + ecx*4], ebx
	mov ebx, snakeY										;;Mutare in coada vectorilor Y si X a noului head
	mov dword ptr[snakeYarray + ecx*4], ebx
	
	
						;;crearea unor valori random pentru pozitia marului(si a marului stricat/auriu/ardeiului si a make_fruit)
	Call Randomizer
				;;Verificam daca sarpele mananca ardeiului
	mov edx, snakeX
	cmp edx, ardeiX
	jne no_bite_ardei
	mov edx, snakeY
	cmp edx, ardeiY
	jne no_bite_ardei
	mov fruit, 0
	mov speed, 1
no_bite_ardei:
speed_reset_no:
				;;Verificare daca sarpele manaca marul auriu
	mov edx, snakeX
	cmp edx, golden_appleX
	jne no_bite_golden_apple
	mov edx, snakeY
	cmp edx, golden_appleY
	jne no_bite_golden_apple
	mov fruit, 0
	inc counter
	inc counter
no_bite_golden_apple:
				;;Verificare daca sarpele mananca marul
	mov edx, snakeX
	cmp edx, appleX
	je comparatie_marY_sarpeY
	jmp snake_update2
comparatie_marY_sarpeY:
	mov edx, snakeY
	cmp edx, appleY
	je marire_sarpe
	jmp snake_update2
marire_sarpe:
	inc counter
	add snakeLength, 1
	mov eax, randomX
	mov ebx, 10
	mul ebx
	mov appleX, eax
	
	mov eax, randomY
	mov ebx, 10
	mul ebx
	mov appleY, eax
	jmp no_snake_update
	
snake_update2:
	mov eax, 0
	mov ecx, snakeLength
snake_update:
	mov edx, dword ptr[snakeXarray + eax*4 + 4]
	mov dword ptr[snakeXarray + eax*4], edx				;;Shiftare la stanga pentru a deplasa sarpele
	mov edx, dword ptr[snakeYarray + eax*4 + 4]
	mov dword ptr[snakeYarray + eax*4], edx
	inc eax
	loop snake_update
	
									;;Daca sarpele are viteza mai mare. 
							;;Cand speed este 0 nu are viteza, cand ardeiul e mancat primeste 1 si numara pana la 50
							;;Adica sarpele are viteza marita 50 de miscari 
	cmp speed, 70
	jne no_speed_reset
	mov speed, 0
no_speed_reset:
	cmp speed, 0 
	je no_speed_increment
	inc speed
no_speed_increment:
	 test speed, 1
	 jz no_speed
	 jmp miscare
 no_speed:
							;;Daca sarpele mananca marul stricat
	cmp fruit, 1
	jne no_snake_update
	mov edx, snakeX
	cmp edx, rotten_appleX
	je comparatie_rotten_marY_sarpeY
	jmp no_snake_update
comparatie_rotten_marY_sarpeY:
	mov edx, snakeY
	cmp edx, rotten_appleY
	je micsorare_sarpe
	jmp no_snake_update
micsorare_sarpe:
	inc counter
	mov eax, rotten_randomX
	mov ebx, 10
	mul ebx
	mov rotten_appleX, eax
	
	mov eax, rotten_randomY
	mov ebx, 10
	mul ebx
	mov rotten_appleY, eax
	mov fruit, 0
	sub snakeLength, 1
	jmp snake_update2
	
	
no_snake_update:

 jmp final_draw
 end_of_draw:
	 call EndGame

final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret 
draw endp

start:
	push offset mode_r
	push offset fname
	call fopen
	add esp, 8
	mov pointer, eax
	mov pointer_aux, eax
	push offset HighScore
	push offset format			;;Citim din fisier HighestScore-ul
	push pointer
	call fscanf
	add esp, 12
	push pointer
	call fclose
	add esp, 4


	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	;terminarea programului
	push 0
	call exit
end start
