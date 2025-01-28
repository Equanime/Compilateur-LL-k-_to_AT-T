// tokeniser.h : shared definition for tokeniser.l and compilateur.cpp

enum TOKEN
{
    FEOF,
    UNKNOWN,
    NUMBER,
    ID,
    IDARRAY,
    CHARCONST,
    RBRACKET,
    LBRACKET,
    RPARENT,
    LPARENT,
    COMMA,
    SEMICOLON,
    DOT,
    COLON,
    ADDOP,
    MULOP,
    RELOP,
    NOT,
    ASSIGN,
    KEYWORD
};
