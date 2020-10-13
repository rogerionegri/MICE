;+
; Copyright (c) Harris Geospatial Solutions, Inc.
;    All rights reserved.
;    Unauthorized reproduction prohibited.
;
; :Description:;
;   Base class that defines persistable objects, providing methods for easily
;   save and restore objects that inherit this class. 
;-------------------------------------------------------------------------------;
; :Arguments:
;-------------------------------------------------------------------------------;
; :Keywords:
;-
function IDL_Persistable::Init
  compile_opt idl2, hidden

  return, 1
end

;-------------------------------------------------------------------------------
pro IDL_Persistable::Cleanup
  compile_opt idl2, hidden
    
end

;-------------------------------------------------------------------------------
pro IDL_Persistable::Save, filename
	compile_opt idl2, hidden

  ON_ERROR, 2
  
  if ~Isa(filename, /SCALAR, 'String') then begin
    Message, 'Filename argument must be a string.', /NoName
  endif
	
	Save, self, FILE=filename
end

;-------------------------------------------------------------------------------
function IDL_Persistable::Restore, filename, VALIDATE=className
	compile_opt idl2, hidden, static

  ON_ERROR, 2
	
	if (Obj_Valid(self)) then begin
		Message, 'Restore is a static method, can not be invoked from an existing object.', /NoName
	endif

	if ~Isa(filename, /SCALAR, 'String') then begin
	  Message, 'Filename argument must be a string.', /NoName
	endif

	if (~File_Test(filename)) then begin
		Message, 'File does not exist.', /NoName
	endif

	Restore, filename
	
	if (~Isa(self)) then begin
	  Message, 'File does not contain a suitable object.', /NoName
	endif

	if (Isa(className, /STRING, /SCALAR) && ~Isa(self, className)) then begin
	  Message, 'File does not contain an object of the class ' + className + '.', /NoName
	endif

	return, self	
end

;-------------------------------------------------------------------------------
pro IDL_Persistable__Define
  compile_opt idl2, hidden

  !null={IDL_Persistable, $
		     void:0b $
	}
end