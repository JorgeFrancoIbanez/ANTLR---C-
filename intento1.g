grammar intento1;

/*jorge franco iba�ez
kevin julio marquez
anglel jimenes escobar*/
declarar:	variable | operations EOF!;

expresion
	:	expresionLogica;
expresionLogica
	:	expresionBooleana (OR expresionBooleana)*;
expresionBooleana
	:	expresionIgualdad ((EQUALS|NOTEQUALS)expresionIgualdad)*;
expresionIgualdad
	:	expresionRelacional (AND expresionRelacional)*;

expresionRelacional 
	:	expresionAditiva ( (LT|LTEQ|GT|GTEQ) expresionAditiva)*;
	
expresionAditiva
	:	expressionMultiplicativa( (PLUS|MINUS) expressionMultiplicativa)*;
expressionMultiplicativa
	:	expresionPotencia ( (MULT|DIV|MOD) expresionPotencia)*;
expresionPotencia
	:	expresionCerrada  (POW expresionCerrada)*;
expresionCerrada
	:	primaria
	|	NOT primaria
	|	MINUS expresionCerrada
	;

primaria
	:	valor
	;

valor	
	:	INTEGER
	|	FLOAT
	|	NOMBRE
	;
operations
	:	NOMBRE IGUAL expresion PUNTOYCOMA
	|	NOMBRE CCI (numero|NOMBRE) CCD IGUAL (numero|NOMBRE) PUNTOYCOMA
	|	postfix NOMBRE PUNTOYCOMA
	|	NOMBRE postfix PUNTOYCOMA
	|	NOMBRE assignment (NOMBRE|numero) PUNTOYCOMA
	;



variable
	:  constant tipo NOMBRE PUNTOYCOMA
	| constant simple NOMBRE IGUAL numero PUNTOYCOMA
	| constant tReference NOMBRE IGUAL (NOMBRE| '\u0022' NOMBRE '\u0022')  PUNTOYCOMA
	| tipo NOMBRE bloque PUNTOYCOMA
	| tipo NOMBRE PUNTOYCOMA 
	| tipo NOMBRE (',' NOMBRE)* PUNTOYCOMA 
	| tipo NOMBRE (',' NOMBRE)* IGUAL NOMBRE (',' NOMBRE)* PUNTOYCOMA 
	| tipo NOMBRE (',' NOMBRE)* IGUAL numero (',' numero)* PUNTOYCOMA 
	| tipo NOMBRE IGUAL NOMBRE PUNTOYCOMA 
	| tipo NOMBRE IGUAL numero PUNTOYCOMA
	| 'char' NOMBRE IGUAL  '\u0027' CHAR '\u0027' PUNTOYCOMA
	| 'char' CCI CCD NOMBRE IGUAL 'new' 'char' CCI (numero) CCD PUNTOYCOMA
	| tipo CCI CCD NOMBRE IGUAL 'new' tipo CCI (numero|NOMBRE) CCD PUNTOYCOMA
	| tipo CCI CCD NOMBRE IGUAL bloque PUNTOYCOMA

	;

tipo		:	tvalor;
/*valor*/
tvalor		:	simple;
simple		:	integral|flotante|decimal;
integral		:	'int'|'uint'|'short'|'ushort'|'long'|'ulong'|'byte'|'sbyte';
flotante		:	'float'|'double'|'long double';
decimal		:	'decimal';
booleano		:	'bool';
enum		:	'enum';
tReference		:	'class' |'interface' |'delegate' |'dynamic' |'Obej' |'string' ;     //https://msdn.microsoft.com/es-es/library/490f96s2.aspx
constant		:	'const';
numero		:	INTEGER|FLOAT;
bloque	 	:	LLI ((NOMBRE (',' NOMBRE)*)| (numero(',' numero)*)) LLD;
postfix		:	LLI LLD |CCI CCD |'->' |PLUS PLUS |MINUS MINUS;
assignment		:	PLUS IGUAL| MINUS IGUAL| MULT IGUAL | DIV IGUAL | MOD IGUAL | POW IGUAL;



NOMBRE	:	('a'..'z' |  'A'..'Z'  | '_')('a'..'z' |  'A'..'Z'  |  '0'..'9')*;
INTEGER	:	('0'..'9')+;
CHAR	:	('a'..'z' |  'A'..'Z'  |  '0'..'9');
FLOAT	:	('0'..'9')* '.' ('0'..'9')+;
PUNTOYCOMA :	';';	
IGUAL 	:	'=';
LLI	:	'{';
LLD	:	'}';
CCI	:	'[';
CCD	:	']';
PI	:	'(';
PD	:	')';

NOT	:	'!' | 'not';
PLUS	:	'+';
MINUS	:	'-';
MULT	:	'*';
DIV	:	'/';
MOD	:	'%';
POW	:	'^';


EQUALS	:	'=' | '==';
NOTEQUALS 	:	'!=' | '<>';
LT	:	'<';
LTEQ	:	'<=';
GTEQ	:	'>=';
GT	:	'>';
OR 	: 	'||' | 'or';
AND 	: 	'&&' | 'and';
