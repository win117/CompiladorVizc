import compilerTools.TextColor;
import java.awt.Color;

%%
%class LexerColor
%type TextColor
%char
%{
    private TextColor textColor(long start, int size, Color color){
        return new TextColor((int) start, size, color);
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
{Comentario} { return textColor(yychar, yylength(), new Color(146, 146, 146)); }
{EspacioEnBlanco} { /*Ignorar*/ }


/* Identificador */
\${Identificador} { /* Ignorar */ }

/* Tipos de dato */
int | bigInt | real | bigReal | text | color | bool  { return textColor(yychar, yylength(), new Color(0, 0, 149)); }

/* Numero */
{Numero} { return textColor(yychar, yylength(), new Color(0, 100, 0)); }

/* Numero decimal */

{NumeroDecimal} { return textColor(yychar, yylength(), new Color(0, 100, 0)); }

/* Numero color*/

/* Colores */
"("{NumeroColor}","{NumeroColor}","{NumeroColor}")" { /*Ignorar */}

/* Operadores de agrupacion */ 
"(" |
")" |
"{" |
"}" |
"[" |
"]" { return textColor(yychar, yylength(), new Color(139, 0, 0)); }

/* Operadores logicos */
"&" | "|" | "!" { return textColor(yychar, yylength(), new Color(139, 0, 0)); }

/* Operadores relacionales */

"==" | "!=" | "<" | ">" | "<=" | ">=" { return textColor(yychar, yylength(), new Color(85, 26, 139)); }

/* Signos de puntuacion*/
"," |
";" { return textColor(yychar, yylength(), new Color(139, 0, 0)); }

/* Operadores aritmeticos */

"*" | "/" | "+" | "-" | "^" | "%" { return textColor(yychar, yylength(), new Color(85, 26, 139)); }

/* Operador asignacion*/

"=" { return textColor(yychar, yylength(), new Color(85, 26, 139)); }

/* Asignacion compuesta */

"+=" | "-=" | "*=" | "/=" | "^=" | "%=" { return textColor(yychar, yylength(), new Color(85, 26, 139)); }

/* Palabras reservadas */
MainPlane |
function |
clear |
return |
BarChart |
PieChart |
LineChart |
AreaChart |
ScatterChart |
LoadData |
FilterData |
GroupData |
JoinData |
CalculateStatistics |
Average |
Mean |
Mode |
StandarDeviation |
Covariance |
Correlation |
SetTitle |
SetAxesLabels |
SetGrid |
SetFontSize |
SetText |
PrintConsole |
Array |
True |
False { return textColor(yychar, yylength(), new Color(0, 0, 149)); }

/* Ciclo */

for |
while |
doWhile { return textColor(yychar, yylength(), new Color(255, 140, 0)); }


/* If */

if |
elseIf |
else |
match { return textColor(yychar, yylength(), new Color(255, 140, 0)); }

/* ERRORES*/  
/* Numero erroneo*/
0{Numero} { return textColor(yychar, yylength(), new Color(155, 0, 0)); }

/* Mal identificador */
{Identificador} { return textColor(yychar, yylength(), new Color(155, 0, 0)); }


. { /* Ignorar */ }
