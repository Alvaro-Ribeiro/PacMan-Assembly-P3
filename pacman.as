;------------------------------------------------------------------------------
; ZONA I: Definicao de constantes
;         Pseudo-instrucao : EQU
;------------------------------------------------------------------------------
CR              EQU     0Ah
FIM_TEXTO       EQU     '@'
IO_READ         EQU     FFFFh
IO_WRITE        EQU     FFFEh
IO_STATUS       EQU     FFFDh
INITIAL_SP      EQU     FDFFh
CURSOR		    EQU     FFFCh
CURSOR_INIT		EQU		FFFFh
RND_MASK	    EQU	    8016h
LSB_MASK	    EQU	    0001h
DIRECAOCIMA     EQU     0d
DIRECAOBAIXO    EQU     1d
DIRECAOESQ      EQU     2d
DIRECAODIR      EQU     3d
NUMDIRECOES     EQU     5d
ON              EQU     1d
OFF             EQU     0d
LINHA_IMPRESSAO_VIDA EQU  23d
DISTANCIA_CORACAO EQU    3d
LINHA_VITORIA   EQU     10d
COLUNA_VITORIA  EQU     29d
LINHA_DERROTA   EQU     10d
COLUNA_DERROTA  EQU     29d
LINHA_PONTUACAO EQU     23d
COLUNA_PONTUACAO EQU    79d
FANTASMA_1      EQU     1d
FANTASMA_2      EQU     2d
FANTASMA_3      EQU     3d
FANTASMA_4      EQU     4d
VALOR_CONVERSAO_ASCII EQU   48d
VALOR_PONTO     EQU     10d
VALOR_MAXIMO_PONTUACAO EQU 4780d
VIDA_ZERADA     EQU     0d
TEMPO_TIMER     EQU     3d
ATIVA_TIMER     EQU     FFF6h
SETA_TEMPO_TIMER EQU     FFF7h
COLUNA_INI_PACMAN EQU   83d



;------------------------------------------------------------------------------
; ZONA II: definicao de variaveis
;          Pseudo-instrucoes : WORD - palavra (16 bits)
;                              STR  - sequencia de caracteres (cada ocupa 1 palavra: 16 bits).
;          Cada caracter ocupa 1 palavra
;------------------------------------------------------------------------------

                ORIG    8000h
L1              STR     'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', FIM_TEXTO
L2              STR     'X C                               ............                                 X', FIM_TEXTO
L3              STR     'X                                ..............                                X', FIM_TEXTO
L4              STR     'XXXX ..... XXXX       .       XXX...XXXXXXXX...XXX       .       XXXX ..... XXXX', FIM_TEXTO
L5              STR     'X     ...     X      ...      XX ...   XX   ... XX      ...      X     ...     X', FIM_TEXTO
L6              STR     'X     ...     X     .....     X  ...   XX   ...  X     .....     X     ...     X', FIM_TEXTO
L7              STR     'X...................................   OO   ...................................X', FIM_TEXTO
L8              STR     'X...................................   OO   ...................................X', FIM_TEXTO
L9              STR     'X     ...     X     .....     X  ...   XX   ...  X     .....     X     ...     X', FIM_TEXTO
L10             STR     'X     ...     X      ...      XX ...   XX   ... XX      ...      X     ...     X', FIM_TEXTO
L11             STR     'XXXX ..... XXXX       .       XXX...XXXXXXXX...XXX       .       XXXX ..... XXXX', FIM_TEXTO
L12             STR     'X                            .......        .......                            X', FIM_TEXTO
L13             STR     'X                            ...                ...                            X', FIM_TEXTO
L14             STR     'X        XXXXXX..XXXXXX      ...                ...      XXXXXX..XXXXXX        X', FIM_TEXTO
L15             STR     'X        X ......     X      .......        .......      X     ...... X        X', FIM_TEXTO
L16             STR     'X ...............     XXXXXXX...XXXXXXXXXXXXXXXX...XXXXXXX     ............... X', FIM_TEXTO
L17             STR     'X ...............            ...       XX       ...            ............... X', FIM_TEXTO
L18             STR     'X        X ......            ...       XX       ...            ...... X        X', FIM_TEXTO
L19             STR     'X        XXXXXX..XXXXXX      ...       XX       ...      XXXXXX..XXXXXX        X', FIM_TEXTO
L20             STR     'X .                   X      ...       XX       ...      X                   . X', FIM_TEXTO
L21             STR     'X .                   XXXXXXX...XXXXXXXXXXXXXXXX...XXXXXXX                   . X', FIM_TEXTO
L22             STR     'X .                          ......................                          . X', FIM_TEXTO
L23             STR     'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '#'
L24             STR     'VIDAS: S2 S2 S2                                                     PONTOS: 0000', '#'

V1              STR     '                      ', FIM_TEXTO
V2              STR     '  ==================  ', FIM_TEXTO
V3              STR     '  || VOCE VENCEU! ||  ', FIM_TEXTO
V4              STR     '  ==================  ', FIM_TEXTO
V5              STR     '                      ', '#'

D1              STR     '                      ', FIM_TEXTO
D2              STR     '  ==================  ', FIM_TEXTO
D3              STR     '  || GAME OVER :( ||  ', FIM_TEXTO
D4              STR     '  ==================  ', FIM_TEXTO
D5              STR     '                      ', '#'

LinhaString     WORD    0d
ColunaString    WORD    0d
Num_Coluna      WORD    0d
EnderecoString  WORD    0d
Caract          WORD    0d
PosicaoPacMan   WORD    0d
PosicaoPacManIni WORD   0d
Pontuacao       WORD    0d
Pontuacao2      WORD    0d
Espaco          WORD    ' '
PosPonto        WORD    0d
Cont            WORD    0d
LinhaPacMan     WORD    1d
ColunaPacMan    WORD    2d
CoordPacMan     WORD    0d
MovDir          WORD    0d
MovEsq          WORD    0d
MovBai          WORD    0d
MovCim          WORD    0d
MovFant1Dir     WORD    0d
MovFant1Esq     WORD    0d
MovFant1Bai     WORD    0d
MovFant1Cim     WORD    0d
MovFant2Dir     WORD    0d
MovFant2Esq     WORD    0d
MovFant2Bai     WORD    0d
MovFant2Cim     WORD    0d
MovFant3Dir     WORD    0d
MovFant3Esq     WORD    0d
MovFant3Bai     WORD    0d
MovFant3Cim     WORD    0d
MovFant4Dir     WORD    0d
MovFant4Esq     WORD    0d
MovFant4Bai     WORD    0d
MovFant4Cim     WORD    0d
Vida            WORD    3d
Num_Vida        WORD    14d
Random_Var	    WORD	A5A5h
PosFant         WORD    0d
PosFant1        WORD    39d
PosFant2        WORD    40d
PosFant3        WORD    39d
PosFant4        WORD    40d
PosIniFant      WORD    0d
PosIniFant1     WORD    39d
PosIniFant2     WORD    40d
PosIniFant3     WORD    39d
PosIniFant4     WORD    40d
CaracterFant    WORD    ' '
CaracterFant1   WORD    ' '
CaracterFant2   WORD    ' '
CaracterFant3   WORD    ' '
CaracterFant4   WORD    ' '
Aleatorio       WORD    0d
NumFant         WORD    0d
RandomF1        WORD    5d
RandomF2        WORD    5d
RandomF3        WORD    5d
RandomF4        WORD    5d

;------------------------------------------------------------------------------
; ZONA II: definicao de tabela de interrupções
;------------------------------------------------------------------------------
                ORIG    FE00h
INT0            WORD    TeclaCim
INT1            WORD    TeclaEsq
INT2            WORD    TeclaBai
INT3            WORD    TeclaDir

                ORIG    FE0Fh
INT15           WORD    Timer

;------------------------------------------------------------------------------
; ZONA IV: codigo
;        conjunto de instrucoes Assembly, ordenadas de forma a realizar
;        as funcoes pretendidas
;------------------------------------------------------------------------------
                ORIG    0000h
                JMP     Main

;------------------------------------------------------------------------------
; Função PrintaMapa
; EnderecoString := Endereco da String que queremos imprimir na tela
; LinhaString    := Linha da tela onde queremos imprimir a String
; ColunaString   := Coluna da tela onde queremos imprimir a String
; Caract         := Caracter que será impresso na fase atual do loop
;------------------------------------------------------------------------------

Reset:          PUSH    R6
                PUSH    R7

                MOV     R6, OFF            ;Para todos os Fantasmas e o Pacman
                MOV     M[MovDir], R6      ;e Reseta a posição do Pacman
                MOV     M[MovBai], R6
                MOV     M[MovEsq], R6
                MOV     M[MovCim], R6
                ;-------------------------
                MOV     M[MovFant1Dir], R6
                MOV     M[MovFant1Esq], R6
                MOV     M[MovFant1Bai], R6
                MOV     M[MovFant1Cim], R6
                ;-------------------------
                MOV     M[MovFant2Dir], R6
                MOV     M[MovFant2Esq], R6
                MOV     M[MovFant2Bai], R6
                MOV     M[MovFant2Cim], R6
                ;-------------------------
                MOV     M[MovFant3Dir], R6
                MOV     M[MovFant3Esq], R6
                MOV     M[MovFant3Bai], R6
                MOV     M[MovFant3Cim], R6
                ;-------------------------
                MOV     M[MovFant4Dir], R6
                MOV     M[MovFant4Esq], R6
                MOV     M[MovFant4Bai], R6
                MOV     M[MovFant4Cim], R6
                ;-------------------------
                MOV     M[RandomF1], R6
                MOV     M[RandomF2], R6
                MOV     M[RandomF3], R6
                MOV     M[RandomF4], R6
                ;-------------------------
                MOV     R6, M[PosFant1]
                MOV     R7, M[CaracterFant1]
                MOV     M[R6], R7
                MOV     R6, M[PosIniFant1]
                MOV     R7, 'O'
                MOV     M[PosFant1], R6
                MOV     M[R6], R7
                ;-------------------------
                MOV     R6, M[PosFant2]
                MOV     R7, M[CaracterFant2]
                MOV     M[R6], R7
                MOV     R6, M[PosIniFant2]
                MOV     R7, 'O'
                MOV     M[PosFant2], R6
                MOV     M[R6], R7
                ;-------------------------
                MOV     R6, M[PosFant3]
                MOV     R7, M[CaracterFant3]
                MOV     M[R6], R7
                MOV     R6, M[PosIniFant3]
                MOV     R7, 'O'
                MOV     M[PosFant3], R6
                MOV     M[R6], R7
                ;-------------------------
                MOV     R6, M[PosFant4]
                MOV     R7, M[CaracterFant4]
                MOV     M[R6], R7
                MOV     R6, M[PosIniFant4]
                MOV     R7, 'O'
                MOV     M[PosFant4], R6
                MOV     M[R6], R7
                ;-------------------------
                MOV     R6, M[PosicaoPacMan]
                MOV     R7, ' '
                MOV     M[R6], R7
                MOV     R7, M[PosicaoPacManIni]
                MOV     M[PosicaoPacMan], R7
                MOV     R6, 'C'
                MOV     M[R7], R6

                CALL    Limpar
                CALL    PrintaMapa

                POP     R6
                POP     R7
                RET

;---------------------------------------------------------

DiminuiVida:    PUSH    R6                   ;Diminui em 1 o número de vidas quando
                PUSH    R7                   ;há colisão com um fantasma

                MOV     R6, M[Vida]
                DEC     R6
                MOV     M[Vida], R6

                MOV     R6, LINHA_IMPRESSAO_VIDA
                MOV     R7, M[Num_Vida]
                SHL     R6, 8d
                OR      R6, R7
                MOV     R7, ' '
                MOV     M[CURSOR], R6
                MOV     M[IO_WRITE], R7

                MOV     R6, LINHA_IMPRESSAO_VIDA
                MOV     R7, M[Num_Vida]
                DEC     R7
                SHL     R6, 8d
                OR      R6, R7
                MOV     R7, ' '
                MOV     M[CURSOR], R6
                MOV     M[IO_WRITE], R7

                MOV     R7, M[Num_Vida]
                SUB     R7, DISTANCIA_CORACAO
                MOV     M[Num_Vida], R7

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

Limpar:         PUSH    R1                        ;Prepara as variáveis para
                                                  ;printar o mapa (reseta linha e coluna pra 0)
                MOV     R1, L1
                MOV     M[ EnderecoString ], R1
                MOV     R1, 0d
                MOV     M[LinhaString], R1
                MOV     M[ColunaString], R1
                MOV     M[Num_Coluna], R1

                POP     R1
                RET

;-------------------------------------------------------------

LimparVit:      PUSH    R1                          ;Prepara as variáveis para
                                                    ;printar a caixa de vitória
                MOV     R1, V1                      ;(Coloca linha e coluna certas)
                MOV     M[ EnderecoString ], R1
                MOV     R1, LINHA_VITORIA
                MOV     M[LinhaString], R1
                MOV     R1, COLUNA_VITORIA
                MOV     M[ColunaString], R1
                MOV     M[Num_Coluna], R1

                POP     R1
                RET

;-------------------------------------------------------------

LimparDer:      PUSH    R1                          ;Prepara as variáveis para
                                                    ;printar a caixa de vitória

                MOV     R1, D1
                MOV     M[ EnderecoString ], R1
                MOV     R1, LINHA_DERROTA
                MOV     M[LinhaString], R1
                MOV     R1, COLUNA_DERROTA
                MOV     M[ColunaString], R1
                MOV     M[Num_Coluna], R1

                POP     R1
                RET

;-------------------------------------------------------------

PrintaLinha:    PUSH    R1                      ;Printa a linha de vida e pontuação
                PUSH    R2
                PUSH    R3

                MOV     R1, L24
                MOV     R2, M[R1]
                MOV     R3, 0d

CicloLinha:     CMP     R2,'#'
                JMP.Z   FimLinha

                MOV     R2, LINHA_PONTUACAO
                SHL     R2, 8d
                OR      R2, R3
                MOV     M[CURSOR], R2
                MOV     R2, M[R1]
                MOV     M[IO_WRITE], R2
                INC     R3
                INC     R1
                JMP     CicloLinha

FimLinha:       POP     R1
                POP     R2
                POP     R3
                RET

;-------------------------------------------------------------

PrintaMapa:     PUSH    R6                              ;Printa o mapa inteiro
                PUSH    R7

CicloMapa:      MOV     R6, M[EnderecoString]
                MOV     R6, M[R6]
                MOV     M[Caract], R6
                CMP     R6, FIM_TEXTO
                JMP.Z   PularLinha
                CMP     R6, '#'
                JMP.Z   FimCicloMapa
                MOV     R7, M[LinhaString]
                MOV     R6, M[ColunaString]
                SHL     R7, 8d
                OR      R7, R6
                MOV     R6, M[Caract]
                MOV     M[CURSOR], R7
                MOV     M[IO_WRITE], R6
                INC     M[ColunaString]
                INC     M[EnderecoString]
                JMP     CicloMapa

PularLinha:     INC     M[EnderecoString]
                INC     M[LinhaString]
                MOV     R6, M[Num_Coluna]
                MOV     M[ColunaString], R6
                JMP     CicloMapa

FimCicloMapa:   POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

MudaDirecao:    PUSH    R6                  ;Muda a direção do fantasma quando bate
                PUSH    R7                  ;na parede

                MOV     R6, M[NumFant]

                MOV     R7, M[Aleatorio]

                CMP     R6, FANTASMA_1
                JMP.Z  MudaF1
                CMP     R6, FANTASMA_2
                JMP.Z  MudaF2
                CMP     R6, FANTASMA_3
                JMP.Z  MudaF3
                CMP     R6, FANTASMA_4
                JMP.Z  MudaF4

MudaF1:         MOV     M[RandomF1], R7
                CALL    F1
                JMP     FimMudaDir

MudaF2:         MOV     M[RandomF2], R7
                CALL    F2
                JMP     FimMudaDir

MudaF3:         MOV     M[RandomF3], R7
                CALL    F3
                JMP     FimMudaDir

MudaF4:         MOV     M[RandomF4], R7
                CALL    F4
                JMP     FimMudaDir

FimMudaDir:     POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

FantasmaEsq:    PUSH    R1                          ;Move fantasma pra esquerda
                PUSH    R2                          ;Serve pra todos os fantasmas

                MOV     R1, M[PosFant]
                DEC     R1              ; Diminui 1 na posicao para andar pra esquerda
                MOV     R1, M[R1]
                CMP     R1, 'X'
                JMP.Z   MudaEsq
                CMP     R1, 'O'
                JMP.Z   MudaEsq
                CMP     R1, 'C'
                JMP.NZ  CaractFantEsq
                CALL    DiminuiVida
                MOV     R1, M[PosFant]
                MOV     R2, M[CaracterFant]
                MOV     M[R1], R2
                MOV     R2, M[PosIniFant]
                MOV     M[PosFant], R2
                CALL    Reset
                JMP     FimFantEsq

CaractFantEsq:  MOV     R1, M[PosFant]
                MOV     R2, M[CaracterFant]
                MOV     M[R1], R2
                MOV     R1, M[PosFant]
                DEC     R1
                MOV     M[PosFant], R1
                MOV     R2, M[R1]
                MOV     M[CaracterFant], R2
                MOV     R2, 'O'
                MOV     M[R1], R2
                CALL    Limpar
                CALL    PrintaMapa
                JMP     FimFantEsq

MudaEsq:        CALL    MudaDirecao

FimFantEsq:     POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

FantasmaDir:    PUSH    R1                          ;Move fantasma pra direita
                PUSH    R2                          ;Serve pra todos os fantasmas

                MOV     R1, M[PosFant]
                INC     R1              ; Aumenta 1 na posicao para andar pra direita
                MOV     R1, M[R1]
                CMP     R1, 'X'
                JMP.Z   MudaDir
                CMP     R1, 'O'
                JMP.Z   MudaDir
                CMP     R1, 'C'
                JMP.NZ  CaractFantDir
                CALL    DiminuiVida
                MOV     R1, M[PosFant]
                MOV     R2, M[CaracterFant]
                MOV     M[R1], R2
                MOV     R2, M[PosIniFant]
                MOV     M[PosFant], R2
                CALL    Reset
                JMP     FimFantDir

CaractFantDir:  MOV     R1, M[PosFant]
                MOV     R2, M[CaracterFant]
                MOV     M[R1], R2
                MOV     R1, M[PosFant]
                INC     R1
                MOV     M[PosFant], R1
                MOV     R2, M[R1]
                MOV     M[CaracterFant], R2
                MOV     R2, 'O'
                MOV     M[R1], R2
                CALL    Limpar
                CALL    PrintaMapa
                JMP     FimFantDir

MudaDir:        CALL    MudaDirecao


FimFantDir:     POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

FantasmaBai:    PUSH    R1                          ;Move fantasma pra baixo
                PUSH    R2                          ;Serve pra todos os fantasmas

                MOV     R1, M[PosFant]
                ADD     R1, 81d ; 81 é a quantidade que deve somar para andar pra baixo
                MOV     R1, M[R1]
                CMP     R1, 'X'
                JMP.Z   MudaBai
                CMP     R1, 'O'
                JMP.Z   MudaBai
                CMP     R1, 'C'
                JMP.NZ  CaractFantBai
                CALL    DiminuiVida
                MOV     R1, M[PosFant]
                MOV     R2, M[CaracterFant]
                MOV     M[R1], R2
                MOV     R2, M[PosIniFant]
                MOV     M[PosFant], R2
                CALL    Reset
                JMP     FimFantBai

CaractFantBai:  MOV     R1, M[PosFant]
                MOV     R2, M[CaracterFant]
                MOV     M[R1], R2
                MOV     R1, M[PosFant]
                MOV     R2, 81d
                ADD     R1, R2
                MOV     M[PosFant], R1
                MOV     R2, M[R1]
                MOV     M[CaracterFant], R2
                MOV     R2, 'O'
                MOV     M[R1], R2
                CALL    Limpar
                CALL    PrintaMapa
                JMP     FimFantBai

MudaBai:        CALL    MudaDirecao


FimFantBai:     POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

FantasmaCim:    PUSH    R1                          ;Move fantasma pra cima
                PUSH    R2                          ;Serve pra todos os fantasmas

                MOV     R1, M[PosFant]
                SUB     R1, 81d ; 81 é a quantidade que deve subtrair para andar pra cima
                MOV     R1, M[R1]
                CMP     R1, 'X'
                JMP.Z   MudaCim
                CMP     R1, 'O'
                JMP.Z   MudaCim
                CMP     R1, 'C'
                JMP.NZ  CaractFantCim
                CALL    DiminuiVida
                MOV     R1, M[PosFant]
                MOV     R2, M[CaracterFant]
                MOV     M[R1], R2
                MOV     R2, M[PosIniFant]
                MOV     M[PosFant], R2
                CALL    Reset
                JMP     FimFantCim

CaractFantCim:  MOV     R1, M[PosFant]
                MOV     R2, M[CaracterFant]
                MOV     M[R1], R2
                MOV     R1, M[PosFant]
                MOV     R2, 81d
                SUB     R1, R2
                MOV     M[PosFant], R1
                MOV     R2, M[R1]
                MOV     M[CaracterFant], R2
                MOV     R2, 'O'
                MOV     M[R1], R2
                CALL    Limpar
                CALL    PrintaMapa
                JMP     FimFantCim

MudaCim:        CALL    MudaDirecao


FimFantCim:     POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

PacManDir:      PUSH    R1                              ;Move o PacMan pra Direita
                PUSH    R2

                MOV     R1, M[PosicaoPacMan]
                INC     R1                  ; Aumenta 1 na posicao para andar pra direita
                MOV     R1, M[R1]
                CMP     R1, 'X'
                JMP.Z   FimPacManDir
                CMP     R1, 'O'
                JMP.NZ  ContDir
                CALL    DiminuiVida
                CALL    Reset
                JMP     FimPacManDir

ContDir:        CMP     R1, '.'
                JMP.NZ  EspacoVazioDir
                MOV     R2, M[Pontuacao]
                ADD     R2, VALOR_PONTO
                MOV     M[Pontuacao], R2
                CALL    Ponto

EspacoVazioDir: MOV     R1, ' '
                MOV     R2, M[PosicaoPacMan]
                MOV     M[R2], R1
                INC     M[PosicaoPacMan]
                MOV     R1, M[PosicaoPacMan]
                MOV     R2, 'C'
                MOV     M[R1], R2

                CALL    Limpar
                CALL    PrintaMapa

FimPacManDir:   POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

PacManEsq:      PUSH    R1                              ;Move o PacMan pra Esquerda
                PUSH    R2

                MOV     R1, M[PosicaoPacMan]
                DEC     R1              ; Aumenta 1 na posicao para andar pra direita
                MOV     R1, M[R1]
                CMP     R1, 'X'
                JMP.Z   FimPacManEsq
                CMP     R1, 'O'
                JMP.NZ  ContEsq
                CALL    DiminuiVida
                CALL    Reset
                JMP     FimPacManEsq

ContEsq:        CMP     R1, '.'
                JMP.NZ  EspacoVazioEsq
                MOV     R2, M[Pontuacao]
                ADD     R2, VALOR_PONTO
                MOV     M[Pontuacao], R2
                CALL    Ponto

EspacoVazioEsq: MOV     R1, ' '
                MOV     R2, M[PosicaoPacMan]
                MOV     M[R2], R1
                DEC     M[PosicaoPacMan]
                MOV     R1, M[PosicaoPacMan]
                MOV     R2, 'C'
                MOV     M[R1], R2

                CALL    Limpar
                CALL    PrintaMapa

FimPacManEsq:   POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

PacManBai:      PUSH    R1                              ;Move o PacMan pra Baixo
                PUSH    R2

                MOV     R1, M[PosicaoPacMan]
                ADD     R1, 81d             ;81 é o valor que deve somar para andar para cima
                MOV     R1, M[R1]
                CMP     R1, 'X'
                JMP.Z   FimPacManBai
                CMP     R1, 'O'
                JMP.NZ  ContBai
                CALL    DiminuiVida
                CALL    Reset
                JMP     FimPacManBai

ContBai:        CMP     R1, '.'
                JMP.NZ  EspacoVazioBai
                MOV     R2, M[Pontuacao]
                ADD     R2, VALOR_PONTO
                MOV     M[Pontuacao], R2
                CALL    Ponto

EspacoVazioBai: MOV     R1, ' '
                MOV     R2, M[PosicaoPacMan]
                MOV     M[R2], R1
                MOV     R1, 81d
                ADD     M[PosicaoPacMan], R1
                MOV     R1, M[PosicaoPacMan]
                MOV     R2, 'C'
                MOV     M[R1], R2

                CALL    Limpar
                CALL    PrintaMapa

FimPacManBai:   POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

PacManCim:      PUSH    R1                              ;Move o PacMan pra Cima
                PUSH    R2

                MOV     R1, M[PosicaoPacMan]
                MOV     R2, 'C'
                SUB     R1, 81d             ;81 é o valor que deve subtrair para andar para cima
                MOV     R1, M[R1]
                CMP     R1, 'X'
                JMP.Z   FimPacManCim
                CMP     R1, 'O'
                JMP.NZ  ContCim
                CALL    DiminuiVida
                CALL    Reset
                JMP     FimPacManCim

ContCim:        CMP     R1, '.'
                JMP.NZ  EspacoVazioCim
                MOV     R2, M[Pontuacao]
                ADD     R2, VALOR_PONTO
                MOV     M[Pontuacao], R2
                CALL    Ponto

EspacoVazioCim: MOV     R1, ' '
                MOV     R2, M[PosicaoPacMan]
                MOV     M[R2], R1
                MOV     R1, 81d
                SUB     M[PosicaoPacMan], R1
                MOV     R1, M[PosicaoPacMan]
                MOV     R2, 'C'
                MOV     M[R1], R2

                CALL    Limpar
                CALL    PrintaMapa

FimPacManCim:   POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

Ponto:          PUSH    R1                      ;Converte os pontos de int pra caracter
                PUSH    R2                      ;printando diretamente na tela
                PUSH    R3
                PUSH    R4

                MOV     R4, COLUNA_PONTUACAO
                MOV     R1, M[Pontuacao]

CicloPonto:     CMP     R1, 0d
                JMP.Z   FimPonto
                MOV     R2, 10d
                DIV     R1, R2

                MOV     R3, LINHA_PONTUACAO
                SHL     R3, 8d
                OR      R3, R4
                DEC     R4
                MOV     M[CURSOR], R3
                ADD     R2, VALOR_CONVERSAO_ASCII
                MOV     M[IO_WRITE], R2

                JMP     CicloPonto

FimPonto:       POP     R1
                POP     R2
                POP     R3
                POP     R4
                RET

;-------------------------------------------------------------

TeclaDir:       PUSH    R1                  ;Interrupção - tecla que move
                PUSH    R2                  ;o PacMan pra direita

                MOV     R1, ON
                MOV     R2, OFF

                MOV     M[MovDir], R1
                MOV     M[MovEsq], R2
                MOV     M[MovBai], R2
                MOV     M[MovCim], R2

                MOV     R1, DIRECAODIR
                MOV     M[RandomF1], R1
                MOV     M[RandomF2], R1
                MOV     M[RandomF3], R1
                MOV     M[RandomF4], R1

                POP     R1
                POP     R2
                RTI

;-------------------------------------------------------------

TeclaEsq:       PUSH    R1                  ;Interrupção - tecla que move
                PUSH    R2                  ;o PacMan pra esquerda

                MOV     R1, ON
                MOV     R2, OFF

                MOV     M[MovDir], R2
                MOV     M[MovEsq], R1
                MOV     M[MovBai], R2
                MOV     M[MovCim], R2

                MOV     R1, DIRECAOESQ
                MOV     M[RandomF1], R1
                MOV     M[RandomF2], R1
                MOV     M[RandomF3], R1
                MOV     M[RandomF4], R1

                POP     R1
                POP     R2
                RTI

;-------------------------------------------------------------

TeclaBai:       PUSH    R1                  ;Interrupção - tecla que move
                PUSH    R2                  ;o PacMan pra baixo

                MOV     R1, ON
                MOV     R2, OFF

                MOV     M[MovDir], R2
                MOV     M[MovEsq], R2
                MOV     M[MovBai], R1
                MOV     M[MovCim], R2

                MOV     R1, DIRECAOBAIXO
                MOV     M[RandomF1], R1
                MOV     M[RandomF2], R1
                MOV     M[RandomF3], R1
                MOV     M[RandomF4], R1

                POP     R1
                POP     R2
                RTI

;-------------------------------------------------------------

TeclaCim:       PUSH    R1                  ;Interrupção - tecla que move
                PUSH    R2                  ;o PacMan pra cima

                MOV     R1, ON
                MOV     R2, OFF

                MOV     M[MovDir], R2
                MOV     M[MovEsq], R2
                MOV     M[MovBai], R2
                MOV     M[MovCim], R1

                MOV     R1, DIRECAOCIMA
                MOV     M[RandomF1], R1
                MOV     M[RandomF2], R1
                MOV     M[RandomF3], R1
                MOV     M[RandomF4], R1

                POP     R1
                POP     R2
                RTI

;------------------------------------------------------------

Vitoria:        PUSH    R1                           ;Testa se a pontuacao maxima foi atingida
                MOV     R1, M[Pontuacao]             ;ou seja, se todos os pontos foram comidos
                CMP     R1, VALOR_MAXIMO_PONTUACAO
                JMP.NZ  FimVitoria
                CALL    LimparVit
                CALL    PrintaMapa
                JMP     Halt

FimVitoria:     POP     R1
                RET

;-------------------------------------------------------------

Derrota:        PUSH    R1                         ;Testa se as vidas foram esgotadas
                MOV     R1, M[Vida]
                CMP     R1, VIDA_ZERADA
                JMP.NZ  FimDerrota
                CALL    LimparDer
                CALL    PrintaMapa
                JMP     Halt

FimDerrota:     POP     R1
                RET

;--------------------------------------------------------------

F1Esq:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para a esquerda passando as informacoes
                                                ;do Fantasma 1
                MOV     R1, FANTASMA_1
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant1]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant1]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant1]
                MOV     M[CaracterFant], R1
                CALL    FantasmaEsq
                MOV     R1, M[PosFant]
                MOV     M[PosFant1], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant1], R1
                
                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F1Dir:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para a direita passando as informacoes
                                                ;do Fantasma 1

                MOV     R1, FANTASMA_1
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant1]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant1]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant1]
                MOV     M[CaracterFant], R1
                CALL    FantasmaDir
                MOV     R1, M[PosFant]
                MOV     M[PosFant1], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant1], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F1Cim:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para cima passando as informacoes
                                                ;do Fantasma 1

                MOV     R1, FANTASMA_1
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant1]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant1]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant1]
                MOV     M[CaracterFant], R1
                CALL    FantasmaCim
                MOV     R1, M[PosFant]
                MOV     M[PosFant1], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant1], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F1Bai:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para baixo passando as informacoes
                                                ;do Fantasma 1

                MOV     R1, FANTASMA_1
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant1]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant1]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant1]
                MOV     M[CaracterFant], R1
                CALL    FantasmaBai
                MOV     R1, M[PosFant]
                MOV     M[PosFant1], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant1], R1

                POP     R6
                POP     R7
                RET

;--------------------------------------------------------------

F2Esq:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para a esquerda passando as informacoes
                                                ;do Fantasma 2

                MOV     R1, FANTASMA_2
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant2]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant2]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant2]
                MOV     M[CaracterFant], R1
                CALL    FantasmaEsq
                MOV     R1, M[PosFant]
                MOV     M[PosFant2], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant2], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F2Dir:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para a direita passando as informacoes
                                                ;do Fantasma 2

                MOV     R1, FANTASMA_2
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant2]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant2]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant2]
                MOV     M[CaracterFant], R1
                CALL    FantasmaDir
                MOV     R1, M[PosFant]
                MOV     M[PosFant2], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant2], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F2Cim:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para cima passando as informacoes
                                                ;do Fantasma 2

                MOV     R1, FANTASMA_2
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant2]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant2]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant2]
                MOV     M[CaracterFant], R1
                CALL    FantasmaCim
                MOV     R1, M[PosFant]
                MOV     M[PosFant2], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant2], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F2Bai:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para baixo passando as informacoes
                                                ;do Fantasma 2

                MOV     R1, FANTASMA_2
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant2]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant2]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant2]
                MOV     M[CaracterFant], R1
                CALL    FantasmaBai
                MOV     R1, M[PosFant]
                MOV     M[PosFant2], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant2], R1

                POP     R6
                POP     R7
                RET

;--------------------------------------------------------------

F3Esq:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para a esquerda passando as informacoes
                                                ;do Fantasma 3

                MOV     R1, FANTASMA_3
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant3]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant3]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant3]
                MOV     M[CaracterFant], R1
                CALL    FantasmaEsq
                MOV     R1, M[PosFant]
                MOV     M[PosFant3], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant3], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F3Dir:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para a direita passando as informacoes
                                                ;do Fantasma 3

                MOV     R1, FANTASMA_3
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant3]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant3]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant3]
                MOV     M[CaracterFant], R1
                CALL    FantasmaDir
                MOV     R1, M[PosFant]
                MOV     M[PosFant3], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant3], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F3Cim:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para cima passando as informacoes
                                                ;do Fantasma 3

                MOV     R1, FANTASMA_3
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant3]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant3]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant3]
                MOV     M[CaracterFant], R1
                CALL    FantasmaCim
                MOV     R1, M[PosFant]
                MOV     M[PosFant3], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant3], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F3Bai:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para baixo passando as informacoes
                                                ;do Fantasma 3

                MOV     R1, FANTASMA_3
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant3]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant3]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant3]
                MOV     M[CaracterFant], R1
                CALL    FantasmaBai
                MOV     R1, M[PosFant]
                MOV     M[PosFant3], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant3], R1

                POP     R6
                POP     R7
                RET

;--------------------------------------------------------------

F4Esq:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para a esquerda passando as informacoes
                                                ;do Fantasma 4

                MOV     R1, FANTASMA_4
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant4]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant4]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant4]
                MOV     M[CaracterFant], R1
                CALL    FantasmaEsq
                MOV     R1, M[PosFant]
                MOV     M[PosFant4], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant4], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F4Dir:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para a direita passando as informacoes
                                                ;do Fantasma 4

                MOV     R1, FANTASMA_4
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant4]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant4]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant4]
                MOV     M[CaracterFant], R1
                CALL    FantasmaDir
                MOV     R1, M[PosFant]
                MOV     M[PosFant4], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant4], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F4Cim:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para cima passando as informacoes
                                                ;do Fantasma 4

                MOV     R1, FANTASMA_4
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant4]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant4]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant4]
                MOV     M[CaracterFant], R1
                CALL    FantasmaCim
                MOV     R1, M[PosFant]
                MOV     M[PosFant4], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant4], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F4Bai:          PUSH    R6                      ;Chama a função de mover o fantasma
                PUSH    R7                      ;para baixo passando as informacoes
                                                ;do Fantasma 1

                MOV     R1, FANTASMA_4
                MOV     M[NumFant], R1

                MOV     R1, M[PosIniFant4]
                MOV     M[PosIniFant], R1
                MOV     R1, M[PosFant4]
                MOV     M[PosFant], R1
                MOV     R1, M[CaracterFant4]
                MOV     M[CaracterFant], R1
                CALL    FantasmaBai
                MOV     R1, M[PosFant]
                MOV     M[PosFant4], R1
                MOV     R1, M[CaracterFant]
                MOV     M[CaracterFant4], R1

                POP     R6
                POP     R7
                RET

;-------------------------------------------------------------

F1:             PUSH    R1                  ;Move o Fantasma 1 baseado no movimento
                PUSH    R2                  ;do pacman

                MOV     R1, M[RandomF1]

                ;---------Esq-----------
                CMP     R1, 4d
                JMP.Z   F1E
                CMP     R1, 1d
                JMP.Z   F1D
                CMP     R1, 2d
                JMP.Z   F1C
                CMP     R1, 3d
                JMP.Z   F1B
                JMP     FimF1



F1D:            MOV     R2, ON
                MOV     M[MovFant1Dir], R2
                MOV     R2, OFF
                MOV     M[MovFant1Esq], R2
                MOV     M[MovFant1Bai], R2
                MOV     M[MovFant1Cim], R2
                JMP     FimF1

F1C:            MOV     R2, ON
                MOV     M[MovFant1Cim], R2
                MOV     R2, OFF
                MOV     M[MovFant1Dir], R2
                MOV     M[MovFant1Bai], R2
                MOV     M[MovFant1Esq], R2
                JMP     FimF1

F1B:            MOV     R2, ON
                MOV     M[MovFant1Bai], R2
                MOV     R2, OFF
                MOV     M[MovFant1Dir], R2
                MOV     M[MovFant1Esq], R2
                MOV     M[MovFant1Cim], R2
                JMP     FimF1

F1E:            MOV     R2, ON
                MOV     M[MovFant1Esq], R2
                MOV     R2, OFF
                MOV     M[MovFant1Dir], R2
                MOV     M[MovFant1Bai], R2
                MOV     M[MovFant1Cim], R2
                JMP     FimF1

FimF1:          POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

F2:             PUSH    R1                  ;Move o Fantasma 2 baseado no movimento
                PUSH    R2                  ;do pacman

                MOV     R1, M[RandomF2]

                ;---------Esq-----------
                CMP     R1, 2d
                JMP.Z   F2E
                CMP     R1, 3d
                JMP.Z   F2D
                CMP     R1, 1d
                JMP.Z   F2C
                CMP     R1, 4d
                JMP.Z   F2B
                JMP     FimF2


F2E:            MOV     R2, ON
                MOV     M[MovFant2Esq], R2
                MOV     R2, OFF
                MOV     M[MovFant2Dir], R2
                MOV     M[MovFant2Bai], R2
                MOV     M[MovFant2Cim], R2
                JMP     FimF2

F2D:            MOV     R2, ON
                MOV     M[MovFant2Dir], R2
                MOV     R2, OFF
                MOV     M[MovFant2Esq], R2
                MOV     M[MovFant2Bai], R2
                MOV     M[MovFant2Cim], R2
                JMP     FimF2

F2C:            MOV     R2, ON
                MOV     M[MovFant2Cim], R2
                MOV     R2, OFF
                MOV     M[MovFant2Dir], R2
                MOV     M[MovFant2Bai], R2
                MOV     M[MovFant2Esq], R2
                JMP     FimF2

F2B:            MOV     R2, ON
                MOV     M[MovFant2Bai], R2
                MOV     R2, OFF
                MOV     M[MovFant2Dir], R2
                MOV     M[MovFant2Esq], R2
                MOV     M[MovFant2Cim], R2
                JMP     FimF2

FimF2:          POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

F3:             PUSH    R1                  ;Move o Fantasma 3 baseado no movimento
                PUSH    R2                  ;do pacman

                MOV     R1, M[RandomF3]

                ;---------Esq-----------
                CMP     R1, 3d
                JMP.Z   F3E
                CMP     R1, 2d
                JMP.Z   F3D
                CMP     R1, 1d
                JMP.Z   F3C
                CMP     R1, 4d
                JMP.Z   F3B
                JMP     FimF3


F3E:            MOV     R2, ON
                MOV     M[MovFant3Esq], R2
                MOV     R2, OFF
                MOV     M[MovFant3Dir], R2
                MOV     M[MovFant3Bai], R2
                MOV     M[MovFant3Cim], R2
                JMP     FimF3

F3D:            MOV     R2, ON
                MOV     M[MovFant3Dir], R2
                MOV     R2, OFF
                MOV     M[MovFant3Esq], R2
                MOV     M[MovFant3Bai], R2
                MOV     M[MovFant3Cim], R2
                JMP     FimF3

F3C:            MOV     R2, ON
                MOV     M[MovFant3Cim], R2
                MOV     R2, OFF
                MOV     M[MovFant3Dir], R2
                MOV     M[MovFant3Bai], R2
                MOV     M[MovFant3Esq], R2
                JMP     FimF3

F3B:            MOV     R2, ON
                MOV     M[MovFant3Bai], R2
                MOV     R2, OFF
                MOV     M[MovFant3Dir], R2
                MOV     M[MovFant3Esq], R2
                MOV     M[MovFant3Cim], R2
                JMP     FimF3

FimF3:          POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

F4:             PUSH    R1                  ;Move o Fantasma 4 baseado no movimento
                PUSH    R2                  ;do pacman

                MOV     R1, M[RandomF4]

                ;---------Esq-----------
                CMP     R1, 1d
                JMP.Z   F4E
                CMP     R1, 4d
                JMP.Z   F4D
                CMP     R1, 3d
                JMP.Z   F4C
                CMP     R1, 2d
                JMP.Z   F4B
                JMP     FimF4


F4E:            MOV     R2, ON
                MOV     M[MovFant4Esq], R2
                MOV     R2, OFF
                MOV     M[MovFant4Dir], R2
                MOV     M[MovFant4Bai], R2
                MOV     M[MovFant4Cim], R2
                JMP     FimF4

F4D:            MOV     R2, ON
                MOV     M[MovFant4Dir], R2
                MOV     R2, OFF
                MOV     M[MovFant4Esq], R2
                MOV     M[MovFant4Bai], R2
                MOV     M[MovFant4Cim], R2
                JMP     FimF4

F4C:            MOV     R2, ON
                MOV     M[MovFant4Cim], R2
                MOV     R2, OFF
                MOV     M[MovFant4Dir], R2
                MOV     M[MovFant4Bai], R2
                MOV     M[MovFant4Esq], R2
                JMP     FimF4

F4B:            MOV     R2, ON
                MOV     M[MovFant4Bai], R2
                MOV     R2, OFF
                MOV     M[MovFant4Dir], R2
                MOV     M[MovFant4Esq], R2
                MOV     M[MovFant4Cim], R2
                JMP     FimF4

FimF4:          POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

Timer:          PUSH    R1                  ; Funcao que verifica interrupcoes a cada
                                            ; intervalo de 300ms
                CALL    Vitoria
                CALL    Derrota

                ;----------PacMan------------ Verifica movimento do Pacman

                MOV     R1, M[MovDir]
                CMP     R1, ON
                CALL.Z  PacManDir

                MOV     R1, M[MovEsq]
                CMP     R1, ON
                CALL.Z  PacManEsq

                MOV     R1, M[MovBai]
                CMP     R1, ON
                CALL.Z  PacManBai

                MOV     R1, M[MovCim]
                CMP     R1, ON
                CALL.Z  PacManCim

                ;--------Fantasmas----------- Verifica movimento dos fantasmas

                CALL    Random

                CALL    F1
                CALL    F2
                CALL    F3
                CALL    F4

                ;--------Fantasma 1----------

                MOV     R1, M[MovFant1Esq]
                CMP     R1, ON
                CALL.Z  F1Esq

                MOV     R1, M[MovFant1Dir]
                CMP     R1, ON
                CALL.Z  F1Dir

                MOV     R1, M[MovFant1Cim]
                CMP     R1, ON
                CALL.Z  F1Cim

                MOV     R1, M[MovFant1Bai]
                CMP     R1, ON
                CALL.Z  F1Bai

                ;--------Fantasma 2----------

                MOV     R1, M[MovFant2Esq]
                CMP     R1, ON
                CALL.Z  F2Esq

                MOV     R1, M[MovFant2Dir]
                CMP     R1, ON
                CALL.Z  F2Dir

                MOV     R1, M[MovFant2Cim]
                CMP     R1, ON
                CALL.Z  F2Cim

                MOV     R1, M[MovFant2Bai]
                CMP     R1, ON
                CALL.Z  F2Bai

                ;--------Fantasma 3----------

                MOV     R1, M[MovFant3Esq]
                CMP     R1, ON
                CALL.Z  F3Esq

                MOV     R1, M[MovFant3Dir]
                CMP     R1, ON
                CALL.Z  F3Dir

                MOV     R1, M[MovFant3Cim]
                CMP     R1, ON
                CALL.Z  F3Cim

                MOV     R1, M[MovFant3Bai]
                CMP     R1, ON
                CALL.Z  F3Bai


                ;--------Fantasma 4----------

                MOV     R1, M[MovFant4Esq]
                CMP     R1, ON
                CALL.Z  F4Esq

                MOV     R1, M[MovFant4Dir]
                CMP     R1, ON
                CALL.Z  F4Dir

                MOV     R1, M[MovFant4Cim]
                CMP     R1, ON
                CALL.Z  F4Cim

                MOV     R1, M[MovFant4Bai]
                CMP     R1, ON
                CALL.Z  F4Bai

                CALL    SetTimer

                POP     R1
                RTI

;-------------------------------------------------------------

SetTimer:       PUSH    R1                      ; Funcao que inicializa o temporizador
                PUSH    R2

                MOV     R1, ON
                MOV     R2, TEMPO_TIMER

                MOV     M[ATIVA_TIMER], R1
                MOV     M[SETA_TEMPO_TIMER], R2

                POP     R1
                POP     R2
                RET

;-------------------------------------------------------------

Random:	        PUSH	R1                 ; Funcao para gerar numero aleatorio
                PUSH    R2

        		MOV	    R1, LSB_MASK
        		AND	    R1, M[Random_Var]
        		BR.Z	Rnd_Rotate
        		MOV	    R1, RND_MASK
        		XOR	    M[Random_Var], R1
Rnd_Rotate:	    ROR	    M[Random_Var], 1

                MOV     R2, NUMDIRECOES
                MOV     R1, M[Random_Var]
                DIV     R1, R2
                MOV     M[Aleatorio], R2
		        POP	    R1
                POP     R2
		        RET

;------------------------------------------------------------------------------
; Função Main
;------------------------------------------------------------------------------

Main:           ENI

				MOV		R1, INITIAL_SP
				MOV		SP, R1		 		; We need to initialize the stack
				MOV		R1, CURSOR_INIT		; We need to initialize the cursor
				MOV		M[ CURSOR ], R1		; with value CURSOR_INIT

                MOV     R1, L1
                MOV     M[ EnderecoString ], R1
                ADD     R1, COLUNA_INI_PACMAN
                MOV     M[PosicaoPacManIni], R1
                MOV     M[PosicaoPacMan], R1

                MOV     R1, M[PosFant1]
                ADD     R1, L7
                MOV     M[PosIniFant1], R1
                MOV     M[PosFant1], R1

                MOV     R1, M[PosFant2]
                ADD     R1, L7
                MOV     M[PosIniFant2], R1
                MOV     M[PosFant2], R1

                MOV     R1, M[PosFant3]
                ADD     R1, L8
                MOV     M[PosIniFant3], R1
                MOV     M[PosFant3], R1

                MOV     R1, M[PosFant4]
                ADD     R1, L8
                MOV     M[PosIniFant4], R1
                MOV     M[PosFant4], R1

                CALL    Limpar
                CALL    PrintaMapa
                CALL    PrintaLinha
                CALL    SetTimer

Cycle:          BR		Cycle
Halt:           BR		Halt
