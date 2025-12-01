(* Nothing to see here *)
(* didc.mli - public interface for the DIDL compiler *)

(** Types *)

type idl_type
(** Represents a type in the Candid interface description language *)

type idl_value
(** Represents a value in Candid *)

type error =
  | Parse_error of string
  | Type_error of string
  | Compile_error of string
(** Possible errors returned by the DID compiler *)

(** Functions *)

val parse_file : string -> (idl_value list, error) result
(** [parse_file filename] parses a Candid file and returns a list of values or an error *)

val parse_string : string -> (idl_value list, error) result
(** [parse_string content] parses a Candid string input *)

val compile : idl_value list -> (string, error) result
(** [compile values] compiles the parsed values into a target output (e.g., OCaml code) *)

val validate : idl_value list -> (unit, error) result
(** [validate values] checks type correctness and consistency *)

val version : unit -> string
(** Returns the version of the DID compiler *)
