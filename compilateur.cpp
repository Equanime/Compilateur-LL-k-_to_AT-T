//  A compiler from a very simple Pascal-like structured language LL(k)
//  to 64-bit 80x86 Assembly langage
//  Copyright (C) 2019 Pierre Jourlin
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.
// Build with "make compilateur"

#include <string>
#include <iostream>
#include <cstdlib>
#include <set>
#include <map>
#include <FlexLexer.h>
#include "tokeniser.h"
#include <cstring>

using namespace std;

enum OPREL
{
	EQU,
	DIFF,
	INF,
	SUP,
	INFE,
	SUPE,
	WTFR
};
enum OPADD
{
	ADD,
	SUB,
	OR,
	WTFA
};
enum OPMUL
{
	MUL,
	DIV,
	MOD,
	AND,
	WTFM
};

enum TYPES
{
	INTEGER,
	BOOLEAN,
	DOUBLE,
	CHAR,
	WTFT
};

TOKEN current;						// Current token
FlexLexer *lexer = new yyFlexLexer; // This is the flex tokeniser
// tokens can be read using lexer->yylex()
// lexer->yylex() returns the type of the lexicon entry (see enum TOKEN in tokeniser.h)
// and lexer->YYText() returns the lexicon entry as a string
map<string, enum TYPES> DeclaredVariables;
map<string, enum TYPES> DeclaredVariablesArray;
unsigned long TagNumber = 0;

// FONCTIONS HORS GRAMMAIRE
// Faire ces deux fonctions IsIdArrayDeclared et IsDeclared me permet d'isoler les cas ou un l'id déclaré est uniquement celui d'un tableau
bool IsIdArrayDeclared(const char *id) // verifier si un id de tableau est déclaré
{
	return (DeclaredVariablesArray.find(id) != DeclaredVariablesArray.end());
}
bool IsDeclared(const char *id) // verifier si un id est déclaré
{
	return (DeclaredVariables.find(id) != DeclaredVariables.end()) || IsIdArrayDeclared(id);
}
void Error(string s) // affiche un message d'erreur et termine le programme
{
	cerr << "Ligne n°" << lexer->lineno() << ", lu : '" << lexer->YYText() << "'(" << current << "), mais "; // numero de lexer->lineno()
	cerr << s << endl;
	exit(-1);
}
int IsKeyWord(const char *kw) // verifier si le mot clef attendu est un KEYWORD
{
	if (current != KEYWORD)
	{
		return 0;
	}
	else
	{
		return !strcmp(lexer->YYText(), kw);
	}
}
void ReadKeyWord(const char *kw) // consomme le KEWORD
{
	if (!IsKeyWord(kw))
	{
		string message = "Erreur : " + (string)kw + " attendu !";
		Error(message);
	}
	else
	{
		current = (TOKEN)lexer->yylex();
	}
}

// GRAMMAIRE

// Program := [VarDeclarationPart] StatementPart

// VarDeclarationPart := "VAR" ("ARRAY" VarArrayDeclaration | VarDeclaration) {";" ("ARRAY" VarArrayDeclaration | VarDeclaration)} "."
// VarDeclaration := Identifier {"," Identifier} ":" Type
// VarArrayDeclaration := "ARRAY" IdentifierArray {"," IdentifierArray } ":" Type

// StatementPart := Statement {";" Statement} "."
// Statement := AssignementStatement | AssignementArrayStatement | AssignmentValueOfArrayStatement | IfStatement | WhileStatement | ForStatement | BlockStatement | CaseStatement | DisplayStatement
// AssignementStatement := Letter "=" Expression
// AssignementArrayStatement := Identifier ":=" "[" Expression { "," Expression } "]"
// AssignmentValueOfArrayStatement:= IdentifierArray ":=" Expression
// IfStatement := "IF" Expression "THEN" Statement [ "ELSE" Statement ]
// WhileStatement := "WHILE" Expression "DO" Statement
// ForStatement := "FOR" AssignementStatement ("TO"|"DOWNTO") Expression "DO" Statement
// BlockStatement := "BEGIN" Statement { ";" Statement } "END"
// DisplayStatement := DISPLAY Expression
// CaseStatement := CASE Expression OF CaseListElement {";" CaseListElement } ELSE Statement END
// CaseListElement := CaseLabelList ":" Statement
// CaseLabelList := CaseLabelList {"," CaseLabelList}
// LabelList := Number|CHARCONST

// Expression := SimpleExpression [RelationalOperator SimpleExpression]
// SimpleExpression := Term {AdditiveOperator Term}
// Term := Factor {MultiplicativeOperator Factor}
// Factor := Number | Letter | "(" Expression ")" | Expression | "!" Factor
// IdentifierArray := Identifier "[" Identifier|Number "]"
// Identifier := Letter { Letter | digit }
// Number := Digit {Digit} [ "." Digit {Digit} ]
// Type := "BOOLEAN" | "INTEGER" | "CHAR" | "DOUBLE"

// AdditiveOperator := "+" | "-" | "||"
// MultiplicativeOperator := "*" | "/" | "%" | "&&"
// RelationalOperator := "==" | "!=" | "<" | ">" | "<=" | ">="
// CharConst := "'" "\" Letter "'"
// Digit := "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"
// Letter := "a"|...|"z"

// Pre Declarations
enum TYPES Expression(void);
void Statement(void);

// FONCTIONS DE GRAMMAIRE

// CharConst := "'" "\" Letter "'"
enum TYPES CharConst(void)
{
	if (current != CHARCONST)
	{
		Error("Caractère attendu");
	}
	cout << "\tmovq $0, %rax" << endl;
	cout << "\tmovb $" << lexer->YYText() << ",%al" << endl;
	cout << "\tpush %rax\t# push a 64-bit version of " << lexer->YYText() << endl;
	current = (TOKEN)lexer->yylex();
	return CHAR;
}
// MultiplicativeOperator := "*" | "/" | "%" | "&&"
OPMUL MultiplicativeOperator(void)
{
	OPMUL opmul;
	if (strcmp(lexer->YYText(), "*") == 0)
		opmul = MUL;
	else if (strcmp(lexer->YYText(), "/") == 0)
		opmul = DIV;
	else if (strcmp(lexer->YYText(), "%") == 0)
		opmul = MOD;
	else if (strcmp(lexer->YYText(), "&&") == 0)
		opmul = AND;
	else
		opmul = WTFM;
	current = (TOKEN)lexer->yylex();
	return opmul;
}
// RelationalOperator := "==" | "!=" | "<" | ">" | "<=" | ">="
OPREL RelationalOperator(void)
{
	OPREL oprel;
	if (strcmp(lexer->YYText(), "==") == 0)
		oprel = EQU;
	else if (strcmp(lexer->YYText(), "!=") == 0)
		oprel = DIFF;
	else if (strcmp(lexer->YYText(), "<") == 0)
		oprel = INF;
	else if (strcmp(lexer->YYText(), ">") == 0)
		oprel = SUP;
	else if (strcmp(lexer->YYText(), "<=") == 0)
		oprel = INFE;
	else if (strcmp(lexer->YYText(), ">=") == 0) // compare deux chaines caractere par caractere dans l'ordre alpha en faisait la difference de chaque caractere
		oprel = SUPE;
	else
		oprel = WTFR;
	current = (TOKEN)lexer->yylex();
	return oprel;
}
// AdditiveOperator := "+" | "-" | "||"
OPADD AdditiveOperator(void)
{
	OPADD opadd;
	if (strcmp(lexer->YYText(), "+") == 0)
		opadd = ADD;
	else if (strcmp(lexer->YYText(), "-") == 0)
		opadd = SUB;
	else if (strcmp(lexer->YYText(), "||") == 0)
		opadd = OR;
	else
		opadd = WTFA;
	current = (TOKEN)lexer->yylex();
	return opadd;
}

// Type := "BOOLEAN" | "INTEGER" | "CHAR" | "DOUBLE"
enum TYPES Type(void)
{
	if (current != KEYWORD)
	{
		Error("mot clef definissant le type attendu !");
	}
	if (strcmp(lexer->YYText(), "BOOLEAN") == 0)
	{
		current = (TOKEN)lexer->yylex();
		return BOOLEAN;
	}
	else if (strcmp(lexer->YYText(), "INTEGER") == 0)
	{
		current = (TOKEN)lexer->yylex();
		return INTEGER;
	}
	else if (strcmp(lexer->YYText(), "CHAR") == 0)
	{
		current = (TOKEN)lexer->yylex();
		return CHAR;
	}
	else if (strcmp(lexer->YYText(), "DOUBLE") == 0)
	{
		current = (TOKEN)lexer->yylex();
		return DOUBLE;
	}
	else
	{
		Error("type non reconnu");
	}
	return WTFT;
}
// Number := Digit{Digit}["."{Digit}]
enum TYPES Number(void)
{
	double d; // 64-bit float
	unsigned int *i;
	string number = lexer->YYText();
	if (number.find(".") != string::npos)
	{ // Double
		d = atof(lexer->YYText());
		i = (unsigned int *)&d;
		cout << "\tsubq $8,%rsp\t\t\t# allouer 8 octets sur le sommet de la pile pour DOUBLE" << endl;
		cout << "\tmovl	$" << *i << ", (%rsp)\t# Conversion de " << d << " (partie haute de 32 bits)" << endl;
		cout << "\tmovl	$" << *(i + 1) << ", 4(%rsp)\t# Conversion de " << d << " (partie basse de 32 bits)" << endl;
		current = (TOKEN)lexer->yylex();
		return DOUBLE;
	}
	else
	{ // Integer
		cout << "\tpush $" << atoi(lexer->YYText()) << "\t#INTEGER" << endl;
		current = (TOKEN)lexer->yylex();
		return INTEGER;
	}
}
// Identifier := Letter { Letter | digit }
enum TYPES Identifier(void)
{
	enum TYPES type;
	if (IsDeclared(lexer->YYText()))
	{
		type = DeclaredVariables[lexer->YYText()];
		cout << "\tpush " << lexer->YYText() << "\t\t#Identifier" << endl;
	}
	else
	{
		cerr << "Erreur : Variable '" << lexer->YYText() << "' non déclarée" << endl;
		exit(-1);
	}
	current = (TOKEN)lexer->yylex();
	return type;
}
// IdentifierArray := Identifier "[" Identifier|Number "]"
string IdentifierArray(string &sizeArray) // cette fonction renvoit le type de l'identifier, et affecte le variable passee par reference definissant la taille du tableau
{
	if (current != IDARRAY)
	{
		Error("Identificateur attendu");
	}
	string id = lexer->YYText();
	size_t pos = id.find('[');
	if (pos != string::npos)
	{
		id = id.substr(0, pos);
	}
	sizeArray = lexer->YYText();
	size_t start = sizeArray.find('[');
	size_t end = sizeArray.find(']');
	if (start != string::npos && end != string::npos && start < end)
	{
		sizeArray = sizeArray.substr(start + 1, end - start - 1);
	}
	current = (TOKEN)lexer->yylex();
	return id;
}
// Factor := Number | Letter | "(" Expression ")" | Expression | "!" Factor
enum TYPES Factor(void)
{
	enum TYPES type;
	switch (current)
	{
	case RPARENT:
		current = (TOKEN)lexer->yylex();
		type = Expression();
		if (current != LPARENT)
			Error("')' était attendu"); // ")" expected
		else
			current = (TOKEN)lexer->yylex();
		break;
	case NUMBER:
		type = Number();
		break;
	case ID:
		if (IsIdArrayDeclared(lexer->YYText())) // nous avons un id de tableau
		{
			cout << "\tpushq " << lexer->YYText() << "(,%rbx)\t\t#id de tableau" << endl;
			current = (TOKEN)lexer->yylex();
		}
		else // nous avons un id de variable
		{
			type = Identifier();
		}
		break;
	case CHARCONST:
		type = CharConst();
		break;
	case NOT:
		current = (TOKEN)lexer->yylex();
		type = Factor();
		cout << "\tpop %rax\t\t#procedure de NOT" << endl;
		cout << "\tnot %rax" << endl;
		cout << "\tpush %rax\t\t#NOT %rax" << endl;
		break;
	case KEYWORD:
		if (IsKeyWord("TRUE"))
		{
			ReadKeyWord("TRUE");
			type = BOOLEAN;
			cout << "\tpush $0xFFFFFFFFFFFFFFFF\t#TRUE" << endl;
		}
		else if (IsKeyWord("FALSE"))
		{
			ReadKeyWord("FALSE");
			type = BOOLEAN;
			cout << "\tpush $0\t#FALSE" << endl;
		}
		else
		{
			Error("TRUE ou FALSE attendu");
		}
		break;
	default:
		Error("Erreur dans l'expression de Factor attendue.");
	};
	return type;
}
// Term := Factor {MultiplicativeOperator Factor}
enum TYPES Term(void)
{
	OPMUL mulop;
	enum TYPES type1, type2;
	type1 = Factor();
	while (current == MULOP)
	{
		mulop = MultiplicativeOperator(); // Sauvegarde de l'operateur dans une variable locale
		type2 = Factor();
		if (type1 != type2)
		{
			cerr << "Type variable " << type1 << endl;
			cerr << "Type Expression " << type2 << endl;
			Error("Les types des operandes ne sont pas compatibles");
		}
		switch (mulop)
		{
		case AND:
			if (type2 != BOOLEAN)
				Error("type non booleen pour l'operateur AND");
			cout << "\tpop %rbx \t\t#procedure de AND" << endl; // Recupere operande 1
			cout << "\tpop %rax" << endl;						// Recupere operande 2
			cout << "\tmulq	%rbx" << endl;						// a * b -> %rdx:%rax
			cout << "\tpush %rax\t# AND" << endl;				// Stocker le résultat
			break;
		case MUL:
			if (type2 != INTEGER && type2 != DOUBLE)
				Error("type non numerique pour la multiplication");
			if (type2 == INTEGER)
			{
				cout << "\tpop %rbx\t\t#procedure de MUL INTEGER" << endl; // Recupere operande 1
				cout << "\tpop %rax" << endl;							   // Recupere operande 2
				cout << "\tmulq	%rbx" << endl;							   // a * b -> %rdx:%rax
				cout << "\tpush %rax\t# MUL" << endl;					   // Stocker le résultat
			}
			else
			{
				cout << "\tfldl	8(%rsp)\t\t#procedure de MUL DOUBLE" << endl;
				cout << "\tfldl	(%rsp)\t# premier operande -> %st(0) ; deuxième operande -> %st(1)" << endl;
				cout << "\tfmulp	%st(0),%st(1)\t#%st(0) <- op1 + op2 ; %st(1)=null" << endl;
				cout << "\tfstpl 8(%rsp)" << endl;
				cout << "\taddq	$8, %rsp\t# resultat au sommet de la pile" << endl;
			}
			break;
		case DIV:
			if (type2 != INTEGER && type2 != DOUBLE)
				Error("type non numerique pour la division");
			if (type2 == INTEGER)
			{
				cout << "\tpop %rbx \t\t#procedure de DIV INTEGER" << endl; // Recupere operande 1
				cout << "\tpop %rax" << endl;								// Recupere operande 1
				cout << "\tmovq $0, %rdx" << endl;							// Partie supérieure du numérateur
				cout << "\tdiv %rbx" << endl;								// Le quotient va dans %rax
				cout << "\tpush %rax\t# DIV" << endl;						// Stocker le résultat
			}
			else
			{
				cout << "\tfldl	(%rsp)\t\t\t#procedure de DIV DOUBLE" << endl;
				cout << "\tfldl	8(%rsp)\t# premier operande -> %st(0) ; deuxième operande -> %st(1)" << endl;
				cout << "\tfdivp	%st(0),%st(1)\t#	%st(0) <- op1 + op2 ; %st(1)=null" << endl;
				cout << "\tfstpl 8(%rsp)" << endl;
				cout << "\taddq	$8, %rsp\t# resultat au sommet de la pile" << endl;
			}
			break;
		case MOD:
			if (type2 != INTEGER)
			{
				Error("type non entier pour le modulo");
			}
			cout << "\tpop %rbx\t\t#procedure de MOD" << endl; // Recupere operande 1
			cout << "\tpop %rax" << endl;					   // Recupere operande 2
			cout << "\tmovq $0, %rdx" << endl;				   // Partie supérieure du numérateur
			cout << "\tdiv %rbx" << endl;					   // Le reste va dans %rdx
			cout << "\tpush %rdx\t# MOD" << endl;			   // Stocker le résultat
			break;
		default:
			Error("operateur multiplicatif attendu");
		}
	}
	return type1;
}
// SimpleExpression := Term {AdditiveOperator Term}
enum TYPES SimpleExpression(void)
{
	OPADD adop;
	enum TYPES type1, type2;
	type1 = Term();
	while (current == ADDOP)
	{
		adop = AdditiveOperator(); // Save operator in local variable
		type2 = Term();
		if (type1 != type2)
		{
			// rajouter explications en affichanrt les operandes
			Error("les types sont incompatibles dans l'expression");
		}
		switch (adop)
		{
		case OR:
			if (type2 != BOOLEAN)
				Error("opérande non booléenne pour l'opérateur OR");
			cout << "\tpop %rbx\t\t#procedure OR" << endl; // get first operand
			cout << "\tpop %rax" << endl;				   // get second operand
			cout << "\torq	%rbx, %rax\t# OR" << endl;	   // operand1 OR operand2
			cout << "\tpush %rax" << endl;				   // store result
			break;
		case ADD:
			if (type2 != INTEGER && type2 != DOUBLE)
				Error("opérande non numérique pour l'addition");
			if (type2 == INTEGER)
			{
				cout << "\tpop %rbx \t\t#procedure ADD INTEGER" << endl; // get first operand
				cout << "\tpop %rax" << endl;							 // get second operand
				cout << "\taddq	%rbx, %rax\t# ADD" << endl;				 // add both operands
				cout << "\tpush %rax" << endl;							 // store result
			}
			else
			{
				cout << "\tfldl	8(%rsp)\t\t#procedure ADD DOUBLE" << endl;
				cout << "\tfldl	(%rsp)\t# first operand -> %st(0) ; second operand -> %st(1)" << endl;
				cout << "\tfaddp	%st(0),%st(1)\t# %st(0) <- op1 + op2 ; %st(1)=null" << endl;
				cout << "\tfstpl 8(%rsp)" << endl;
				cout << "\taddq	$8, %rsp\t# result on stack's top" << endl;
			}
			break;
		case SUB:
			if (type2 != INTEGER && type2 != DOUBLE)
				Error("opérande non numérique pour la soustraction");
			if (type2 == INTEGER)
			{
				cout << "\tpop %rbx\t\t#procedure SUB INTEGER" << endl; // get first operand
				cout << "\tpop %rax" << endl;							// get second operand
				cout << "\tsubq	%rbx, %rax\t# SUB" << endl;				// add both operands
				cout << "\tpush %rax" << endl;							// store result
			}
			else
			{
				cout << "\tfldl	(%rsp)\t\t#procedure SUB DOUBLE" << endl;
				cout << "\tfldl	8(%rsp)\t# first operand -> %st(0) ; second operand -> %st(1)" << endl;
				cout << "\tfsubp	%st(0),%st(1)\t# %st(0) <- op1 - op2 ; %st(1)=null" << endl;
				cout << "\tfstpl 8(%rsp)" << endl;
				cout << "\taddq	$8, %rsp\t# result on stack's top" << endl;
			}
			break;
		default:
			Error("opérateur additif inconnu");
		}
	}
	return type1;
}
// Expression := SimpleExpression [RelationalOperator SimpleExpression]
enum TYPES Expression(void)
{
	OPREL oprel;
	enum TYPES type1, type2;
	type1 = SimpleExpression();
	if (current == RELOP)
	{
		oprel = RelationalOperator();
		type2 = SimpleExpression();
		if (type1 != type2)
		{
			Error("Les types ne sont pas compatibles dans l'expression");
		}
		if (type1 == DOUBLE)
		{ // double
			cout << "\tfldl	(%rsp)\t# charger le premier operande dans le registre %st(0)" << endl;
			cout << "\tfldl	8(%rsp)\t# charger le deuxieme operande dans le registre %st(1)" << endl;
			cout << "\t addq $16, %rsp\t# depiler les deux operandes" << endl;
			cout << "\tfcomip %st(1)\t\t# comparer op1 et op2 DOUBLE" << endl;
			cout << "\tfaddp %st(1)" << endl;
		}
		else
		{ // integer
			cout << "\tpop %rax" << endl;
			cout << "\tpop %rbx" << endl;
			cout << "\tcmpq %rax, %rbx\t\t#comparer op1 et op2 INTEGER" << endl;
		}
		switch (oprel)
		{ // boolean
		case EQU:
			cout << "\tje Vrai" << ++TagNumber << "\t\t# If equal" << endl;
			break;
		case DIFF:
			cout << "\tjne Vrai" << ++TagNumber << "\t\t# If different" << endl;
			break;
		case SUPE:
			cout << "\tjae Vrai" << ++TagNumber << "\t\t# If above or equal" << endl;
			break;
		case INFE:
			cout << "\tjbe Vrai" << ++TagNumber << "\t\t# If below or equal" << endl;
			break;
		case INF:
			cout << "\tjb Vrai" << ++TagNumber << "\t\t# If below" << endl;
			break;
		case SUP:
			cout << "\tja Vrai" << ++TagNumber << "\t\t# If above" << endl;
			break;
		default:
			Error("Opérateur de comparaison inconnu");
		}
		cout << "\tpush $0\t\t# False" << endl;
		cout << "\tjmp Suite" << TagNumber << endl;
		cout << "Vrai" << TagNumber << ":\tpush $0xFFFFFFFFFFFFFFFF\t\t# True" << endl;
		cout << "Suite" << TagNumber << ":" << endl;
		return BOOLEAN;
	}
	return type1;
}

// VarDeclaration := Identifier {"," Identifier} ":" Type
void VarDeclaration(void)
{
	set<string> identificators;
	if (current != ID)
	{
		Error("Un identificateur était attendu");
	}
	identificators.insert(lexer->YYText());
	current = (TOKEN)lexer->yylex();
	while (current == COMMA)
	{
		current = (TOKEN)lexer->yylex();
		if (current != ID)
		{
			Error("Un identificateur était attendu");
		}
		else if (identificators.find(lexer->YYText()) != identificators.end())
		{
			cerr << "Erreur : Variable " << lexer->YYText() << endl;
			Error("Variable déjà déclarée");
		}
		identificators.insert(lexer->YYText());
		current = (TOKEN)lexer->yylex();
	}
	if (current != COLON)
	{
		Error("caractère ':' attendu");
	}
	current = (TOKEN)lexer->yylex();
	enum TYPES type = Type();
	for (set<string>::iterator it = identificators.begin(); it != identificators.end(); ++it)
	{
		switch (type)
		{
		case BOOLEAN:
			cout << *it << ":\t.quad 0\t\t#BOOLEAN" << endl;
			break;
		case INTEGER:
			cout << *it << ":\t.quad 0\t\t#INTEGER" << endl;
			break;
		case CHAR:
			cout << *it << ":\t.byte 0 \t\t#CHAR" << endl;
			break;
		case DOUBLE:
			cout << *it << ":\t.double 0.0\t\t#DOUBLE" << endl;
			break;
		default:
			Error("type inconnu.");
		};
		DeclaredVariables[*it] = type;
	}
}
// varArrayDeclaration := "ARRAY" IdentifierArray {"," IdentifierArray } ":" Type
void VarArrayDeclaration(void)
{
	ReadKeyWord("ARRAY");
	set<string> identificatorsArray;
	set<string> sizesArray;
	do
	{
		if (current == COMMA)
		{
			current = (TOKEN)lexer->yylex();
		}
		if (current != IDARRAY)
		{
			Error("Un identificateur de tableau est attendu");
		}
		else if (identificatorsArray.find(lexer->YYText()) != identificatorsArray.end())
		{
			Error("Variable déjà déclarée");
		}
		string sizeArray;
		identificatorsArray.insert(IdentifierArray(sizeArray));
		sizesArray.insert(sizeArray);
	} while (current == COMMA);
	if (current != COLON)
	{
		Error("caractère ':' attendu");
	}
	current = (TOKEN)lexer->yylex();
	enum TYPES type = Type();
	set<string>::iterator its = sizesArray.end();
	for (set<string>::reverse_iterator it = identificatorsArray.rbegin(); it != identificatorsArray.rend(); ++it)
	{
		cout << *it << "sizeArray:\t.quad " << std::stoi(*--its) * 8 << "\t\t#taille tableau" << endl;
		cout << *it << ":\t.space " << std::stoi(*its) * 8 << "\t\t#allocation de la taille du tableau" << endl;
		DeclaredVariablesArray[*it] = type;
	}
}
// VarDeclarationPart := "VAR" ("ARRAY" VarArrayDeclaration | VarDeclaration) {";" ("ARRAY" VarArrayDeclaration | VarDeclaration)} "."
void VarDeclarationPart(void)
{
	ReadKeyWord("VAR");
	cout << "\t.data" << endl;
	cout << "\t.align 8" << endl;
	// cout << "FormatString1:\t.string \"%llu\"\t# used by printf to display 64-bit unsigned integers" << endl;
	cout << "FormatString1:\t.string \"%lld\"\t# used by printf to display 64-bit signed integers" << endl;
	cout << "FormatString2:\t.string \"%lf\"\t# used by printf to display 64-bit floating point numbers" << endl;
	cout << "FormatString3:\t.string \"%c\"\t# used by printf to display a 8-bit single character" << endl;
	cout << "TrueString:\t.string \"TRUE\"\t# used by printf to display the boolean value TRUE" << endl;
	cout << "FalseString:\t.string \"FALSE\"\t# used by printf to display the boolean value FALSE" << endl;
	cout << "SautDeLigne:\t.string \"\"\t# used by printf to display the boolean value FALSE" << endl;
	if (current == KEYWORD)
	{
		if (!IsKeyWord("ARRAY"))
		{
			Error("mot clef ARRAY attendu");
		}
		VarArrayDeclaration();
	}
	else
	{
		VarDeclaration();
	}
	while (current == SEMICOLON)
	{
		current = (TOKEN)lexer->yylex();
		if (current == KEYWORD)
		{
			if (!IsKeyWord("ARRAY"))
			{
				Error("mot clef ARRAY attendu");
			}
			VarArrayDeclaration();
		}
		else
		{
			VarDeclaration();
		}
	}
	if (current != DOT)
	{
		Error("caractère '.' attendu");
	}
	current = (TOKEN)lexer->yylex();
}

// AssignmentValueOfArrayStatement:= IdentifierArray ":=" Expression
void AssignmentValueOfArrayStatement(void)
{
	enum TYPES type1, type2;
	string idArray;
	string indiceValue;

	if (current != IDARRAY)
	{
		Error("Identificateur de tableau attendu pour l'affectation d'une seule valeur ");
	}
	else if (DeclaredVariablesArray.find(lexer->YYText()) != DeclaredVariablesArray.end())
	{
		cerr << "Erreur : Variable '" << lexer->YYText() << "' non déclarée" << endl;
		exit(-1);
	}
	idArray = IdentifierArray(indiceValue);
	if (current != ASSIGN)
	{
		Error("caractères ':=' attendus");
	}
	current = (TOKEN)lexer->yylex();
	type1 = DeclaredVariablesArray[idArray];
	type2 = Expression();
	if (type1 != type2)
	{
		cerr << "Type idArray " << type1 << endl;
		cerr << "Type Expression " << type2 << endl;
		Error("types incompatibles dans l'affectation");
	}
	if (DeclaredVariablesArray[indiceValue] != INTEGER)
	{
		Error("Type non entier pour l'indice du tableau");
	}
	DeclaredVariablesArray.erase(indiceValue); // en effet lors de la comparaison DeclaredVariablesArray[sizeArray] declare sizeArray, je le supprime donc une fois le test passe
	cout << "\tleaq " << idArray << ",%rsi \t\t#je copie l'addresse du tableau" << endl;
	if (IsDeclared(indiceValue.c_str()))
	{
		cout << "\tmovq " << indiceValue << ",%rax\t# Initialise rbx à 0" << endl;
	}
	else
	{
		cout << "\tmovq $" << indiceValue << ",%rax\t# Initialise rbx à 0" << endl;
	}
	cout << "\tmovq $8,%rbx\t# Initialise rbx à 0" << endl;
	cout << "\tmulq %rbx\t# Multiply the content of rax by 8" << endl;
	cout << "\tpop %rbx\t#stocke la valeur a ajouter dans le tableau, dans rbx" << endl;
	cout << "\tmovq %rbx,(%rsi,%rax)\t# stock dans T[indice]" << endl;
}
// AssignementArrayStatement := Identifier ":=" "[" Expression { "," Expression } "]"
void AssignementArrayStatement(void)
{
	enum TYPES type1, type2;
	string idArray;
	if (current != ID)
	{
		Error("Identificateur attendu");
	}
	if (!IsDeclared(lexer->YYText()))
	{
		cerr << "Erreur : Variable '" << lexer->YYText() << "' non déclarée" << endl;
		exit(-1);
	}
	idArray = lexer->YYText();

	type1 = DeclaredVariablesArray[idArray];
	current = (TOKEN)lexer->yylex();
	if (current != ASSIGN)
	{
		Error("caractères ':=' attendus");
	}
	current = (TOKEN)lexer->yylex();
	if (current != RBRACKET)
	{
		Error("caractères '[' attendus");
	}
	current = (TOKEN)lexer->yylex();
	type2 = Expression();
	if (type1 != type2)
	{
		cerr << "Type idArray " << type1 << endl;
		cerr << "Type Expression " << type2 << endl;
		Error("types incompatibles dans l'affectation");
	}
	while (current == COMMA)
	{
		current = (TOKEN)lexer->yylex();
		type2 = Expression();
		if (type1 != type2)
		{
			cerr << "Type idArray " << type1 << endl;
			cerr << "Type Expression " << type2 << endl;
			Error("types incompatibles dans l'affectation");
		}
	}
	if (current != LBRACKET)
	{
		Error("caractères ']' attendus");
	}
	cout << "\tmovq " << idArray << "sizeArray,%rax\t# Initialise rax à sizeArray" << endl;
	cout << "\tleaq " << idArray << ", %rsi\t\t#copie l'addresse de l'idArray dans rsi" << endl;
	cout << "fillArray_" << idArray << ":" << endl;
	cout << "\tsubq $8,%rax \t\t#diminue la taille du compteur de 8 octets" << endl;
	cout << "\tpopq (%rsi,%rax)\t# stock dans T[taille du compteur-1]" << endl;
	cout << "\tcmpq $0, %rax \t\t# comparaison compteur" << endl;
	cout << "\tjne fillArray_" << idArray << endl;
	current = (TOKEN)lexer->yylex();
}
// AssignementStatement := Identifier ":=" Expression
string AssignementStatement(void)
{
	enum TYPES type1, type2;
	string variable;
	if (current != ID)
	{
		Error("Identificateur attendu");
	}
	if (!IsDeclared(lexer->YYText()))
	{
		cerr << "Erreur : Variable '" << lexer->YYText() << "' non déclarée" << endl;
		exit(-1);
	}
	variable = lexer->YYText();
	type1 = DeclaredVariables[variable];
	current = (TOKEN)lexer->yylex();
	if (current != ASSIGN)
	{
		Error("caractères ':=' attendus");
	}
	current = (TOKEN)lexer->yylex();

	type2 = Expression();
	if (type1 != type2)
	{
		cerr << "Type variable " << type1 << endl;
		cerr << "Type Expression " << type2 << endl;
		Error("types incompatibles dans l'affectation");
	}
	cout << "\tpop " << variable << endl;
	return variable;
}

// IfStatement := "IF" Expression "THEN" Statement [ "ELSE" Statement ]
void IfStatement(void)
{
	unsigned long currentTagNumber = ++TagNumber;
	enum TYPES type;
	ReadKeyWord("IF");
	cout << "TestIf" << currentTagNumber << ":" << endl;
	type = Expression();
	if (type != BOOLEAN)
	{
		Error("Expression booléenne attendue");
	}
	cout << "\tpop %rax" << endl;	  // je depile
	cout << "\tcmpq $0,%rax" << endl; // si c'est vrai
	cout << "\tje Else" << currentTagNumber << endl;
	ReadKeyWord("THEN");
	Statement();
	cout << "\tjmp FinIf" << currentTagNumber << endl;
	cout << "Else" << currentTagNumber << ":" << endl; // creation etiquette
	if (IsKeyWord("ELSE"))
	{
		ReadKeyWord("ELSE");
		Statement();
	}
	cout << "FinIf" << currentTagNumber << ":" << endl; // creation etiquette
	TagNumber++;										// incremente si plusieurs boucle
}
// WhileStatement := "WHILE" Expression "DO" Statement
void WhileStatement(void)
{
	unsigned long currentTagNumber = ++TagNumber;
	enum TYPES type;
	ReadKeyWord("WHILE");
	cout << "TestWhile" << currentTagNumber << ":" << endl;
	type = Expression();
	if (type != BOOLEAN)
	{
		Error("Expression booléenne attendue");
	}
	cout << "\tpop %rax" << endl;	  // je depile
	cout << "\tcmpq $0,%rax" << endl; // Test condition de fin de la boucle while
	cout << "\tje FinWhile" << currentTagNumber << endl;
	ReadKeyWord("DO");
	Statement();
	cout << "\tjmp TestWhile" << currentTagNumber << endl;
	cout << "FinWhile" << currentTagNumber << ":" << endl; // creation etiquette
	TagNumber++;										   // incremente si plusieurs boucle
}
// ForStatement := "FOR" AssignementStatement ("TO"|"DOWNTO") Expression "DO" Statement
void ForStatement(void)
{
	string varBoucleFor;
	unsigned long currentTagNumber = ++TagNumber;
	ReadKeyWord("FOR");
	varBoucleFor = AssignementStatement(); // code affectation
	if (IsKeyWord("TO"))
	{
		ReadKeyWord("TO");
		cout << "TestFor" << currentTagNumber << ":" << endl; // creation etiquette
		Expression();										  // pointé par %rsp
		cout << "\tmovq " << varBoucleFor << ",%rax \t\t#indice du for" << endl;
		cout << "\tpopq %rbx\t#la fonction printf modifier rsp donc je l'ajoute à un endroit non modifer par prinf, soit r12" << endl;
		cout << "\tcmpq %rbx,%rax\t#je compare avec la borne de fin de if dans r12" << endl;
		cout << "\tja FinFor" << currentTagNumber << endl; // saut vers la fin si inferieur
		ReadKeyWord("DO");
		Statement();
		cout << "\tincq " << varBoucleFor << endl; // incremente varBoucleFor
		cout << "\tjmp TestFor" << currentTagNumber << endl;
		cout << "FinFor" << currentTagNumber << ":" << endl; // creation etiquette
		TagNumber++;
	}
	else if (IsKeyWord("DOWNTO"))
	{
		ReadKeyWord("DOWNTO");
		cout << "TestFor" << currentTagNumber << ":" << endl; // creation etiquette
		Expression();										  // pointé par %rsp
		cout << "\tmovq " << varBoucleFor << ",%rax" << endl;
		cout << "\tpopq %rbx\t#la fonction printf modifier rsp donc je l'ajoute à un endroit non modifer par prinf, soit r12" << endl;
		cout << "\tcmpq %rbx,%rax\t#je compare avec la borne de fin de if dans r12" << endl;
		cout << "\tjb FinFor" << currentTagNumber << endl; // saut vers la fin si inferieur
		ReadKeyWord("DO");
		Statement();
		cout << "\tdecq " << varBoucleFor << endl; // incremente varBoucleFor
		cout << "\tjmp TestFor" << currentTagNumber << endl;
		cout << "FinFor" << currentTagNumber << ":" << endl; // creation etiquette
		TagNumber++;
	}
}
// BlockStatement := "BEGIN" Statement { ";" Statement } "END"
void BlockStatement(void)
{
	unsigned long currentTagNumber = ++TagNumber;
	cout << "Begin" << currentTagNumber << ":" << endl;
	ReadKeyWord("BEGIN");
	Statement();
	while (strcmp(lexer->YYText(), ";") == 0)
	{
		current = (TOKEN)lexer->yylex();
		Statement();
	}
	ReadKeyWord("END");
	cout << "FinBegin" << currentTagNumber << ":" << endl;
	TagNumber++;
}
// LabelList := NUMBER|CHARCONST
enum TYPES LabelList(void)
{
	enum TYPES type;
	if (current == NUMBER)
		type = Number();
	else if (current == CHARCONST)
		type = CharConst();
	else
	{
		Error("Chiffre ou lettre attendue pour CaseLabelList");
	}
	return type;
}
// CaseLabelList := CaseLabelList {"," CaseLabelList}
enum TYPES CaseLabelList(unsigned long CaseTagNumber, unsigned long currentTagNumber)
{
	enum TYPES type1, type2;
	type1 = Factor();
	cout << "\tpopq %rbx" << endl;
	cout << "\tcmpq %rbx, %rdx" << endl;

	cout << "\tje CaseStatement" << currentTagNumber << "_Case" << CaseTagNumber << endl;
	while (current == COMMA)
	{
		current = (TOKEN)lexer->yylex();
		type2 = Factor();
		if (type1 != type2)
		{
			Error("Les types ne sont pas compatibles dans le case");
		}
		cout << "\tpopq %rbx" << endl;
		cout << "\tcmpq %rbx, %rdx" << endl;
		cout << "\tje CaseStatement" << currentTagNumber << "_Case" << CaseTagNumber << endl;
	}
	return type1;
}
// CaseListElement := CaseLabelList ":" Statement
enum TYPES CaseListElement(unsigned long CaseTagNumber, unsigned long currentTagNumber)
{
	enum TYPES type;
	cout << "CaseStatement" << currentTagNumber << "_TestCase" << CaseTagNumber << ":" << endl; // creation etiquette
	type = CaseLabelList(CaseTagNumber, currentTagNumber);
	cout << "\tjmp CaseStatement" << currentTagNumber << "_TestCase" << ++CaseTagNumber << endl;
	cout << "CaseStatement" << currentTagNumber << "_Case" << --CaseTagNumber << ":" << endl;
	if (current != COLON)
		Error("':' attendu");
	current = (TOKEN)lexer->yylex();
	Statement();

	return type;
}
// CaseStatement := CASE Expression OF CaseListElement {";" CaseListElement } ELSE Statement END
void CaseStatement(void)
{
	enum TYPES type1, type2;
	unsigned long currentTagNumber = ++TagNumber;
	unsigned long CaseTagNumber = 0;

	ReadKeyWord("CASE");
	type1 = Expression();
	cout << "CaseStatement" << currentTagNumber << ":" << endl;
	ReadKeyWord("OF");
	cout << "\tpopq %rdx" << endl;
	type2 = CaseListElement(CaseTagNumber, currentTagNumber);
	if (type1 != type2)
	{
		Error("Les types ne sont pas compatibles dans le case");
	}
	while (current == SEMICOLON)
	{
		cout << "\tjmp EndCaseStatement" << currentTagNumber << endl;
		current = (TOKEN)lexer->yylex();
		type2 = CaseListElement(++CaseTagNumber, currentTagNumber);
	}
	cout << "CaseStatement" << currentTagNumber << "_TestCase" << ++CaseTagNumber << ":" << endl; // creation etiquette

	ReadKeyWord("ELSE");
	Statement();

	ReadKeyWord("END");
	cout << "EndCaseStatement" << currentTagNumber << ":" << endl;
}
// DisplayStatement := DISPLAY Expression {"," Expression}
void DisplayStatement(void)
{
	ReadKeyWord("DISPLAY");
	unsigned long currentArrayTagNumber = ++TagNumber;
	unsigned long currentTagNumber = ++TagNumber;
	enum TYPES type;
	enum TYPES typeSizeArray;
	string idarray;
	bool array = false;
	do
	{
		if (current == COMMA)
		{
			current = (TOKEN)lexer->yylex();
		}
		if (current == ID && IsIdArrayDeclared(lexer->YYText()))
		{
			array = true;
			cout << "\t xorq %rbx, %rbx\t\t#reset de rbx" << endl;
			cout << "print_array" << currentArrayTagNumber << ":" << endl;
			idarray = lexer->YYText();
			type = DeclaredVariablesArray[lexer->YYText()];
			Expression();
		}
		else if (current == IDARRAY)
		{
			string sizeArray;								  // la taille du tableau
			string id = IdentifierArray(sizeArray);			  // l'identifiant du tableau
			type = DeclaredVariablesArray[id];				  // le type du tableau
			if (DeclaredVariablesArray[sizeArray] != INTEGER) // la taille doit etre un entier
			{
				Error("Type non entier pour l'indice du tableau");
			}
			DeclaredVariablesArray.erase(sizeArray); // lors de la comparaison DeclaredVariablesArray[sizeArray] declare sizeArray, je le supprime donc une fois le test passé
			cout << "\tleaq " << id << ",%rsi \t\t#je copie l'addresse du tableau" << endl;
			if (IsDeclared(sizeArray.c_str()))
			{
				cout << "\tmovq " << sizeArray << ",%rax\t\t#Initialise rax avec la taille du tableau, la taille est une variable" << endl;
			}
			else
			{
				cout << "\tmovq $" << sizeArray << ",%rax\t\t#Initialise rax avec la taille du tableau, la taille est une constante" << endl;
			}
			cout << "\tmovq $8,%rbx\t\t# Initialise rbx à 8" << endl;
			cout << "\tmulq %rbx\t\t# Multiplie the contenu de rax par 8, car une 1 case fait 8 octets" << endl;
			cout << "\tpushq (%rsi,%rax)\t\t# stock a l'indice donne par rax dans le tableau " << endl;
		}
		else
		{
			type = Expression();
		}
		switch (type)
		{
		case INTEGER:
			cout << "\tpop %rsi\t\t# L'entier a afficher" << endl;
			cout << "\tmovq $FormatString1, %rdi\t\t# \"%llu\\n\"" << endl;
			cout << "\tmovl	$0, %eax" << endl;
			cout << "\tcall printf@PLT" << endl;
			break;

		case BOOLEAN:
			cout << "\tpop %rdx\t\t# Zero : False, non-zero : true" << endl;
			cout << "\tcmpq $0, %rdx" << endl;
			cout << "\tje False" << currentTagNumber << endl;
			cout << "\tmovq $TrueString, %rdi\t\t# \"TRUE\\n\"" << endl;
			cout << "\tjmp Next" << currentTagNumber << endl;
			cout << "False" << currentTagNumber << ":" << endl;
			cout << "\tmovq $FalseString, %rdi\t\t# \"FALSE\\n\"" << endl;
			cout << "Next" << currentTagNumber << ":" << endl;
			cout << "\tcall	printf@PLT" << endl;
			break;
		case DOUBLE:
			cout << "\tmovsd	(%rsp), %xmm0\t\t# &stack top -> %xmm0" << endl;
			cout << "\tmovsd %xmm0, (%rsp)" << endl;
			cout << "\tpop %rsi\t\t# Le double a afficher" << endl;
			cout << "\tmovq $FormatString2, %rdi\t\t# \"%lf\\n\"" << endl;
			cout << "\tmovq	$1, %rax\t\t# DOUBLE" << endl;
			cout << "\tcall	printf@PLT" << endl;
			break;
		case CHAR:
			cout << "\tpop %rsi\t\t# Le char a afficher" << endl;
			cout << "\tmovq $FormatString3, %rdi\t# \"%c\\n\"" << endl;
			cout << "\tmovl	$0, %eax" << endl;
			cout << "\tcall printf@PLT" << endl;
			break;
		default:
			Error("Type non géré pour l'affichage du display.");
			break;
		}
		if (array)
		{
			cout << "\tmovq $32, %rsi \t\t# 32 est le code asci de l'espace" << endl;
			cout << "\tmovq $FormatString3, %rdi\t# \"%c\\n\"" << endl;
			cout << "\tcall printf@PLT" << endl;
			cout << "\taddq $8, %rbx\t\t# j'incremente rbx d'une case soit 8 octets pour passer à la valeur suivante" << endl;
			cout << "\tcmpq " << idarray << "sizeArray, %rbx" << endl;
			cout << "\tjne print_array" << currentArrayTagNumber++ << endl;
			cout << "\txorq %rbx, %rbx \t\t# reset mon compteur rbx" << endl;
			array = false;
		}
	} while (current == COMMA);
	TagNumber = currentArrayTagNumber;
}

// Statement := AssignementStatement | AssignementArrayStatement | AssignmentValueOfArrayStatement | IfStatement | WhileStatement | ForStatement | BlockStatement | CaseStatement | DisplayStatement
void Statement(void)
{
	if (current == ID && !IsIdArrayDeclared(lexer->YYText()))
	{
		AssignementStatement();
	}
	else if (current == ID && IsIdArrayDeclared(lexer->YYText()))
	{
		AssignementArrayStatement();
	}
	else if (current == IDARRAY)
	{
		AssignmentValueOfArrayStatement();
	}
	else if (current == KEYWORD)
	{
		if (strcmp(lexer->YYText(), "IF") == 0)
		{
			IfStatement();
		}
		else if (strcmp(lexer->YYText(), "WHILE") == 0)
		{
			WhileStatement();
		}
		else if (strcmp(lexer->YYText(), "FOR") == 0)
		{
			ForStatement();
		}
		else if (strcmp(lexer->YYText(), "BEGIN") == 0)
		{
			BlockStatement();
		}
		else if (strcmp(lexer->YYText(), "CASE") == 0)
		{
			CaseStatement();
		}
		else if (strcmp(lexer->YYText(), "DISPLAY") == 0)
		{
			DisplayStatement();
		}
		else
		{
			Error("KeyWord attendu !");
		}
	}
}
// StatementPart := Statement {";" Statement} "."
void StatementPart(void)
{
	cout << "\t.text\t\t# The following lines contain the program" << endl;
	cout << "\t.globl main\t# The main function must be visible from outside" << endl;
	cout << "main:\t\t\t# The main function body :" << endl;
	cout << "\t.cfi_startproc" << endl;
	cout << "\tpushq %rbp\t# Save the position of the stack's top" << endl;
	Statement();
	while (current == SEMICOLON)
	{
		current = (TOKEN)lexer->yylex();
		Statement();
	}
	if (current != DOT)
		Error("caractère '.' attendu");
	current = (TOKEN)lexer->yylex();
}

// Program := [VarDeclarationPart] StatementPart
void Program(void)
{
	if (IsKeyWord("VAR"))
		VarDeclarationPart();
	StatementPart();
}

int main(void)
{
	// First version : Source code on standard input and assembly code on standard output
	// Header for gcc assembler / linker
	cout << "\t\t\t# Original was produced by the CERI Compiler and modified by Angelo Adragna L2 CMI Informatique" << endl;
	// Let's proceed to the analysis and code production
	current = (TOKEN)lexer->yylex();
	Program();

	// Trailer for the gcc assembler / linker
	cout << "\tpopq %rbp\t\t# Restore the position of the stack's top" << endl;
	cout << "\tret\t\t\t# Return from main function" << endl;
	cout << "\t.cfi_endproc" << endl;
	if (current != FEOF)
	{
		cerr << "Caractères en trop à la fin du programme : [" << current << "]";
		Error("."); // unexpected characters at the end of program
	}
}
