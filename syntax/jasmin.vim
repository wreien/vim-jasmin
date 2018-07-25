" Vim syntax file
" Language:     Jasmin
" Maintainer:   Nathaniel Shead <natattak@gmail.com>
" Last Change:  2018-05-21

" quit when a syntax file was already loaded
if exists('b:current_syntax')
    finish
endif

" simple directives
syn match jasminDirective "^\s*\.catch"
syn match jasminDirective "^\s*\.class"
syn match jasminDirective "^\s*\.end method"
syn match jasminDirective "^\s*\.implements"
syn match jasminDirective "^\s*\.interface"
syn match jasminDirective "^\s*\.limit\s\%(stack\|locals\)"
syn match jasminDirective "^\s*\.line"
syn match jasminDirective "^\s*\.method"
syn match jasminDirective "^\s*\.source"
syn match jasminDirective "^\s*\.super"
syn match jasminDirective "^\s*\.throws"

" generic instructions
syn match jasminInstruction "[A-Za-z0-9_]\+"

" labels and operators
syn match jasminLabelRef  "[^0-9=:\."[:space:]-][^=:\."[:space:]-]*" contained
syn match jasminLabel     "^[^0-9=:\."[:space:]-][^=:\."[:space:]-]*:"me=e-1
syn match jasminOperator  "[()=:]"

" directives which have special syntax (TODO: catch)
syn region jasminField matchgroup=jasminDirective start="^\s*\.field" end="$" keepend contains=jasminAccess,jasminType,jasminComment
syn region jasminVar matchgroup=jasminDirective start="^\s*\.var\s*\d\+" end="$" keepend contains=jasminVarIs,jasminVarFrom,jasminVarTo,jasminComment

syn region jasminVarIs   matchgroup=jasminVarKW start="\<is\>" end="\%(\<from\>\)\@=" keepend contained contains=jasminType
syn region jasminVarFrom matchgroup=jasminVarKW start="\<from\>" end="\%(\<to\>\)\@=" keepend contained contains=jasminLabelRef
syn region jasminVarTo   matchgroup=jasminVarKW start="\<to\>" end="$" keepend contained contains=jasminLabelRef,jasminComment

" special instructions (TODO: (multi)(a)newarray, lookupswitch, tableswitch)
syn region jasminLabelInstruction matchgroup=jasminInstruction start="^\s*\%(goto\w*\|if\w*\|jsr\w*\)\s\+" end="$" keepend contains=jasminComment,jasminLabelRef
syn region jasminClassInstruction matchgroup=jasminInstruction start="^\s*\%(new\|anewarray\|checkcast\|instanceof\)\>" end="$" keepend contains=jasminComment,jasminMethod
syn region jasminStaticInstruction matchgroup=jasminInstruction start="^\s*\%(\%(get\|put\)\%(field\|static\)\)\s\+" end="$" keepend contains=jasminStaticImpl
syn region jasminStaticImpl matchgroup=jasminMethod start="\S\+\s\+" end="$" keepend contains=jasminComment,jasminType contained

" constants
syn match jasminNumber "\<[+-]\=\d\+"
syn match jasminNumber "\<[+-]\=0[xX]\x\+"
syn match jasminNumber "\<[+-]\=\d\+\.\%(\d\+\)\=\|[+-]\=\.\d\+"
syn match jasminString '".\{-}"'

" types and methods
syn match  jasminType "\%\(\[\)*\%([ZBSICFDV]\|L.\{-};\)" contained contains=jasminMethod
syn match  jasminMethod "\s\h\w*\%(/\h\w*\)*" contained
syn region jasminMethod matchgroup=jasminType start="\%\(\[\)*L" end=";" contained

syn match  jasminMethodParams "(.\{-}).*" contains=jasminType,jasminMethod,jasminOperator,jasminComment
syn region jasminMethodInvoke matchgroup=jasminMethod start="\s\S*(\@=" end="$" contains=jasminMethodParams

" access modifiers
syn keyword jasminAccess public private protected final super interface abstract static volatile transient

" comments
syn region jasminComment start='\%(^\|\s\+\);' end='$' keepend


" define the default highlighting
hi def link jasminDirective Constant
hi def link jasminLabelRef  Identifier
hi def link jasminLabel     Identifier

hi def link jasminOperator  Operator
hi def link jasminNumber    Number
hi def link jasminString    String

hi def link jasminAccess    StorageClass
hi def link jasminType      Type
hi def link jasminMethod    Function
hi def link jasminVarKW     Keyword

hi def link jasminComment   Comment


" set the current syntax type appropriately
let b:current_syntax = 'jasmin'
