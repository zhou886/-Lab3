%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    FILE* fp;
    int row=1,col=0,cnt=0;
    void printToken(char*,char*);
%}

LETTER          [a-zA-Z]
DIGIT           [0-9]
SPACE           [ ]
UNSIGNED_SUF    u|U
LONG_SUF        l|L
LONGLONG_SUF    ll|LL
INTEGER_SUF     ({UNSIGNED_SUF}?({LONG_SUF}|{LONGLONG_SUF})?)|(({LONG_SUF}|{LONGLONG_SUF}){UNSIGNED_SUF})
IDENTIFIER      (_|{LETTER})(_|{LETTER}|{DIGIT})*
INTEGER_CONST   (([1-9]{DIGIT}*)|(0[0-7]*)|((0x|0X)[0-9A-F]*)){INTEGER_SUF}
EXPONENT_PART   (e|E)[+-]?{DIGIT}+
FLOAT_CONST     ({DIGIT}+\.{DIGIT}+){EXPONENT_PART}?(f|l|F|L)?
CHAR_CONST      (L|u|U)?\'([^\"\\]|\\\'|\\\"|\\?|\\\\|\\a|\\b|\\f|\\n|\\r|\\t|\\v)\'
STRING_LITERAL  (u8|u|U|L)?\"(([^\"\\]|\\\'|\\\"|\\?|\\\\|\\a|\\b|\\f|\\n|\\r|\\t|\\v)+)\"

%%
\n              {++row; col=0;}
"auto"		    {printToken(yytext,"'auto'");}
"break"		    {printToken(yytext,"'break'");}
"case"		    {printToken(yytext,"'case'");}
"char"		    {printToken(yytext,"'char'");}
"const"	    	{printToken(yytext,"'const'");}
"continue"		{printToken(yytext,"'continue'");}
"default"		{printToken(yytext,"'default'");}
"do"		    {printToken(yytext,"'do'");}
"double"		{printToken(yytext,"'double'");}
"else"	    	{printToken(yytext,"'else'");}
"enum"		    {printToken(yytext,"'enum'");}
"extern"		{printToken(yytext,"'extern'");}
"float"	    	{printToken(yytext,"'float'");}
"for"	    	{printToken(yytext,"'for'");}
"goto"		    {printToken(yytext,"'goto'");}
"if"	    	{printToken(yytext,"'if'");}
"inline"		{printToken(yytext,"'inline'");}
"int"	    	{printToken(yytext,"'int'");}
"long"	    	{printToken(yytext,"'long'");}
"register"		{printToken(yytext,"'register'");}
"restrict"		{printToken(yytext,"'restrict'");}
"return"		{printToken(yytext,"'return'");}
"short"		    {printToken(yytext,"'short'");}
"signed"		{printToken(yytext,"'signed'");}
"sizeof"		{printToken(yytext,"'sizeof'");}
"static"		{printToken(yytext,"'static'");}
"struct"		{printToken(yytext,"'struct'");}
"switch"		{printToken(yytext,"'switch'");}
"typedef"		{printToken(yytext,"'typedef'");}
"union"		    {printToken(yytext,"'union'");}
"unsigned"		{printToken(yytext,"'unsigned'");}
"void"		    {printToken(yytext,"'void'");}
"volatile"		{printToken(yytext,"'volatile'");}
"while"		    {printToken(yytext,"'while'");}
"["	    	    {printToken(yytext,"'['");}
"]"	    	    {printToken(yytext,"']'");}
"("	    	    {printToken(yytext,"'('");}
")"	    	    {printToken(yytext,"')'");}
"{"	    	    {printToken(yytext,"'{'");}
"}"	    	    {printToken(yytext,"'}'");}
"%:%:"		    {printToken(yytext,"'%:%:'");}
"..."		    {printToken(yytext,"'...'");}
"<<="		    {printToken(yytext,"'<<='");}
">>="		    {printToken(yytext,"'>>='");}
"++"		    {printToken(yytext,"'++'");}
"--"		    {printToken(yytext,"'--'");}
"<<"		    {printToken(yytext,"'<<'");}
">>"		    {printToken(yytext,"'>>'");}
"<="		    {printToken(yytext,"'<='");}
">="		    {printToken(yytext,"'>='");}
"=="		    {printToken(yytext,"'=='");}
"!="		    {printToken(yytext,"'!='");}
"&&"		    {printToken(yytext,"'&&'");}
"||"		    {printToken(yytext,"'||'");}
"*="		    {printToken(yytext,"'*='");}
"/="		    {printToken(yytext,"'/='");}
"%="		    {printToken(yytext,"'%='");}
"+="		    {printToken(yytext,"'+='");}
"-="		    {printToken(yytext,"'-='");}
"&="		    {printToken(yytext,"'&='");}
"^="		    {printToken(yytext,"'^='");}
"|="		    {printToken(yytext,"'|='");}
"##"		    {printToken(yytext,"'##'");}
"<:"		    {printToken(yytext,"'<:'");}
":>"		    {printToken(yytext,"':>'");}
"<%"		    {printToken(yytext,"'<%'");}
"%>"		    {printToken(yytext,"'%>'");}
"%:"		    {printToken(yytext,"'%:'");}
"."		        {printToken(yytext,"'.'");}
"&"	    	    {printToken(yytext,"'&'");}
"*"		        {printToken(yytext,"'*'");}
"+"		        {printToken(yytext,"'+'");}
"-"	    	    {printToken(yytext,"'-'");}
"~"	    	    {printToken(yytext,"'~'");}
"!"	    	    {printToken(yytext,"'!'");}
"/"	    	    {printToken(yytext,"'/'");}
"%"	      	    {printToken(yytext,"'%'");}
"<"	    	    {printToken(yytext,"'<'");}
">"	    	    {printToken(yytext,"'>'");}
"^"	    	    {printToken(yytext,"'^'");}
"|"	    	    {printToken(yytext,"'|'");}
"?"	    	    {printToken(yytext,"'?'");}
":"	    	    {printToken(yytext,"':'");}
";"	    	    {printToken(yytext,"';'");}
"="	    	    {printToken(yytext,"'='");}
","	    	    {printToken(yytext,"','");}
"#"	    	    {printToken(yytext,"'#'");}
{SPACE}         {++col;}
{IDENTIFIER}    {printToken(yytext,"IDENTIFIER");}
{INTEGER_CONST} {printToken(yytext,"INTEGER_CONSTANT");}
{FLOAT_CONST}   {printToken(yytext,"FLOATING_CONSTANT");}
{CHAR_CONST}    {printToken(yytext,"CHARACTER_CONSTANT");}
{STRING_LITERAL} {printToken(yytext,"STRING_LITERAL");}
%%

int main() {
    yyin=fopen("./test.c","r");
    fp=fopen("./test.tokens","w");
    yylex();
    return 0;
}

void printToken(char* cont, char* type) {
    int end_col=col+strlen(cont)-1;
    fprintf(fp,"[@%d,%d:%d='%s',<%s>,%d:%d]\n", cnt, col, end_col, cont, type, row, col);
    ++cnt;
    col+=strlen(cont);
}

int yywrap(){
    printToken("<EOF>","EOF");
	return 1;
}