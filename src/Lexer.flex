import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Numero = 0 | [1-9][0-9]*

/* Numero decimal */
NumeroDecimal = [0-9]*"."[0-9]+

/* Numero color*/
NumeroColor = [0-9]{1,3}
%%

/* Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }

/*Texto*/
\".*\" {return token(yytext(), "Texto", yyline, yycolumn);}

/* Identificador */
\${Identificador} {return token(yytext(), "Identificador", yyline, yycolumn);}

/* Tipos de dato */
int | bigInt | real | bigReal | text | color | bool  {return token(yytext(), "Tipo_Dato", yyline, yycolumn);}

/* Numero */
{Numero} {return token(yytext(), "Numero", yyline, yycolumn);}

/* Numero decimal */

{NumeroDecimal} {return token(yytext(), "Numero_Decimal", yyline, yycolumn);}

/* Numero color*/

/* Colores */
"("{NumeroColor}","{NumeroColor}","{NumeroColor}")" {return token(yytext(), "COLOR", yyline, yycolumn);}

/* Operadores de agrupacion */ 
"(" {return token(yytext(), "Parentesis_A", yyline, yycolumn);}
")" {return token(yytext(), "Parentesis_C", yyline, yycolumn);}
"{" {return token(yytext(), "Llave_A", yyline, yycolumn);}
"}" {return token(yytext(), "Llave_C", yyline, yycolumn);}
"[" {return token(yytext(), "Corchete_A", yyline, yycolumn);}
"]" {return token(yytext(), "Corchete_C", yyline, yycolumn);}

/* Operadores logicos */
"&" | "|" | "!" {return token(yytext(), "Operador_Logico", yyline, yycolumn);}

/* Operadores relacionales */

"==" | "!=" | "<" | ">" | "<=" | ">=" {return token(yytext(), "Operador_Relacional", yyline, yycolumn);}

/* Signos de puntuacion*/
"," {return token(yytext(), "Coma", yyline, yycolumn);}
";" {return token(yytext(), "Punto_Coma", yyline, yycolumn);}

/* Operadores aritmeticos */

"*" | "/" | "+" | "-" | "^" | "%" {return token(yytext(), "Operador_Aritmetico", yyline, yycolumn);}

/* Operador asignacion*/

"=" {return token(yytext(), "Operador_Asignacion", yyline, yycolumn);}

/* Asignacion compuesta */

"+=" | "-=" | "*=" | "/=" | "^=" | "%=" {return token(yytext(), "Operador_Compuesto", yyline, yycolumn);} 

/* Palabras reservadas */
MainPlane {return token(yytext(), "Main", yyline, yycolumn);}
function {return token(yytext(), "Function", yyline, yycolumn);}
clear {return token(yytext(), "Clear", yyline, yycolumn);}
return {return token(yytext(), "Return", yyline, yycolumn);}
BarChart {return token(yytext(), "Grafica_Barras", yyline, yycolumn);}
PieChart {return token(yytext(), "Grafica_Circular", yyline, yycolumn);}
LineChart {return token(yytext(), "Grafica_Lineas", yyline, yycolumn);}
AreaChart {return token(yytext(), "Grafica_Area", yyline, yycolumn);}
ScatterChart {return token(yytext(), "Grafica_Dispersion", yyline, yycolumn);}
LoadData {return token(yytext(), "Cargo_Datos", yyline, yycolumn);}
FilterData {return token(yytext(), "Filtro_Datos", yyline, yycolumn);}
GroupData {return token(yytext(), "Grupo_Datos", yyline, yycolumn);}
JoinData {return token(yytext(), "Ingreso_Datos", yyline, yycolumn);}
CalculateStatistics {return token(yytext(), "Calculo_Estadisticas", yyline, yycolumn);}
Average {return token(yytext(), "Promedio", yyline, yycolumn);}
Mean {return token(yytext(), "Media", yyline, yycolumn);}
Mode {return token(yytext(), "Moda", yyline, yycolumn);}
StandarDeviation {return token(yytext(), "Desviacion_Estandar", yyline, yycolumn);}
Covariance {return token(yytext(), "Covarianza", yyline, yycolumn);}
Correlation {return token(yytext(), "Correlacion", yyline, yycolumn);}
SetTitle {return token(yytext(), "Set_Title", yyline, yycolumn);}
SetAxesLabels {return token(yytext(), "Set_ALabels", yyline, yycolumn);}
SetGrid {return token(yytext(), "Set_Grid", yyline, yycolumn);}
SetFontSize {return token(yytext(), "Set_FontS", yyline, yycolumn);}
SetText {return token(yytext(), "Set_Text", yyline, yycolumn);}
PrintConsole {return token(yytext(), "Print_Console", yyline, yycolumn);}
Array {return token(yytext(), "Arreglo", yyline, yycolumn);}
True {return token(yytext(), "Verdadero", yyline, yycolumn);}
False {return token(yytext(), "Falso", yyline, yycolumn);}

/* Ciclo */

for { return token(yytext(), "For", yyline, yycolumn);}
while { return token(yytext(), "while", yyline, yycolumn);}
doWhile { return token(yytext(), "doWhile", yyline, yycolumn);}


/* If */

if { return token(yytext(), "If", yyline, yycolumn);}
elseIf { return token(yytext(), "ElseIf", yyline, yycolumn);}
else { return token(yytext(), "Else", yyline, yycolumn);}
match { return token(yytext(), "Match", yyline, yycolumn);}

/* ERRORES*/  
/* Numero erroneo*/
0{Numero} { return token(yytext(), "Error_1", yyline, yycolumn);}

/* Mal identificador */
{Identificador} { return token(yytext(), "Error_2", yyline, yycolumn);}

. { return token(yytext(), "ERROR", yyline, yycolumn); }