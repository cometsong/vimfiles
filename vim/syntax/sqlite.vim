" Vim syntax file
" Language:    SQLite
" Maintainer:  Martin Fixman <martinfixman at gmail dot com>
" Last Change: 2014 Jul 16
" Version:     0.3

" Description: List of keywords used by SQLite.
"
" Adapted From: sqlanywhere.vim on VimScript #498 by David Fishburn <dfishburn dot vim at gmail dot com>
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
"
if version < 600
syntax clear
elseif exists("b:current_syntax")
finish
endif

" Be case sensitive when matching keywords.
" This is contrary to SQLite's (and pretty much every SQL dialect) syntax, but
" it's in line with the usual conventions.  Also, having 'count' or 'sum' as
" column names is common enough to consider this.
syn case ignore

" SQLite keywords, as defined in http://sqlite.org/lang_keywords.html
syn keyword sqlKeyword ABORT ACTION ADD AFTER ALL ALTER ANALYZE AND AS ASC ATTACH
syn keyword sqlKeyword AUTOINCREMENT BEFORE BEGIN BETWEEN BY CASCADE CASE CAST CHECK COLLATE COLUMN
syn keyword sqlKeyword COMMIT CONFLICT CONSTRAINT CREATE CROSS CURRENT_DATE CURRENT_TIME
syn keyword sqlKeyword CURRENT_TIMESTAMP DATABASE DEFAULT DEFERRABLE DEFERRED DELETE DESC DETACH
syn keyword sqlKeyword DISTINCT DROP EACH ELSE END ESCAPE EXCEPT EXCLUSIVE EXISTS EXPLAIN FAIL FOR
syn keyword sqlKeyword FOREIGN FROM FULL GLOB GROUP HAVING IF IGNORE IMMEDIATE IN INDEX INDEXED
syn keyword sqlKeyword INITIALLY INNER INSERT INSTEAD INTERSECT INTO IS ISNULL JOIN KEY LEFT LIKE
syn keyword sqlKeyword LIMIT MATCH NATURAL NO NOT NOTNULL NULL OF OFF OFFSET ON OR ORDER OUTER PLAN
syn keyword sqlKeyword PRAGMA PRIMARY QUERY RAISE RECURSIVE REFERENCES REGEXP REINDEX RELEASE RENAME
syn keyword sqlKeyword REPLACE RESTRICT RIGHT ROLLBACK ROW SAVEPOINT SELECT SET TABLE TEMP TEMPORARY
syn keyword sqlKeyword THEN TO TRANSACTION TRIGGER UNION UNIQUE UPDATE USING VACUUM VALUES VIEW
syn keyword sqlKeyword VIRTUAL WHEN WHERE WITH WITHOUT

" SQLite core functions, as defined in http://sqlite.org/lang_corefunc.html
syn keyword sqlFunction ABS CHANGES CHAR COALESCE GLOB IFNULL INSTR HEX LAST_INSERT_ROWID LENGTH LIKE
syn keyword sqlFunction LIKELIHOOD LOAD_EXTENSION LOWER LTRIM MAX MIN NULLIF PRINTF QUOTE RANDOM
syn keyword sqlFunction RANDOMBLOB REPLACE ROUND RTRIM SOUNDEX SQLITE_COMPILEOPTION_GET
syn keyword sqlFunction SQLITE_COMPILEOPTION_USED SQLITE_SOURCE_ID SQLITE_VERSION SUBSTR TOTAL_CHANGES
syn keyword sqlFunction TRIM TYPEOF UNLIKELY UNICODE UPPER ZEROBLOB

" SQLite aggregate functions, as defined in http://sqlite.org/lang_aggfunc.html
syn keyword sqlFunction AVG COUNT GROUP_CONCAT MAX MIN SUM TOTAL

" SQLite date and time functions, as defined in http://sqlite.org/lang_datefunc.html
syn keyword sqlFunction DATE TIME DATETIME JULIANDAY STRFTIME

" SQLite datatypes, as defined in http://www.sqlite.org/datatype3.html
syn match sqlType '\<\(INTEGER\|TINYINT\|SMALLINT\|MEDIUMINT\|BIGINT\|UNSIGNED BIG INT\|INT2\|INT8\|INT\|CHARACTER\)\>'
syn match sqlType '\<\(VARYING CHARACTER\|NATIVE CHARACTER\|NCHAR\|NVARCHAR\|VARCHAR\|TEXT\|CLOB\)\>'
syn match sqlType '\<BLOB\>'
syn match sqlType '\<\(REAL\|DOUBLE PRECISION\|DOUBLE\|FLOAT\)\>'
syn match sqlType '\<\(NUMERIC\|DECIMAL\|BOOLEAN\|DATETIME\|DATE\)\>'

" SQLite command line options, as defined in http://www.sqlite.org/cli.html
syn match sqlOption '^\(\.backup\|\.bail\|\.clone\|\.databases\|\.dump\|\.echo\|\.eqp\|\.exit\)'
syn match sqlOption '^\(\.explain\|\.headers\|\.help\|\.import\|\.indices\|\.load\|\.log\)'
syn match sqlOption '^\(\.mode\|\.nullvalue\|\.once\|\.open\|\.output\|\.print\|\.prompt\)'
syn match sqlOption '^\(\.quit\|\.read\|\.restore\|\.save\|\.schema\|\.separator\|\.shell\)'
syn match sqlOption '^\(\.show\|\.stats\|\.system\|\.tables\|\.timeout\|\.timer\|\.trace\)'
syn match sqlOption '^\(\.vfsname\|\.width\)'

" Strings and characters:
syn region sqlString		start=+"+    end=+"+ contains=@Spell
syn region sqlString		start=+'+    end=+'+ contains=@Spell

" Identifiers for binding values to arguments, as defined in http://www.sqlite.org/c3ref/bind_blob.html
syn match sqlNumber '?' 
syn match sqlNumber '?[0-9]\{1,3\}' 
syn match sqlNumber '[:@$][a-zA-Z0-9_]\{1,3\}' 

" Numbers:
syn match sqlNumber		"-\=\<\d*\.\=[0-9_]\>"

" Comments:
syn region sqlHashComment	start=/#/ end=/$/ contains=@Spell
syn region sqlDashComment	start=/--/ end=/$/ contains=@Spell
syn region sqlSlashComment	start=/\/\// end=/$/ contains=@Spell
syn region sqlMultiComment	start="/\*" end="\*/" contains=sqlMultiComment,@Spell
syn cluster sqlComment	contains=sqlHashComment,sqlDashComment,sqlSlashComment,sqlMultiComment,@Spell
syn sync ccomment sqlComment
syn sync ccomment sqlHashComment
syn sync ccomment sqlDashComment
syn sync ccomment sqlSlashComment

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sql_syn_inits")
    if version < 508
        let did_sql_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi link <args>
    endif

    HiLink sqlHashComment  Comment
    HiLink sqlDashComment  Comment
    HiLink sqlSlashComment Comment
    HiLink sqlMultiComment Comment
    HiLink sqlNumber       Number
    HiLink sqlOperator     Operator
    HiLink sqlSpecial      Special
    HiLink sqlKeyword      Keyword
    HiLink sqlStatement    Statement
    HiLink sqlString       String
    HiLink sqlType         Type
    HiLink sqlFunction     Function
    HiLink sqlOption       PreProc

    delcommand HiLink
endif

let b:current_syntax = "sqlite"

" vim:sw=4:
