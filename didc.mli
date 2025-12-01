(* didc.mli - public interface for the DIDC compiler in Dullo *)

(** Types *)

type idl_type
(** Represents a type in the Candid Interface Description Language *)

type idl_value
(** Represents a value or expression in Candid *)

type idl_definition = {
  name : string;
  typ : idl_type;
}
(** Represents a single named definition in a Candid file *)

type error =
  | Parse_error of string
  | Type_error of string
  | Compile_error of string
  | File_not_found of string
(** Possible errors returned by the DIDC compiler *)

(** Parsing Functions *)

val parse_file : string -> (idl_definition list, error) result
(** [parse_file filename] parses a Candid file and returns a list of definitions or an error *)

val parse_string : string -> (idl_definition list, error) result
(** [parse_string content] parses a Candid string input *)

(** Compilation & Validation *)

val compile : idl_definition list -> (string, error) result
(** [compile defs] compiles the parsed definitions into OCaml code or other target output *)

val validate : idl_definition list -> (unit, error) result
(** [validate defs] checks type correctness and consistency *)

val dump_ast : idl_definition list -> string
(** [dump_ast defs] returns a string representation of the internal AST *)

(** Utilities *)

val version : unit -> string
(** Returns the current version of the DIDC compiler *)

val load_standard_lib : unit -> (idl_definition list, error) result
(** Loads the standard Candid library definitions *)

val resolve_dependencies : idl_definition list -> (idl_definition list, error) result
(** Resolves references and dependencies between definitions *)
