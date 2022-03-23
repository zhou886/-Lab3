# Lab 3.词法分析实验

1120191286			周彦翔

## 实验目的和内容

### 实验目的

（1）熟悉 C 语言的词法规则，了解编译器词法分析器的主要功能和实现技术，掌握典型词法分析器构造方法，设计并实现 C 语言词法分析器；

（2）了解 Flex 工作原理和基本思想，学习使用工具自动生成词法分析器；

（3）掌握编译器从前端到后端各个模块的工作原理，词法分析模块与其他模块之间的交互过程。

### 实验内容

​	根据 C 语言的词法规则，设计识别 C 语言所有单词类的词法分析器的确定有限状态自动机，并使用 Java、C\C++或者Python 其中任何一种语言，采用程序中心法或者数据中心法设计并实现词法分析器。词法分析器的输入为 C 语言源程序，输出为属性字流。

​	可以选择手动编码实现词法分析器，也可以选择使用 Flex 自动生成词法分析器。需要注意的是，Flex 生成的是C为实现语言的词法分析器，如果需要生成 Java 为实现语言的词法分析器，可以尝试 JFlex 或者 ANTLR。 

​	由于框架是基于Java 语言实现的，并且提供了相应的示例程序，建议学生使用 Java 语言在示例的基础上完成词法分析器。

## 实验的具体过程和步骤

### 为每个单词类写出对应的正则表达式

#### 关键词

![image-20220323093124306](.\Lab 3.词法分析实验.assets\image-20220323093124306.png)

#### 标识符

![image-20220323093327103](.\Lab 3.词法分析实验.assets\image-20220323093327103.png)

```
LETTER          [a-zA-Z]
DIGIT           [0-9]
IDENTIFIER		(_|{LETTER})(_|{LETTER}|{DIGIT})*
```

#### 整形常量

![image-20220323093457650](.\Lab 3.词法分析实验.assets\image-20220323093457650.png)

```
INTEGER_SUF     ({UNSIGNED_SUF}?({LONG_SUF}|{LONGLONG_SUF})?)|(({LONG_SUF}|{LONGLONG_SUF}?){UNSIGNED_SUF}?)
INTEGER_CONST   ([1-9]{DIGIT}*)|(0[0-7]*)|((0x|0X)[0-9A-F]*){INTEGER_SUF}?
```

#### 浮点型常量

![image-20220323093547849](.\Lab 3.词法分析实验.assets\image-20220323093547849.png)

```
EXPONENT_PART   (e|E)[+-]?{DIGIT}+
FLOAT_CONST     ({DIGIT}+\.{DIGIT}+){EXPONENT_PART}?(f|l|F|L)?
```

#### 字符常量

![image-20220323093623375](.\Lab 3.词法分析实验.assets\image-20220323093623375.png)

```
CHAR_CONST      (L|u|U)?\'([^\"\\]|\'|\"|\?|\\|\a|\b|\f|\n|\r|\t|\v)\'
```

#### 字符串字面量

![image-20220323093658896](.\Lab 3.词法分析实验.assets\image-20220323093658896.png)

```
STRING_LITERAL  (u8|u|U|L)?\"([^\"\\]+)\"
```

### 编写lex文件

```lex
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
INTEGER_SUF     ({UNSIGNED_SUF}?({LONG_SUF}|{LONGLONG_SUF})?)|(({LONG_SUF}|{LONGLONG_SUF}?){UNSIGNED_SUF}?)
IDENTIFIER      (_|{LETTER})(_|{LETTER}|{DIGIT})*
INTEGER_CONST   ([1-9]{DIGIT}*)|(0[0-7]*)|((0x|0X)[0-9A-F]*){INTEGER_SUF}?
EXPONENT_PART   (e|E)[+-]?{DIGIT}+
FLOAT_CONST     ({DIGIT}+\.{DIGIT}+){EXPONENT_PART}?(f|l|F|L)?
CHAR_CONST      (L|u|U)?\'([^\"\\]|\'|\"|\?|\\|\a|\b|\f|\n|\r|\t|\v)\'
STRING_LITERAL  (u8|u|U|L)?\"([^\"\\]+)\"

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
    int end_col=col+strlen(cont);
    fprintf(fp,"[@%d,%d:%d='%s',<%s>,%d:%d]\n", cnt, col, end_col, cont, type, row, col);
    ++cnt;
    col+=strlen(cont);
}

int yywrap(){
    printToken("<EOF>","EOF");
	return 1;
}
```

### 使用flex命令生成.c文件

```powershell
flex main.l
```

### 使用gcc命令生成可执行文件

```powershell
gcc main.c -o main.exe
```

## 运行效果截图



## 实验心得体会